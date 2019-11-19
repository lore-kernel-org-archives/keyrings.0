From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 19 Nov 2019 22:31:27 +0000
Subject: [RFC PATCH 0/3] xfstests: test adding filesystem-level fscrypt key via key_id
Message-Id: <20191119223130.228341-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

This series adds a test which tests adding a key to a filesystem's
fscrypt keyring via an "fscrypt-provisioning" keyring key.  This is an
alternative to the normal method where the raw key is given directly.

I'm sending this out for comment, but it shouldn't be merged until the
corresponding kernel patch has reached mainline.  For more details, see
the kernel patch:
https://lkml.kernel.org/linux-fscrypt/20191119222447.226853-1-ebiggers@kernel.org/T/#u

This test depends on an xfs_io patch which adds the '-k' option to the
'add_enckey' command, e.g.:

	xfs_io -c "add_enckey -k KEY_ID" MOUNTPOINT

This test is skipped if the needed kernel or xfs_io support is absent.

This has been tested on ext4, f2fs, and ubifs.

To apply cleanly, my other xfstests patch series
"[RFC PATCH 0/5] xfstests: verify ciphertext of IV_INO_LBLK_64 encryption policies"
must be applied first.

This series can also be retrieved from
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git
tag "fscrypt-provisioning_2019-11-19".

Eric Biggers (3):
  common/rc: handle option with argument in _require_xfs_io_command()
  common/encrypt: move constant test key to common code
  generic: test adding filesystem-level fscrypt key via key_id

 common/encrypt        |  95 +++++++++++++++++++++----
 common/rc             |   2 +-
 tests/generic/580     |  17 ++---
 tests/generic/806     | 156 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/806.out |  73 ++++++++++++++++++++
 tests/generic/group   |   1 +
 6 files changed, 316 insertions(+), 28 deletions(-)
 create mode 100644 tests/generic/806
 create mode 100644 tests/generic/806.out

-- 
2.24.0.432.g9d3f5f5b63-goog
