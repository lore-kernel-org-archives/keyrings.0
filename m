From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 18 Jul 2019 11:36:44 +0000
Subject: [RFC/RFT v2 0/2] KEYS: trusted: Add generic trusted keys framework
Message-Id: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>

This patch-set is an outcome of discussion here [1].

I have tested this framework with trusted keys support provided via TEE
but I wasn't able to test it with a TPM device as I don't possess one. It
would be really helpful if others could test this patch-set using a TPM
device.

[1] https://www.mail-archive.com/linux-doc@vger.kernel.org/msg30591.html

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (2):
  KEYS: trusted: create trusted keys subsystem
  KEYS: trusted: Add generic trusted keys framework

 crypto/asymmetric_keys/asym_tpm.c                  |   2 +-
 include/keys/trusted-type.h                        |  45 +++
 include/keys/{trusted.h => trusted_tpm.h}          |  19 +-
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   7 +
 .../keys/{trusted.c => trusted-keys/trusted-tpm.c} | 347 ++++-----------------
 security/keys/trusted-keys/trusted.c               | 343 ++++++++++++++++++++
 7 files changed, 458 insertions(+), 307 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (85%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (77%)
 create mode 100644 security/keys/trusted-keys/trusted.c

-- 
2.7.4
