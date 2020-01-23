From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 23 Jan 2020 01:32:03 +0000
Subject: [PATCH v9 0/3] IMA: Deferred measurement of keys
Message-Id: <20200123013206.8499-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: sashal@kernel.org, dhowells@redhat.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

The IMA subsystem supports measuring asymmetric keys when the key is
created or updated[1]. But keys created or updated before a custom IMA
policy is loaded are currently not measured.  This includes keys added,
for instance, to either the .ima or .builtin_trusted_keys keyrings, which
happens early in the boot process.

Measuring the early boot keys, by design, requires loading a custom IMA
policy.  This change adds support for queuing keys created or updated
before a custom IMA policy is loaded.  The queued keys are processed when
a custom policy is loaded.  Keys created or updated after a custom policy
is loaded are measured immediately (not queued).  In the case when a
custom policy is not loaded within 5 minutes of IMA initialization, the
queued keys are freed.

[1] https://lore.kernel.org/linux-integrity/20191211164707.4698-1-nramas@linux.microsoft.com/

Changelog:

  v9

  => Rebased the changes to v5.5-rc7
  => Defined an intermediate Kconfig boolean option namely
     IMA_QUEUE_EARLY_BOOT_KEYS to declare the deferred key
     measurement functions.
  => Use delayed workqueue to free the queued keys when a custom IMA
     policy is not loaded.

  v8

  => Rebased the changes to linux-next
  => Need to apply the following patch first
  https://lore.kernel.org/linux-integrity/20200108160508.5938-1-nramas@linux.microsoft.com/

  v7

  => Updated cover letter per Mimi's suggestions.
  => Updated "Reported-by" tag to be specific about
     the issues fixed in the patch.

  v6

  => Replaced mutex with a spinlock to sychronize access to
     queued keys. This fixes the problem reported by
     "kernel test robot <rong.a.chen@intel.com>"
     https://lore.kernel.org/linux-integrity/2a831fe9-30e5-63b4-af10-a69f327f7fb7@linux.microsoft.com/T/#t
  => Changed ima_queue_key() to a static function. This fixes
     the issue reported by "kbuild test robot <lkp@intel.com>"
     https://lore.kernel.org/linux-integrity/1577370464.4487.10.camel@linux.ibm.com/
  => Added the patch to free the queued keys if a custom IMA policy
     was not loaded to this patch set.

  v5

  => Removed temp keys list in ima_process_queued_keys()

  v4

  => Check and set ima_process_keys flag with mutex held.

  v3

  => Defined ima_process_keys flag to be static.
  => Set ima_process_keys with ima_keys_mutex held.
  => Added a comment in ima_process_queued_keys() function
     to state the use of temporary list for keys.

  v2

  => Rebased the changes to v5.5-rc1
  => Updated function names, variable names, and code comments
     to be less verbose.

  v1

  => Code cleanup

  v0

  => Based changes on v5.4-rc8
  => The following patchsets should be applied in that order
     https://lore.kernel.org/linux-integrity/1572492694-6520-1-git-send-email-zohar@linux.ibm.com
     https://lore.kernel.org/linux-integrity/20191204224131.3384-1-nramas@linux.microsoft.com/
  => Added functions to queue and dequeue keys, and process
     the queued keys when custom IMA policies are applied.

Lakshmi Ramasubramanian (3):
  IMA: Define workqueue for early boot key measurements
  IMA: Call workqueue functions to measure queued keys
  IMA: Defined delayed workqueue to free the queued keys

 security/integrity/ima/Kconfig               |   5 +
 security/integrity/ima/Makefile              |   1 +
 security/integrity/ima/ima.h                 |  24 +++
 security/integrity/ima/ima_asymmetric_keys.c |   8 +
 security/integrity/ima/ima_init.c            |   8 +-
 security/integrity/ima/ima_policy.c          |   3 +
 security/integrity/ima/ima_queue_keys.c      | 171 +++++++++++++++++++
 7 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/ima/ima_queue_keys.c

-- 
2.17.1
