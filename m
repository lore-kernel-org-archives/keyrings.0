From: trix@redhat.com
Date: Mon, 19 Oct 2020 17:36:53 +0000
Subject: [PATCH] security: remove unneeded break
Message-Id: <20201019173653.527-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com, jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, dhowells@redhat.com, mortonm@chromium.org
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, Tom Rix <trix@redhat.com>

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/integrity/ima/ima_appraise.c     | 1 -
 security/keys/trusted-keys/trusted_tpm1.c | 1 -
 security/safesetid/lsm.c                  | 3 ---
 3 files changed, 5 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3dd8c2e4314e..f400a6122b3c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -181,7 +181,6 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 		if (sig->version != 2 || xattr_len <= sizeof(*sig))
 			return ima_hash_algo;
 		return sig->hash_algo;
-		break;
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
 		ret = xattr_value->data[0];
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index b9fe02e5f84f..eddc9477d42a 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -901,7 +901,6 @@ static int datablob_parse(char *datablob, struct trusted_key_payload *p,
 		break;
 	case Opt_err:
 		return -EINVAL;
-		break;
 	}
 	return ret;
 }
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 8a176b6adbe5..1079c6d54784 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -125,7 +125,6 @@ static int safesetid_security_capable(const struct cred *cred,
 		pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
 			__kuid_val(cred->uid));
 		return -EPERM;
-		break;
 	case CAP_SETGID:
 		/*
 		* If no policy applies to this task, allow the use of CAP_SETGID for
@@ -140,11 +139,9 @@ static int safesetid_security_capable(const struct cred *cred,
 		pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
 			__kuid_val(cred->uid));
 		return -EPERM;
-		break;
 	default:
 		/* Error, the only capabilities were checking for is CAP_SETUID/GID */
 		return 0;
-		break;
 	}
 	return 0;
 }
-- 
2.18.1
