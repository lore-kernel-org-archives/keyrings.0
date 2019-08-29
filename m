From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:43:08 +0000
Subject: [PATCH v2 00/13] Test suite tidiness
Message-Id: <20190829204322.8015-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

A collection of minor patches to the test suite I discovered while
porting to the Rust bindings I've been working on:

    https://github.com/mathstuf/rust-keyutils
    https://github.com/mathstuf/rust-keyutils/pull/34 (for the porting of the test suite)

Mostly typos, relocating some tests to what seems to be more sensible
location, fixing some copy/pasta, and adding some missed test cases.
The patches were developed against master, but have been rebased here
against `next` to make it easier to add to it. If that is incorrect, I
can rebase onto `master` and respin.

Note that I'm sending these for review now, but I'll be on vacation for
a few weeks. Feel free to leave review comments; I'll act on them once I
return.

Thanks,

--Ben

Ben Boeckel (13):
  tests/toolbox: detect endianness with PIE executables
  tests: fix some typos in marker lines
  tests: remove some trailing whitespace
  keyctl: unify spelling of "unparsable"
  tests: fix typos in test comments
  tests/revoke: test key revokation in the revoke tests
  tests/timeout: test actions on an expired keyring as well
  tests/instantiating: test the unlinked keyid
  test/instantiating: test bad arguments for `keyctl reject`
  tests/reading: fix test comment
  tests/reading: remove revokation test
  tests/search: test searching with a mismatched type
  tests/search: test a found key without search permissions

 keyctl.c                                      |  6 ++--
 tests/keyctl/add/bad-args/runtest.sh          |  2 +-
 tests/keyctl/clear/valid/runtest.sh           |  2 +-
 tests/keyctl/dh_compute/bad-args/runtest.sh   |  2 +-
 .../keyctl/instantiating/bad-args/runtest.sh  | 20 ++++++++++--
 tests/keyctl/link/recursion/runtest.sh        |  2 +-
 tests/keyctl/newring/bad-args/runtest.sh      |  2 +-
 tests/keyctl/padd/bad-args/runtest.sh         |  2 +-
 tests/keyctl/pupdate/userupdate/runtest.sh    | 10 +++---
 tests/keyctl/reading/valid/runtest.sh         |  8 +----
 tests/keyctl/requesting/bad-args/runtest.sh   |  2 +-
 tests/keyctl/requesting/piped/runtest.sh      |  4 +--
 tests/keyctl/requesting/valid/runtest.sh      |  4 +--
 tests/keyctl/revoke/valid/runtest.sh          | 20 ++++++++++++
 tests/keyctl/search/bad-args/runtest.sh       |  2 +-
 tests/keyctl/search/valid/runtest.sh          | 13 +++++---
 tests/keyctl/session/bad-args/runtest.sh      |  2 +-
 tests/keyctl/timeout/valid/runtest.sh         | 32 +++++++++----------
 tests/keyctl/unlink/all/runtest.sh            |  2 +-
 tests/keyctl/unlink/valid/runtest.sh          |  4 +--
 tests/keyctl/update/userupdate/runtest.sh     | 14 ++++----
 tests/toolbox.inc.sh                          | 26 +++++++++++++--
 22 files changed, 117 insertions(+), 64 deletions(-)

-- 
2.21.0
