From: David Howells <dhowells@redhat.com>
Date: Thu, 30 May 2019 17:26:09 +0000
Subject: [PATCH 08/10] keys: Grant Link permission to possessers of request_key auth keys [ver #2]
Message-Id: <155923716995.949.7037346392947998625.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155923711088.949.14909672457214372214.stgit@warthog.procyon.org.uk>
In-Reply-To: <155923711088.949.14909672457214372214.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org
Cc: James Morris <jamorris@linux.microsoft.com>, dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, ebiggers@kernel.org

Grant Link permission to the possessers of request_key authentication keys,
thereby allowing a daemon that is servicing upcalls to arrange things such
that only the necessary auth key is passed to the actual service program
and not all the daemon's pending auth keys.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
---

 security/keys/request_key_auth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 572c7a60473a..ec5226557023 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -204,7 +204,7 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 
 	authkey = key_alloc(&key_type_request_key_auth, desc,
 			    cred->fsuid, cred->fsgid, cred,
-			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
+			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH | KEY_POS_LINK |
 			    KEY_USR_VIEW, KEY_ALLOC_NOT_IN_QUOTA, NULL);
 	if (IS_ERR(authkey)) {
 		ret = PTR_ERR(authkey);
