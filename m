From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Tue, 13 Jun 2017 21:50:04 +0000
Subject: [PATCH keyutils v2 0/6] New keyctl command and tests
Message-Id: <20170613215010.14390-1-mathew.j.martineau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

When I first posted the "TEST: Add KDF leading zero test" patch, David
asked if a 'keyctl xpadd' command sounded like a good idea. I think it
is a useful command - especially considering the awkward syntax used in
the dh_compute and restrict tests to pass both key data and an extra
command line parameter to pcreate_key:

  pcreate_key "-e $escaped_hex_data" user desc $keyring

These patches apply to the 'next' branch of keyutils.git

Mat Martineau (6):
  keyctl: Add xpadd command for hexadecimal data
  TEST: Add keyctl xpadd tests
  Doc: Add 'keyctl xpadd' information
  TEST: Add KDF leading zero test
  TEST: Refactor Diffie-Hellman tests
  TEST: Refactor restriction tests

 keyctl.c                                    |  67 ++++
 man/keyctl.1                                |  19 +-
 tests/keyctl/dh_compute/bad-args/runtest.sh |  70 ++--
 tests/keyctl/dh_compute/valid/runtest.sh    | 200 ++++------
 tests/keyctl/restrict/valid/runtest.sh      | 558 ++++++++++------------------
 tests/keyctl/xpadd/bad-args/runtest.sh      |  86 +++++
 tests/keyctl/xpadd/noargs/runtest.sh        |  31 ++
 tests/keyctl/xpadd/useradd/runtest.sh       |  68 ++++
 tests/toolbox.inc.sh                        |  29 ++
 9 files changed, 589 insertions(+), 539 deletions(-)
 create mode 100644 tests/keyctl/xpadd/bad-args/runtest.sh
 create mode 100644 tests/keyctl/xpadd/noargs/runtest.sh
 create mode 100644 tests/keyctl/xpadd/useradd/runtest.sh

-- 
2.13.1

