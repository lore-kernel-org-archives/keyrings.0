From: Marcus Huewe <suse-tux@gmx.de>
Date: Fri, 12 Jun 2020 11:25:33 +0000
Subject: [PATCH] keys: Do not check the retval of commit_creds in join_session_keyring
Message-Id: <c8ccba0bbcb9147fb220fd18b3b5e1e951b6d5fd.1591960478.git.suse-tux@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <044b34c4388405e995e38fb57fc120361bf962db.1568124150.git.suse-tux@gmx.de>
In-Reply-To: <044b34c4388405e995e38fb57fc120361bf962db.1568124150.git.suse-tux@gmx.de>
To: dhowells@redhat.com, jarkko.sakkinen@linux.intel.com
Cc: keyrings@vger.kernel.org

Do not check the return value of the commit_creds call in
join_session_keyring in order to make the code more concise.
Since commit_creds always returns 0, the if-statement is not needed
and the session keyring's serial can be directly assigned to the
"ret" variable.

Signed-off-by: Marcus Huewe <suse-tux@gmx.de>
---
 security/keys/process_keys.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 09541de31f2f..e7cd1ff84709 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -840,7 +840,7 @@ long join_session_keyring(const char *name)
 	const struct cred *old;
 	struct cred *new;
 	struct key *keyring;
-	long ret, serial;
+	long ret;

 	new = prepare_creds();
 	if (!new)
@@ -853,10 +853,8 @@ long join_session_keyring(const char *name)
 		if (ret < 0)
 			goto error;

-		serial = new->session_keyring->serial;
-		ret = commit_creds(new);
-		if (ret == 0)
-			ret = serial;
+		ret = new->session_keyring->serial;
+		commit_creds(new);
 		goto okay;
 	}

--
2.26.2
