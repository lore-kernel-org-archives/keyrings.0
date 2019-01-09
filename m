From: Kairui Song <kasong@redhat.com>
Date: Wed, 09 Jan 2019 16:48:22 +0000
Subject: [RFC PATCH 0/2] let kexec_file_load use platform keyring to verify the kernel image
Message-Id: <20190109164824.19708-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>

Hi,

This is a different approach for the previous patch:
[RFC PATCH 0/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
make kexec_file_load be able to verify the kernel image against keys
provided by platform or firmware.

This patch adds a .platform_trusted_keys in system_keyring as the reference
to .platform keyring in integrity subsystem, when platform keyring is
being initialized it will be updated.

Another thing on my mind is that now kexec_file_load will still relay on
CONFIG_INTEGRITY_PLATFORM_KEYRING and all its dependencies to be enabled
to be able to verify the image against firmware keys. I'm thinking about
to have something like CONFIG_PLATFORM_KEYRING and make the .platform
keyring could be enabled for a more wider usage. Not sure if it's a good
idea though.

Tested in a VM with locally signed kernel with pesign and imported the
cert to EFI's MokList variable.

Kairui Song (2):
  integrity, KEYS: add a reference to platform keyring
  kexec, KEYS: Make use of platform keyring for signature verify

 arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
 certs/system_keyring.c            | 10 +++++++++-
 include/keys/system_keyring.h     |  5 +++++
 include/linux/verification.h      |  1 +
 security/integrity/digsig.c       |  4 ++++
 5 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.20.1
