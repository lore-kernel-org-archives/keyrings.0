From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 27 Aug 2019 19:18:24 +0000
Subject: [PATCH keys-next] keys: Fix permissions assigned to anonymous session keyrings
Message-Id: <20190827191824.259566-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190814224106.GG101319@gmail.com>
In-Reply-To: <20190814224106.GG101319@gmail.com>
To: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>

From: Eric Biggers <ebiggers@google.com>

JOIN permission was incorrectly removed from anonymous session keyrings
when the old-style key permissions were translated to an ACL, thus
breaking 'keyctl new_session'.

Fixes: f802f2b3a991 ("keys: Replace uid/gid/perm permissions checking with an ACL")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/process_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index aa3bfcadbc6600..519c94f1cc3c2c 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -58,7 +58,7 @@ static struct key_acl session_keyring_acl = {
 	.possessor_viewable = true,
 	.nr_ace	= 2,
 	.aces = {
-		KEY_POSSESSOR_ACE(KEY_ACE__PERMS & ~KEY_ACE_JOIN),
+		KEY_POSSESSOR_ACE(KEY_ACE__PERMS),
 		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
 	}
 };
-- 
2.23.0.187.g17f5b7556c-goog
