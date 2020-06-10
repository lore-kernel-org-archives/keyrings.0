From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Wed, 10 Jun 2020 15:49:18 +0000
Subject: [PATCH 0/5] kmod/umh: a few fixes
Message-Id: <20200610154923.27510-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, christian.brauner@ubuntu.com
Cc: slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org, josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, bridge@lists.linux-foundation.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>

From: Luis Chamberlain <mcgrof@kernel.org>

Tiezhu Yang had sent out a patch set with a slew of kmod selftest
fixes, and one patch which modified kmod to return 254 when a module
was not found. This opened up pandora's box about why that was being
used for and low and behold its because when UMH_WAIT_PROC is used
we call a kernel_wait4() call but have never unwrapped the error code.
The commit log for that fix details the rationale for the approach
taken. I'd appreciate some review on that, in particular nfs folks
as it seems a case was never really hit before.

This goes boot tested, selftested with kmod, and 0-day gives its
build blessings.

Luis Chamberlain (2):
  umh: fix processed error when UMH_WAIT_PROC is used
  selftests: simplify kmod failure value

Tiezhu Yang (3):
  selftests: kmod: Use variable NAME in kmod_test_0001()
  kmod: Remove redundant "be an" in the comment
  test_kmod: Avoid potential double free in trigger_config_run_type()

 drivers/block/drbd/drbd_nl.c         | 20 +++++------
 fs/nfsd/nfs4recover.c                |  2 +-
 include/linux/sched/task.h           | 13 ++++++++
 kernel/kmod.c                        |  5 ++-
 kernel/umh.c                         |  4 +--
 lib/test_kmod.c                      |  2 +-
 net/bridge/br_stp_if.c               | 10 ++----
 security/keys/request_key.c          |  2 +-
 tools/testing/selftests/kmod/kmod.sh | 50 +++++++++++++++++++++++-----
 9 files changed, 71 insertions(+), 37 deletions(-)

-- 
2.26.2
