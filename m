From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 27 Nov 2019 02:52:10 +0000
Subject: [PATCH v0 0/2] IMA: Deferred measurement of keys
Message-Id: <20191127025212.3077-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

This patchset extends the previous version[1] by adding support for
deferred processing of keys.

With the patchset referenced above, the IMA subsystem supports
measuring keys when the key is created or updated. But the keys
created or updated before IMA subsystem is initialized are not
handled. This includes keys added to, for instance,
.builtin_trusted_keys which happens very early in the boot process.

This change adds support for queuing keys when IMA is not ready
and process the keys (including queued keys) when IMA is initialized.

[1] https://lore.kernel.org/linux-integrity/20191127015654.3744-1-nramas@linux.microsoft.com/

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

  v0

  => Based changes on v5.4-rc8
  => The following patchsets should be applied in that order
     https://lore.kernel.org/linux-integrity/1572492694-6520-1-git-send-email-zohar@linux.ibm.com
     https://lore.kernel.org/linux-integrity/20191127015654.3744-1-nramas@linux.microsoft.com/
  => Added functions to queue and dequeue keys, and process
     the queued keys when custom IMA policies are applied.

Lakshmi Ramasubramanian (2):
  IMA: Defined queue functions
  IMA: Call queue and dequeue functions to measure keys

 security/integrity/ima/ima.h                 |  15 ++
 security/integrity/ima/ima_asymmetric_keys.c | 151 ++++++++++++++++++-
 security/integrity/ima/ima_policy.c          |  12 ++
 3 files changed, 174 insertions(+), 4 deletions(-)

-- 
2.17.1
