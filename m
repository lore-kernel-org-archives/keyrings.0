From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 28 Sep 2018 21:53:42 +0000
Subject: [PATCH v11 03/12] keys: export lookup_user_key to external users
Message-Id: <153817162279.17152.10685912328747044191.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153817140052.17152.8594371908103118425.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153817140052.17152.8594371908103118425.stgit@djiang5-desk3.ch.intel.com>
To: dan.j.williams@intel.com
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Export lookup_user_key() symbol in order to allow nvdimm passphrase
update to retrieve user injected keys.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: David Howells <dhowells at redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/key.h          |    3 +++
 security/keys/internal.h     |    2 --
 security/keys/process_keys.c |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index e58ee10f6e58..7099985e35a9 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -346,6 +346,9 @@ static inline key_serial_t key_serial(const struct key *key)
 
 extern void key_set_timeout(struct key *, unsigned);
 
+extern key_ref_t lookup_user_key(key_serial_t id, unsigned long flags,
+				 key_perm_t perm);
+
 /*
  * The permissions required on a key that we're looking up.
  */
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9f8208dc0e55..9968b21a76dd 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -158,8 +158,6 @@ extern struct key *request_key_and_link(struct key_type *type,
 
 extern bool lookup_user_key_possessed(const struct key *key,
 				      const struct key_match_data *match_data);
-extern key_ref_t lookup_user_key(key_serial_t id, unsigned long flags,
-				 key_perm_t perm);
 #define KEY_LOOKUP_CREATE	0x01
 #define KEY_LOOKUP_PARTIAL	0x02
 #define KEY_LOOKUP_FOR_UNLINK	0x04
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index d5b25e535d3a..ec4fd4531224 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -755,6 +755,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 	put_cred(ctx.cred);
 	goto try_again;
 }
+EXPORT_SYMBOL(lookup_user_key);
 
 /*
  * Join the named keyring as the session keyring if possible else attempt to
