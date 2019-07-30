From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 30 Jul 2019 12:35:34 +0000
Subject: [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: tee-dev@lists.linaro.org, daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>, corbet@lwn.net, jejb@linux.ibm.com, ard.biesheuvel@linaro.org, linux-doc@vger.kernel.org, jmorris@namei.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, casey@schaufler-ca.com, jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key. Also, this is
an alternative in case platform doesn't possess a TPM device.

This series also adds some TEE features like:

Patch #1, #2 enables support for registered kernel shared memory with TEE.

Patch #3 enables support for private kernel login method required for
cases like trusted keys where we don't wan't user-space to directly access
TEE service to retrieve trusted key contents.

Rest of the patches from #4 to #6 adds support for TEE based trusted keys.

This patch-set has been tested with OP-TEE based pseudo TA which can be
found here [1].

Also, this patch-set is dependent on generic Trusted Keys framework
patch-set [2].

[1] https://github.com/OP-TEE/optee_os/pull/3082
[2] https://lkml.org/lkml/2019/7/18/284

Changes in v2:
1. Add reviewed-by tags for patch #1 and #2.
2. Incorporate comments from Jens for patch #3.
3. Switch to use generic trusted keys framework.

Sumit Garg (6):
  tee: optee: allow kernel pages to register as shm
  tee: enable support to register kernel memory
  tee: add private login method for kernel clients
  KEYS: trusted: Introduce TEE based Trusted Keys
  doc: keys: Document usage of TEE based Trusted Keys
  MAINTAINERS: Add entry for TEE based Trusted Keys

 Documentation/security/keys/index.rst       |   1 +
 Documentation/security/keys/tee-trusted.rst |  93 +++++++++
 MAINTAINERS                                 |   9 +
 drivers/tee/optee/call.c                    |   7 +
 drivers/tee/tee_core.c                      |   6 +
 drivers/tee/tee_shm.c                       |  16 +-
 include/keys/trusted-type.h                 |   3 +
 include/keys/trusted_tee.h                  |  66 +++++++
 include/linux/tee_drv.h                     |   1 +
 include/uapi/linux/tee.h                    |   8 +
 security/keys/Kconfig                       |   3 +
 security/keys/trusted-keys/Makefile         |   3 +-
 security/keys/trusted-keys/trusted-tee.c    | 282 ++++++++++++++++++++++++++++
 security/keys/trusted-keys/trusted.c        |   3 +
 14 files changed, 498 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/security/keys/tee-trusted.rst
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted-tee.c

-- 
2.7.4
