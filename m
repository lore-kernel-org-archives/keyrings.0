From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 03 Feb 2020 18:18:52 +0000
Subject: [PATCH v2 0/3] xfstests: test adding filesystem-level fscrypt key via key_id
Message-Id: <20200203181855.42987-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org

This series adds a test which tests adding a key to a filesystem's
fscrypt keyring via an "fscrypt-provisioning" keyring key.  This is an
alternative to the normal method where the raw key is given directly.

The needed kernel support was merged in 5.6, so currently this test
needs the latest mainline kernel to run.

This test also depends on an xfs_io patch which adds the '-k' option to
the 'add_enckey' command, e.g.:

        xfs_io -c "add_enckey -k KEY_ID" MOUNTPOINT

This test is skipped if the needed kernel or xfs_io support is absent.

This has been tested on ext4, f2fs, and ubifs.

This series can also be retrieved from
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git
tag "fscrypt-provisioning_2020-02-03".

Changed since v1:
  - Fixed incorrect detection of kernel support.

Eric Biggers (3):
  common/rc: handle option with argument in _require_xfs_io_command()
  common/encrypt: move constant test key to common code
  generic: test adding filesystem-level fscrypt key via key_id

 common/encrypt        |  95 ++++++++++++++++++++++----
 common/rc             |   2 +-
 tests/generic/580     |  17 ++---
 tests/generic/806     | 155 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/806.out |  73 ++++++++++++++++++++
 tests/generic/group   |   1 +
 6 files changed, 315 insertions(+), 28 deletions(-)
 create mode 100644 tests/generic/806
 create mode 100644 tests/generic/806.out

-- 
2.25.0.341.g760bfbb309-goog
