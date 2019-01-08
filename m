From: Kairui Song <kasong@redhat.com>
Date: Tue, 08 Jan 2019 08:12:46 +0000
Subject: [RFC PATCH 0/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
Message-Id: <20190108081247.2266-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com, Kairui Song <kasong@redhat.com>

Hi, as the subject, this is a patch that links the new introduced
.platform keyring into .secondary_trusted_keys keyring. This is
mainly for the kexec_file_load, make kexec_file_load be able to verify
the kernel image agains keys provided by platform or firmware.
kexec_file_load already could verify the image agains secondary_trusted_keys
if secondary_trusted_keys exits, so this will make kexec_file_load be ware
of platform keys as well.

This may also useful for things like module sign verify that are using
secondary_trusted_keys. I'm not sure if it will be better to move the
INTEGRITY_PLATFORM_KEYRING to certs/ and let integrity subsystem use
the keyring there, so just linked the .platform keyring into kernel's
.secondary_trusted_keys keyring.

It workd for my case, tested in a VM, I signed the kernel image locally
with pesign and imported the cert to EFI's MokList variable.

Kairui Song (1):
  KEYS, integrity: Link .platform keyring to .secondary_trusted_keys

 certs/system_keyring.c          | 30 ++++++++++++++++++++++++++++++
 include/keys/platform_keyring.h | 12 ++++++++++++
 security/integrity/digsig.c     |  7 +++++++
 3 files changed, 49 insertions(+)
 create mode 100644 include/keys/platform_keyring.h

-- 
2.20.1
