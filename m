From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:50 +0000
Subject: [PATCH 5/5] dns_key: add a function to verify the key description
Message-Id: <20180927131450.23458-6-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 net/dns_resolver/dns_key.c | 44 ++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 7f4534828f6c..7366f12c7e51 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -45,6 +45,31 @@ const struct cred *dns_resolver_cache;
 
 #define	DNS_ERRORNO_OPTION	"dnserror"
 
+/*
+ * The description must be of an optional type prefix and colon followed by the
+ * name to lookup. By default, the query type is a hostname to IP lookup.
+ */
+static int
+dns_resolver_vet_description(const char *desc)
+{
+	if (!*desc)
+		return -EINVAL;
+	if (*desc = ':')
+		return -EINVAL;
+	for (; *desc; desc++)
+		if (*desc = ':')
+			goto found_colon;
+	goto no_colon;
+
+found_colon:
+	desc++;
+	if (!*desc)
+		return -EINVAL;
+
+no_colon:
+	return 0;
+}
+
 /*
  * Preparse instantiation data for a dns_resolver key.
  *
@@ -252,15 +277,16 @@ static long dns_resolver_read(const struct key *key,
 }
 
 struct key_type key_type_dns_resolver = {
-	.name		= "dns_resolver",
-	.preparse	= dns_resolver_preparse,
-	.free_preparse	= dns_resolver_free_preparse,
-	.instantiate	= generic_key_instantiate,
-	.match_preparse	= dns_resolver_match_preparse,
-	.revoke		= user_revoke,
-	.destroy	= user_destroy,
-	.describe	= dns_resolver_describe,
-	.read		= dns_resolver_read,
+	.name			= "dns_resolver",
+	.vet_description	= dns_resolver_vet_description,
+	.preparse		= dns_resolver_preparse,
+	.free_preparse		= dns_resolver_free_preparse,
+	.instantiate		= generic_key_instantiate,
+	.match_preparse		= dns_resolver_match_preparse,
+	.revoke			= user_revoke,
+	.destroy		= user_destroy,
+	.describe		= dns_resolver_describe,
+	.read			= dns_resolver_read,
 };
 
 static int __init init_dns_resolver(void)
-- 
2.17.1
