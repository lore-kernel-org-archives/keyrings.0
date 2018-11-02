From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 02 Nov 2018 23:15:10 +0000
Subject: [PATCH] KEYS: always initialize keyring_index_key::desc_len
Message-Id: <20181102231510.15911-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <000000000000a722550577796543@google.com>
In-Reply-To: <000000000000a722550577796543@google.com>
To: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

From: Eric Biggers <ebiggers@google.com>

syzbot hit the 'BUG_ON(index_key->desc_len = 0);' in __key_link_begin()
called from construct_alloc_key() during sys_request_key(), because the
length of the key description was never calculated.

The problem is that we rely on ->desc_len being initialized by
search_process_keyrings(), specifically by search_nested_keyrings().
But, if the process isn't subscribed to any keyrings that never happens.

Fix it by always initializing keyring_index_key::desc_len as soon as the
description is set, like we already do in some places.

The following program reproduces the BUG_ON() when it's run as root and
no session keyring has been installed.  If it doesn't work, try removing
pam_keyinit.so from /etc/pam.d/login and rebooting.

    #include <stdlib.h>
    #include <unistd.h>
    #include <keyutils.h>

    int main(void)
    {
            int id = add_key("keyring", "syz", NULL, 0, KEY_SPEC_USER_KEYRING);

            keyctl_setperm(id, KEY_OTH_WRITE);
            setreuid(5000, 5000);
            request_key("user", "desc", "", id);
    }

Reported-by: syzbot+ec24e95ea483de0a24da@syzkaller.appspotmail.com
Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Cc: <stable@vger.kernel.org> # v3.13+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/keyring.c          | 4 +---
 security/keys/proc.c             | 1 +
 security/keys/request_key.c      | 1 +
 security/keys/request_key_auth.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 41bcf57e96f2..99a55145ddcd 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -661,9 +661,6 @@ static bool search_nested_keyrings(struct key *keyring,
 	BUG_ON((ctx->flags & STATE_CHECKS) = 0 ||
 	       (ctx->flags & STATE_CHECKS) = STATE_CHECKS);
 
-	if (ctx->index_key.description)
-		ctx->index_key.desc_len = strlen(ctx->index_key.description);
-
 	/* Check to see if this top-level keyring is what we are looking for
 	 * and whether it is valid or not.
 	 */
@@ -914,6 +911,7 @@ key_ref_t keyring_search(key_ref_t keyring,
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
 		.index_key.description	= description,
+		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 5af2934965d8..909f6c5270a1 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -168,6 +168,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	struct keyring_search_context ctx = {
 		.index_key.type		= key->type,
 		.index_key.description	= key->description,
+		.index_key.desc_len	= strlen(key->description),
 		.cred			= m->file->f_cred,
 		.match_data.cmp		= lookup_user_key_possessed,
 		.match_data.raw_data	= key,
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 114f7408feee..738553698649 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -545,6 +545,7 @@ struct key *request_key_and_link(struct key_type *type,
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
 		.index_key.description	= description,
+		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 424e1d90412e..6797843154f0 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -246,7 +246,7 @@ struct key *key_get_instantiation_authkey(key_serial_t target_id)
 	struct key *authkey;
 	key_ref_t authkey_ref;
 
-	sprintf(description, "%x", target_id);
+	ctx.index_key.desc_len = sprintf(description, "%x", target_id);
 
 	authkey_ref = search_process_keyrings(&ctx);
 
-- 
2.19.1.930.g4563a0d9d0-goog
