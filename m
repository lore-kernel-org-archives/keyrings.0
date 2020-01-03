From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 03 Jan 2020 05:56:05 +0000
Subject: [PATCH v6 0/3] IMA: Deferred measurement of keys
Message-Id: <20200103055608.22491-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

This patchset extends the previous version[1] by adding support for
deferred processing of keys.

With the patchset referenced above, the IMA subsystem supports
measuring asymmetric keys when the key is created or updated.
But keys created or updated before a custom IMA policy is loaded
are currently not measured. This includes keys added to, for instance,
.builtin_trusted_keys which happens early in the boot process.

This change adds support for queuing keys created or updated before
a custom IMA policy is loaded. The queued keys are processed when
a custom policy is loaded. Keys created or updated after a custom policy
is loaded are measured immediately (not queued).

If the kernel is built with both CONFIG_IMA and
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
must be applied as a custom policy for the keys to be measured.
If a custom IMA policy is not provided within 5 minutes after
IMA is initialized, any queued keys will be freed.
This is by design.

[1] https://lore.kernel.org/linux-integrity/20191211164707.4698-1-nramas@linux.microsoft.com/

Testing performed:

  * Ran kernel self-test following the instructions given in
    https://www.kernel.org/doc/Documentation/kselftest.txt
  * Ran the lkp-tests using the job script provided by
    kernel test robot <rong.a.chen@intel.com>
  * Booted the kernel with this change.
  * Added .builtin_trusted_keys in "keyrings=" option in
    the IMA policy and verified the keys added to this
    keyring are measured.
  * Specified only func=KEY_CHECK and not "keyrings=" option,
    and verified the keys added to builtin_trusted_keys keyring
    are processed.
  * Added keys at runtime and verified they are measured
    if the IMA policy permitted.
      => For example, added keys to .ima keyring and verified.

Changelog:

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
  IMA: Defined timer to free queued keys

 security/integrity/ima/ima.h                 |  17 ++
 security/integrity/ima/ima_asymmetric_keys.c | 159 +++++++++++++++++++
 security/integrity/ima/ima_init.c            |   8 +-
 security/integrity/ima/ima_policy.c          |   3 +
 4 files changed, 186 insertions(+), 1 deletion(-)

-- 
2.17.1
