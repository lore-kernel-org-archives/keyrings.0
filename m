From: Alison Schofield <alison.schofield@intel.com>
Date: Fri, 07 Sep 2018 22:23:24 +0000
Subject: [RFC 00/12] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <cover.1536356108.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com, tglx@linutronix.de
Cc: Kai Huang <kai.huang@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, Kirill Shutemov <kirill.shutemov@intel.com>, Dave Hansen <dave.hansen@intel.com>, Jarkko Sakkinen <jarkko.sakkinen@intel.com>, jmorris@namei.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-mm@kvack.org

Seeking comments on the APIs supporting MKTME on future Intel platforms.

MKTME (Multi-Key Total Memory Encryption) is a technology supporting
memory encryption on upcoming Intel platforms. Whereas TME allows
encryption of the entire system memory using a single key, MKTME
allows mulitple encryption domains, each having their own key. While 
the main use case for the feature is virtual machine isolation, the
API needs the flexibility to work for a wide range of use cases.

This RFC presents the 2 API additions that enable userspace to:
 1) Create Encryption Keys: Kernel Key Service type "mktme"
 2) Use the Encryption Keys: system call encrypt_mprotect()

In order to share between: the Kernel Key Service, the new system call,
and the existing mm code, helper functions were created in arch/x86/mktme

This patchset is built upon Kirill Shutemov's patchset for the core MKTME
support. You can find that here:
git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git mktme/wip


Alison Schofield (12):
  docs/x86: Document the Multi-Key Total Memory Encryption API
  mm: Generalize the mprotect implementation to support extensions
  syscall/x86: Wire up a new system call for memory encryption keys
  x86/mm: Add helper functions to manage memory encryption keys
  x86/mm: Add a helper function to set keyid bits in encrypted VMA's
  mm: Add the encrypt_mprotect() system call
  x86/mm: Add helper functions to track encrypted VMA's
  mm: Track VMA's in use for each memory encryption keyid
  mm: Restrict memory encryption to anonymous VMA's
  x86/pconfig: Program memory encryption keys on a system-wide basis
  keys/mktme: Add a new key service type for memory encryption keys
  keys/mktme: Do not revoke in use memory encryption keys

 Documentation/x86/mktme-keys.txt       | 153 ++++++++++++++++
 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 arch/x86/include/asm/intel_pconfig.h   |  42 ++++-
 arch/x86/include/asm/mktme.h           |  21 +++
 arch/x86/mm/mktme.c                    | 141 ++++++++++++++
 fs/exec.c                              |   4 +-
 include/keys/mktme-type.h              |  28 +++
 include/linux/key.h                    |   2 +
 include/linux/mm.h                     |   9 +-
 include/linux/syscalls.h               |   2 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 kernel/fork.c                          |   2 +
 kernel/sys_ni.c                        |   2 +
 mm/mmap.c                              |  12 ++
 mm/mprotect.c                          |  93 +++++++++-
 mm/nommu.c                             |   4 +
 security/keys/Kconfig                  |  11 ++
 security/keys/Makefile                 |   1 +
 security/keys/internal.h               |   6 +
 security/keys/keyctl.c                 |   7 +
 security/keys/mktme_keys.c             | 325 +++++++++++++++++++++++++++++++++
 23 files changed, 855 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/x86/mktme-keys.txt
 create mode 100644 include/keys/mktme-type.h
 create mode 100644 security/keys/mktme_keys.c

-- 
2.14.1
