From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 19 Dec 2019 01:03:17 +0000
Subject: [GIT PULL] tpmdd updates for Linux v5.5-rc3
Message-Id: <20191219010317.GA3086@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, jmorris@namei.org, dhowells@redhat.com

Bunch of fixes for rc3.

/Jarkko

The following changes since commit 37d4e84f765bb3038ddfeebdc5d1cfd7e1ef688f:

  Merge tag 'ceph-for-5.5-rc2' of git://github.com/ceph/ceph-client (2019-12-12 10:56:37 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tpmdd-next-20191219

for you to fetch changes up to 1760eb689ed68c6746744aff2092bff57c78d907:

  tpm/tpm_ftpm_tee: add shutdown call back (2019-12-19 02:31:28 +0200)

----------------------------------------------------------------
tpmdd fixes for Linux v5.5-rc3

----------------------------------------------------------------
Eric Biggers (2):
      KEYS: remove CONFIG_KEYS_COMPAT
      KEYS: asymmetric: return ENOMEM if akcipher_request_alloc() fails

James Bottomley (1):
      security: keys: trusted: fix lost handle flush

Jerry Snitselaar (1):
      tpm_tis: reserve chip for duration of tpm_tis_core_init

Pavel Tatashin (1):
      tpm/tpm_ftpm_tee: add shutdown call back

Tadeusz Struk (3):
      tpm: fix invalid locking in NONBLOCKING mode
      tpm: selftest: add test covering async mode
      tpm: selftest: cleanup after unseal with wrong auth/policy test

 crypto/asymmetric_keys/asym_tpm.c          |  1 +
 crypto/asymmetric_keys/public_key.c        |  1 +
 drivers/char/tpm/tpm-dev-common.c          |  8 +++++++
 drivers/char/tpm/tpm.h                     |  1 -
 drivers/char/tpm/tpm2-cmd.c                |  1 +
 drivers/char/tpm/tpm_ftpm_tee.c            | 22 +++++++++++++++----
 drivers/char/tpm/tpm_tis_core.c            | 35 +++++++++++++++---------------
 include/linux/tpm.h                        |  1 +
 security/keys/Kconfig                      |  4 ----
 security/keys/Makefile                     |  2 +-
 security/keys/compat.c                     |  5 -----
 security/keys/internal.h                   |  4 ++--
 security/keys/trusted-keys/trusted_tpm2.c  |  1 +
 tools/testing/selftests/tpm2/test_smoke.sh |  6 +++++
 tools/testing/selftests/tpm2/tpm2.py       | 19 ++++++++++++++--
 tools/testing/selftests/tpm2/tpm2_tests.py | 13 +++++++++++
 16 files changed, 88 insertions(+), 36 deletions(-)
