From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Aug 2019 12:59:43 +0000
Subject: [PATCH v5 0/4] Create and consolidate trusted keys subsystem
Message-Id: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>

This patch-set does restructuring of trusted keys code to create and
consolidate trusted keys subsystem.

Changes in v5:
1. Drop 5/5 patch as its more relavant along with TEE patch-set.
2. Add Reviewed-by tag for patch #2.
3. Fix build failure when "CONFIG_HEADER_TEST" and
   "CONFIG_KERNEL_HEADER_TEST" config options are enabled.
4. Misc changes to rename files.

Changes in v4:
1. Separate patch for export of tpm_buf code to include/linux/tpm.h
2. Change TPM1.x trusted keys code to use common tpm_buf
3. Keep module name as trusted.ko only

Changes in v3:

Move TPM2 trusted keys code to trusted keys subsystem.

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (4):
  tpm: move tpm_buf code to include/linux/
  KEYS: trusted: use common tpm_buf for TPM1.x code
  KEYS: trusted: create trusted keys subsystem
  KEYS: trusted: move tpm2 trusted keys code

 crypto/asymmetric_keys/asym_tpm.c                  |   2 +-
 drivers/char/tpm/tpm-chip.c                        |   1 +
 drivers/char/tpm/tpm-interface.c                   |  56 ---
 drivers/char/tpm/tpm.h                             | 230 -------------
 drivers/char/tpm/tpm2-cmd.c                        | 308 +----------------
 include/Kbuild                                     |   1 -
 include/keys/{trusted.h => trusted_tpm.h}          |  49 +--
 include/linux/tpm.h                                | 270 ++++++++++++++-
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   8 +
 .../{trusted.c => trusted-keys/trusted_tpm1.c}     |  92 +++--
 security/keys/trusted-keys/trusted_tpm2.c          | 378 +++++++++++++++++++++
 12 files changed, 697 insertions(+), 700 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (77%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (94%)
 create mode 100644 security/keys/trusted-keys/trusted_tpm2.c

-- 
2.7.4
