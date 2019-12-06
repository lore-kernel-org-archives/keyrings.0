From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 06 Dec 2019 01:29:34 +0000
Subject: [PATCH v1 0/2] IMA: Deferred measurement of keys
Message-Id: <20191206012936.2814-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, linux-integrity@vger.kernel.org
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
must be applied as a custom policy. Not providing a custom policy
in the above configuration would result in asymmeteric keys being queued
until a custom policy is loaded. This is by design.

[1] https://lore.kernel.org/linux-integrity/20191204224131.3384-1-nramas@linux.microsoft.com/

Testing performed:

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

  v1

  => Code cleanup

  v0

  => Based changes on v5.4-rc8
  => The following patchsets should be applied in that order
     https://lore.kernel.org/linux-integrity/1572492694-6520-1-git-send-email-zohar@linux.ibm.com
     https://lore.kernel.org/linux-integrity/20191204224131.3384-1-nramas@linux.microsoft.com/
  => Added functions to queue and dequeue keys, and process
     the queued keys when custom IMA policies are applied.

Lakshmi Ramasubramanian (2):
  IMA: Define workqueue for early boot "key" measurements
  IMA: Call workqueue functions to measure queued keys

 security/integrity/ima/ima.h                 |  15 +++
 security/integrity/ima/ima_asymmetric_keys.c | 134 +++++++++++++++++++
 security/integrity/ima/ima_policy.c          |   6 +
 3 files changed, 155 insertions(+)

-- 
2.17.1
