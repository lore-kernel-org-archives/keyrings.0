From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:48:40 +0000
Subject: [PATCH 11/23] KEYS: fix dereferencing NULL payload with nonzero length
Message-Id: <149692972058.11452.16006332360734138615.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

sys_add_key() and the KEYCTL_UPDATE operation of sys_keyctl() allowed a
NULL payload with nonzero length to be passed to the key type's
->preparse(), ->instantiate(), and/or ->update() methods.  Various key
types including asymmetric, cifs.idmap, cifs.spnego, and pkcs7_test did
not handle this case, allowing an unprivileged user to trivially cause a
NULL pointer dereference (kernel oops) if one of these key types was
present.  Fix it by doing the copy_from_user() when 'plen' is nonzero
rather than when '_payload' is non-NULL, causing the syscall to fail
with EFAULT as expected when an invalid buffer is specified.

Cc: stable@vger.kernel.org # 2.6.10+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/keyctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 447a7d5cee0f..94c2790f8283 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -99,7 +99,7 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 	/* pull the payload in if one was supplied */
 	payload = NULL;
 
-	if (_payload) {
+	if (plen) {
 		ret = -ENOMEM;
 		payload = kvmalloc(plen, GFP_KERNEL);
 		if (!payload)
@@ -324,7 +324,7 @@ long keyctl_update_key(key_serial_t id,
 
 	/* pull the payload in if one was supplied */
 	payload = NULL;
-	if (_payload) {
+	if (plen) {
 		ret = -ENOMEM;
 		payload = kmalloc(plen, GFP_KERNEL);
 		if (!payload)

