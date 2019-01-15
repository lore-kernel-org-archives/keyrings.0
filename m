From: Kairui Song <kasong@redhat.com>
Date: Tue, 15 Jan 2019 09:45:40 +0000
Subject: [RFC PATCH v2 0/2] let kexec_file_load use platform keyring to verify the kernel image
Message-Id: <20190115094542.17129-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>

Hi,

This patch series adds a .platform_trusted_keys in system_keyring as the
reference to .platform keyring in integrity subsystem, when platform
keyring is being initialized it will be updated. So other component could
use this keyring as well.

This patch series also let kexec_file_load use platform keyring as fall
back if it failed to verify the image against secondary keyring, make it
possible to load kernel signed by third part key if third party key is
imported in the firmware.

After this patch kexec_file_load will be able to verify a signed PE
bzImage using keys in platform keyring.

Tested in a VM with locally signed kernel with pesign and imported the
cert to EFI's MokList variable.

Kairui Song (2):
  integrity, KEYS: add a reference to platform keyring
  kexec, KEYS: Make use of platform keyring for signature verify

Update from V1:
  - Make platform_trusted_keys static, and update commit message as suggested
    by Mimi Zohar
  - Always check if platform keyring is initialized before use it

 arch/x86/kernel/kexec-bzimage64.c | 15 ++++++++++++---
 certs/system_keyring.c            | 20 +++++++++++++++++++-
 include/keys/system_keyring.h     |  5 +++++
 include/linux/verification.h      |  3 +++
 security/integrity/digsig.c       |  6 ++++++
 5 files changed, 45 insertions(+), 4 deletions(-)

-- 
2.20.1
