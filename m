From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 23 Oct 2019 00:18:13 +0000
Subject: [PATCH v1 1/6] KEYS: Helper function to check if the given keyring is builtin_trusted_keys
Message-Id: <20191023001818.3684-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
In-Reply-To: <20191023001818.3684-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Cc: nramas@linux.microsoft.com

Helper function to check if the given keyring is
the builtin_trusted_keys keyring.

This function is used by ima to determine if a key is
added to the builtin_trusted_keys keyring.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 certs/system_keyring.c        | 5 +++++
 include/keys/system_keyring.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 1eba08a1af82..5533c7f92fef 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -283,3 +283,8 @@ void __init set_platform_trusted_keys(struct key *keyring)
 	platform_trusted_keys = keyring;
 }
 #endif
+
+inline bool is_builtin_trusted_keyring(struct key *keyring)
+{
+	return (keyring = builtin_trusted_keys);
+}
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index c1a96fdf598b..2bc0aaa07f05 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -66,4 +66,6 @@ static inline void set_platform_trusted_keys(struct key *keyring)
 }
 #endif
 
+extern bool is_builtin_trusted_keyring(struct key *keyring);
+
 #endif /* _KEYS_SYSTEM_KEYRING_H */
-- 
2.17.1
