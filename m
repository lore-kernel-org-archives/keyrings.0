From: David Howells <dhowells@redhat.com>
Date: Thu, 13 Sep 2018 16:09:01 +0000
Subject: [PATCH 1/6] dns: Allow the dns resolver to retrieve a server set
Message-Id: <153685494161.16086.536892492442787707.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-10"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Allow the DNS resolver to retrieve a set of servers and their associated
addresses, ports, preference and weight ratings.

In terms of communication with userspace, "srv=3D1" is added to the callout
string (the '1' indicating the maximum data version supported by the
kernel) to ask the userspace side for this.

If the userspace side doesn't recognise it, it will ignore the option and
return the usual text address list.

If the userspace side does recognise it, it will return some binary data
that begins with a zero byte that would cause the string parsers to give an
error.  The second byte contains the version of the data in the blob (this
may be between 1 and the version specified in the callout data).  The
remainder of the payload is version-specific.

In version 1, the payload looks like (note that this is packed):

	u8	Non-string marker (ie. 0)
	u8	Content (0 =3D> Server list)
	u8	Version (ie. 1)
	u8	Number of servers
	foreach-server {
		u16	Name length (LE)
		u16	Priority (as per SRV record) (LE)
		u16	Weight (as per SRV record) (LE)
		u16	Port (LE)
		u8	Protocol (IPPROTO_*)
		u8	Number of addresses
		char[]	Name (not NUL-terminated)
		foreach-address {
			u8		Family (AF_INET{,6})
			union {
				u8[4]	ipv4_addr
				u8[16]	ipv6_addr
			}
		}
	}

This can then be used to fetch a whole cell's configuration for AFS, for
example.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/dns_resolver/dns_key.c   |   61 ++++++++++++++++++++++++++++++++++++++=
++--
 net/dns_resolver/dns_query.c |    5 +--
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 7f4534828f6c..ac3c9aa75727 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -48,14 +48,40 @@ const struct cred *dns_resolver_cache;
 /*
  * Preparse instantiation data for a dns_resolver key.
  *
- * The data must be a NUL-terminated string, with the NUL char accounted in
- * datalen.
+ * For normal hostname lookups, the data must be a NUL-terminated string, =
with
+ * the NUL char accounted in datalen.
  *
  * If the data contains a '#' characters, then we take the clause after ea=
ch
  * one to be an option of the form 'key=3Dvalue'.  The actual data of inte=
rest is
  * the string leading up to the first '#'.  For instance:
  *
  *        "ip1,ip2,...#foo=BAr"
+ *
+ * For server list requests, the data must begin with a NUL char and be
+ * followed by a byte indicating the version of the data format.  Version 1
+ * looks something like (note this is packed):
+ *
+ *	u8      Non-string marker (ie. 0)
+ *	u8	Content (0 is server list)
+ *	u8	Version (ie. 1)
+ *	u8	Number of servers
+ *	foreach-server {
+ *		u16	Name length (LE)
+ *		u16	Priority (as per SRV record, low first) (LE)
+ *		u16	Weight (as per SRV record, higher first) (LE)
+ *		u16	Port (LE)
+ *		u8	Protocol (IPPROTO_*)
+ *		u8	Number of addresses
+ *		char[]	Name (not NUL-terminated)
+ *		foreach-address {
+ *			u8		Family (AF_INET{,6})
+ *			union {
+ *				u8[4]	ipv4_addr
+ *				u8[16]	ipv6_addr
+ *			}
+ *		}
+ *	}
+ *
  */
 static int
 dns_resolver_preparse(struct key_preparsed_payload *prep)
@@ -66,9 +92,37 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 	int datalen =3D prep->datalen, result_len =3D 0;
 	const char *data =3D prep->data, *end, *opt;
=20
+	if (datalen <=3D 1 || !data)
+		return -EINVAL;
+
+	if (data[0] =3D 0) {
+		/* It may be a server list. */
+		if (datalen <=3D 3)
+			return -EINVAL;
+
+		data++;
+		kenter("[%u,%u],%u", data[0], data[1], datalen);
+		if (data[0] !=3D 0) {
+			pr_warn_ratelimited(
+				"dns_resolver: Unsupported result type (%u)\n",
+				(unsigned char)data[0]);
+			return -EINVAL;
+		}
+
+		if (data[1] !=3D 1) {
+			pr_warn_ratelimited(
+				"dns_resolver: Unsupported server list version (%u)\n",
+				(unsigned char)data[1]);
+			return -EINVAL;
+		}
+
+		result_len =3D datalen - 1;
+		goto store_result;
+	}
+
 	kenter("'%*.*s',%u", datalen, datalen, data, datalen);
=20
-	if (datalen <=3D 1 || !data || data[datalen - 1] !=3D '\0')
+	if (!data || data[datalen - 1] !=3D '\0')
 		return -EINVAL;
 	datalen--;
=20
@@ -144,6 +198,7 @@ dns_resolver_preparse(struct key_preparsed_payload *pre=
p)
 		return 0;
 	}
=20
+store_result:
 	kdebug("store result");
 	prep->quotalen =3D result_len;
=20
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 49da67034f29..76338c38738a 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -148,12 +148,9 @@ int dns_query(const char *type, const char *name, size=
_t namelen,
=20
 	if (_result) {
 		ret =3D -ENOMEM;
-		*_result =3D kmalloc(len + 1, GFP_KERNEL);
+		*_result =3D kmemdup_nul(upayload->data, len, GFP_KERNEL);
 		if (!*_result)
 			goto put;
-
-		memcpy(*_result, upayload->data, len);
-		(*_result)[len] =3D '\0';
 	}
=20
 	if (_expiry)
