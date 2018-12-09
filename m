From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 09 Dec 2018 20:36:28 +0000
Subject: [PATCH 0/5] security: remove needless usage of module header
Message-Id: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, David Howells <dhowells@redhat.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linux-integrity@vger.kernel.org

The most important thing to note here, is these clean-ups make no
changes to the object files or the final generated run-time.

The work here represents a scan over the security dir, looking for files
that have nothing to do with a modular use case, but are using modular
infrastructure regardless.

We are trying to make driver code consistent with the Makefiles/Kconfigs
that control them.  This means not using modular functions/macros for
drivers that can never be built as a module.  This has been done in quite
a lot of other mainline subsystem dirs already.

Using modular infrastructure in non-modules might seem harmless, but some
of the downfalls this leads to are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other drivers and spreads quickly.

As a data point for #3 above, an empty C file that just includes the
module.h header generates over 750kB of CPP output.  Repeating the same
experiment with init.h and the result is less than 12kB; with export.h
it is only about 1/2kB; with both it still is less than 12kB.

We start with the simple ones - removing <linux/module.h> from where
it simply isn't required.  Then we remove the no-op MODULE_ macros from
non-modular files, in order to remove module.h from there as well.
Overall, we get rid of about 28 instances of <linux/module.h> here.

Build tested on v4.20-rc5 for allmodconfig on x86-64 and ARM-64.

Paul.
---

Cc: David Howells <dhowells@redhat.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org
Cc: linux-ima-devel@lists.sourceforge.net
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org

Paul Gortmaker (5):
  security: audit and remove any unnecessary uses of module.h
  keys: remove needless modular infrastructure from ecryptfs_format
  security: fs: make inode explicitly non-modular
  security: integrity: make evm_main explicitly non-modular
  security: integrity: make ima_main explicitly non-modular

 security/apparmor/apparmorfs.c                   | 2 +-
 security/commoncap.c                             | 1 -
 security/inode.c                                 | 6 ++----
 security/integrity/evm/evm_crypto.c              | 2 +-
 security/integrity/evm/evm_main.c                | 5 +----
 security/integrity/evm/evm_posix_acl.c           | 1 -
 security/integrity/evm/evm_secfs.c               | 2 +-
 security/integrity/iint.c                        | 2 +-
 security/integrity/ima/ima_api.c                 | 1 -
 security/integrity/ima/ima_appraise.c            | 2 +-
 security/integrity/ima/ima_fs.c                  | 2 +-
 security/integrity/ima/ima_init.c                | 2 +-
 security/integrity/ima/ima_main.c                | 7 +++----
 security/integrity/ima/ima_policy.c              | 2 +-
 security/integrity/ima/ima_queue.c               | 1 -
 security/keys/encrypted-keys/ecryptfs_format.c   | 5 ++---
 security/keys/encrypted-keys/masterkey_trusted.c | 1 -
 security/keys/gc.c                               | 1 -
 security/keys/key.c                              | 2 +-
 security/keys/keyctl.c                           | 1 -
 security/keys/keyring.c                          | 2 +-
 security/keys/permission.c                       | 2 +-
 security/keys/proc.c                             | 1 -
 security/keys/process_keys.c                     | 1 -
 security/keys/request_key.c                      | 2 +-
 security/keys/request_key_auth.c                 | 1 -
 security/keys/user_defined.c                     | 2 +-
 security/security.c                              | 2 +-
 28 files changed, 22 insertions(+), 39 deletions(-)

-- 
2.7.4
