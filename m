From: Denis Kenzior <denkenz@gmail.com>
Date: Mon, 20 Aug 2018 21:52:25 +0000
Subject: [PATCH 1/2] asym_tpm: Fix tpm_flushspecific return value
Message-Id: <20180820215226.20661-2-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

The return value from tpm_flushspecific is uint32_t, but is used in
later patches like an int.  This was reported by smatch:

	crypto/asymmetric_keys/asym_tpm.c:728 tpm_key_sign() warn:
	unsigned 'tpm_flushspecific(tb, keyhandle)' is never less
	than zero.

Fixes: 9312b38b585d KEYS: asym_tpm: Add loadkey2 and flushspecific
Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 crypto/asymmetric_keys/asym_tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 3753c2f1c4e9..cb7e55b8859f 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -99,7 +99,7 @@ static int tpm_loadkey2(struct tpm_buf *tb,
 /*
  * Execute the FlushSpecific TPM command
  */
-static uint32_t tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
+static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
 {
 	INIT_BUF(tb);
 	store16(tb, TPM_TAG_RQU_COMMAND);
-- 
2.16.1
