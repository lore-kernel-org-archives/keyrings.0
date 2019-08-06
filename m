From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 06 Aug 2019 13:49:17 +0000
Subject: [RFC/RFT v3 0/3] KEYS: trusted: Add generic trusted keys framework
Message-Id: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>

This patch-set is an outcome of discussion here [1].

I have tested this framework with trusted keys support provided via TEE
but I wasn't able to test it with a TPM device as I don't possess one. It
would be really helpful if others could test this patch-set using a TPM
device.

[1] https://www.mail-archive.com/linux-doc@vger.kernel.org/msg30591.html

Changes in v3:

Move TPM2 trusted keys code to trusted keys subsystem.

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (3):
  KEYS: trusted: create trusted keys subsystem
  KEYS: trusted: move tpm2 trusted keys code
  KEYS: trusted: Add generic trusted keys framework

 crypto/asymmetric_keys/asym_tpm.c                  |   2 +-
 drivers/char/tpm/tpm-interface.c                   |  56 ---
 drivers/char/tpm/tpm.h                             | 224 ------------
 drivers/char/tpm/tpm2-cmd.c                        | 307 -----------------
 include/keys/trusted-type.h                        |  45 +++
 include/keys/{trusted.h => trusted_tpm.h}          |  42 +--
 include/linux/tpm.h                                | 264 +++++++++++++-
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   8 +
 .../keys/{trusted.c => trusted-keys/trusted-tpm.c} | 363 ++++----------------
 security/keys/trusted-keys/trusted-tpm2.c          | 378 +++++++++++++++++++++
 security/keys/trusted-keys/trusted.c               | 343 +++++++++++++++++++
 12 files changed, 1109 insertions(+), 925 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (72%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (76%)
 create mode 100644 security/keys/trusted-keys/trusted-tpm2.c
 create mode 100644 security/keys/trusted-keys/trusted.c

-- 
2.7.4
