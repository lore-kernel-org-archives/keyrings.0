From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Sat, 02 Sep 2017 04:40:26 +0000
Subject: [PATCH v2 5/6] keyctl.2: document KEYCTL_RESTRICT_KEYRING operation
Message-Id: <20170902044026.GA7710@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 man2/keyctl.2 | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/man2/keyctl.2 b/man2/keyctl.2
index 28d15a3..bbd85ce 100644
--- a/man2/keyctl.2
+++ b/man2/keyctl.2
@@ -1537,6 +1537,60 @@ and should contain zeroes since Linux 4.13.
 .IP
 The KDF implementation complies with SP800-56A as well
 as with SP800-108 (the counter KDF).
+.TP
+.BR KEYCTL_RESTRICT_KEYRING " (since Linux 4.12)"
+.\" commit 6563c91fd645556c7801748f15bc727c77fcd311
+.\" commit 7228b66aaf723a623e578aa4db7d083bb39546c9
+Apply a key linking restriction to a keyring with the ID provided in
+.IR arg2 .
+(cast to
+.IR key_serial_t ).
+The caller must have
+.IR setattr
+permission on the key.
+If
+.I arg3
+is NULL, any attempt to add a key to the keyring is blocked;
+otherwise it contains a pointer to a string with a key type name and
+.I arg4
+contains a pointer to string that describes the type-specific restriction.
+As of Linux 4.12, only type "asymmetric" has the restrictions defined:
+.RS
+.TP
+.B builtin_trusted
+Allows only keys that are signed by a key linked to the builtin keyring
+(".builtin_trusted_keys").
+.TP
+.B builtin_and_secondary_trusted
+Allows only keys that are signed by a key linked to the secondary keyring
+(".secondary_trusted_keys") or, by extension, a key in builtin keyring,
+as the latter is linked to the former.
+.TP
+.BI key_or_keyring: key
+.TQ
+.BI key_or_keyring: key :chain
+If
+.I key
+specifies ID of a key of type "asymmetric", then only keys that are signed
+by this key are allowed.
+.IP
+If
+.I key
+specifies ID of a keyring, then only keys that are signed by a key linked
+to this keyring are allowed.
+.IP
+If ":chain" is specified, keys that are signed by a keys linked to the
+destination keyring (that is, the keyring with ID specified in the
+.I arg2
+argument) are also allowed.
+.RE
+.IP
+Note that a restriction can be configured only once for the specific keyring;
+once it is set, it can't be overridden.
+.IP
+The argument
+.I arg5
+is ignored.
 .SH RETURN VALUE
 For a successful call, the return value depends on the operation:
 .TP
@@ -1604,10 +1658,24 @@ was
 .BR KEYCTL_LINK
 and the requested link would result in a cycle.
 .TP
+.B EDEADLK
+.I operation
+was
+.BR KEYCTL_RESTRICT_KEYRING
+and the requested keyring restriction would result in a cycle.
+.TP
 .B EDQUOT
 The key quota for the caller's user would be exceeded by creating a key or
 linking it to the keyring.
 .TP
+.B EEXIST
+.I operation
+was
+.BR KEYCTL_RESTRICT_KEYRING
+and keyring provided in
+.I arg2
+argument already has a restriction set.
+.TP
 .B EFAULT
 .I operation
 was
@@ -1776,6 +1844,14 @@ pointed by
 .I arg5
 argument hasn't been found.
 .TP
+.B ENOENT
+.I operation
+was
+.B KEYCTL_RESTRICT_KEYRING
+and the type provided in
+.I arg3
+argument doesn't support setting key linking restrictions.
+.TP
 .B ENOKEY
 No matching key was found or an invalid key was specified.
 .TP
@@ -1808,6 +1884,17 @@ was
 .B KEYCTL_UPDATE
 and the key type does not support updating.
 .TP
+.B EOPNOTSUPP
+.I operation
+was
+.BR KEYCTL_RESTRICT_KEYRING ,
+the type provided in
+.I arg3
+argument was "asymmetric", and the key specified in the restriction specification
+provided in
+.I arg4
+has type other than "asymmetric" or "keyring".
+.TP
 .B EPERM
 .I operation
 was
-- 
2.1.4

