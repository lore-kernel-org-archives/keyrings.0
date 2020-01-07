From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Tue, 07 Jan 2020 19:43:46 +0000
Subject: [PATCH 0/4] KEYS: Measure keys when they are created or updated
Message-Id: <20200107194350.3782-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

commit 88e70da170e8 ("IMA: Define an IMA hook to measure keys")
in next-integrity added an IMA hook to measure keys when they
are created or updated in the system. This hook is defined in
ima_asymmetric_keys.c which was built if
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was defined.
But this config is a tristate (and not a bool type).
If CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was set to "m" in
the .config, ima_asymmetric_keys.c was built as a kernel module
when it is not a kernel module. This issue was reported by
"kbuild test robot <lkp@intel.com>".

This change defines a new config namely
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS to enable building
ima_asymmetric_keys.c. This new config is enabled when both
CONFIG_IMA and CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE are defined.

Lakshmi Ramasubramanian (4):
  IMA: Define an IMA hook to measure keys
  KEYS: Call the IMA hook to measure keys
  IMA: Add support to limit measuring keys
  IMA: Read keyrings= option from the IMA policy

 Documentation/ABI/testing/ima_policy         | 10 ++-
 include/linux/ima.h                          | 14 +++
 security/integrity/ima/Kconfig               |  9 ++
 security/integrity/ima/Makefile              |  1 +
 security/integrity/ima/ima.h                 |  8 +-
 security/integrity/ima/ima_api.c             |  8 +-
 security/integrity/ima/ima_appraise.c        |  4 +-
 security/integrity/ima/ima_asymmetric_keys.c | 58 +++++++++++++
 security/integrity/ima/ima_main.c            |  9 +-
 security/integrity/ima/ima_policy.c          | 91 ++++++++++++++++++--
 security/keys/key.c                          | 10 +++
 11 files changed, 204 insertions(+), 18 deletions(-)
 create mode 100644 security/integrity/ima/ima_asymmetric_keys.c

-- 
2.17.1
