From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:36 +0000
Subject: [PATCH v2 7/7] typos: fix various typos
Message-Id: <20180927131436.23328-8-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 dns.afsdb.c              | 2 +-
 key.dns_resolver.c       | 2 +-
 keyctl.c                 | 2 +-
 man/keyctl.1             | 2 +-
 man/keyctl_instantiate.3 | 2 +-
 request-key.c            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/dns.afsdb.c b/dns.afsdb.c
index 064d9c8..fa60e04 100644
--- a/dns.afsdb.c
+++ b/dns.afsdb.c
@@ -10,7 +10,7 @@
  * of the kernel, and converting the VL server addresses to IPv4 format so that
  * they can be used by the kAFS filesystem.
  *
- * As some function like res_init() should use the static liberary, which is a
+ * As some function like res_init() should use the static library, which is a
  * bug of libresolv, that is the reason for cifs.upcall to reimplement.
  *
  * To use this program, you must tell /sbin/request-key how to invoke it.  You
diff --git a/key.dns_resolver.c b/key.dns_resolver.c
index 04a43ab..4ac27d3 100644
--- a/key.dns_resolver.c
+++ b/key.dns_resolver.c
@@ -13,7 +13,7 @@
  *
  * 	cc -o key.dns_resolver key.dns_resolver.c -lresolv -lkeyutils
  *
- * As some function like res_init() should use the static liberary, which is a
+ * As some function like res_init() should use the static library, which is a
  * bug of libresolv, that is the reason for cifs.upcall to reimplement.
  *
  * To use this program, you must tell /sbin/request-key how to invoke it.  You
diff --git a/keyctl.c b/keyctl.c
index 50ece20..8466dc6 100644
--- a/keyctl.c
+++ b/keyctl.c
@@ -2241,7 +2241,7 @@ static int dump_key_tree_aux(key_serial_t key, int depth, int more, int hex_key_
 		do {
 			key = *pk++;
 
-			/* recurse into nexted keyrings */
+			/* recurse into next keyrings */
 			if (strcmp(type, "keyring") = 0) {
 				if (depth = 0) {
 					rdepth = depth;
diff --git a/man/keyctl.1 b/man/keyctl.1
index 0360bf0..a3d7a35 100644
--- a/man/keyctl.1
+++ b/man/keyctl.1
@@ -731,7 +731,7 @@ The shared secret is derived as outlined above and is input to the KDF
 using the specified hash type. The hash type must point to a hash name
 known to the kernel crypto API.
 
-The operation derves key material of the length specified by the caller.
+The operation derives key material of the length specified by the caller.
 
 The operation is compliant to the specification of SP800-56A.
 
diff --git a/man/keyctl_instantiate.3 b/man/keyctl_instantiate.3
index 5ea3b98..d436bf2 100644
--- a/man/keyctl_instantiate.3
+++ b/man/keyctl_instantiate.3
@@ -37,7 +37,7 @@ assumes the authority for the calling thread to deal with and instantiate the
 specified uninstantiated
 .IR key .
 .P
-The calling thread must have the appopriate authorisation key resident in one
+The calling thread must have the appropriate authorisation key resident in one
 of its keyrings for this to succeed, and that authority must not have been
 revoked.
 .P
diff --git a/request-key.c b/request-key.c
index 293fa2f..bf47c0a 100644
--- a/request-key.c
+++ b/request-key.c
@@ -13,7 +13,7 @@
  * Searches the specified session ring for a key indicating the command to run:
  *	type:	"user"
  *	desc:	"request-key:<op>"
- *	data:	command name, eg: "/home/dhowells/request-key-create.sh"
+ *	data:	command name, e.g.: "/home/dhowells/request-key-create.sh"
  */
 
 #include <stdio.h>
-- 
2.19.0.221.g150f307afc
