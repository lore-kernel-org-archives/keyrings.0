From: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
Date: Thu, 02 Jul 2020 08:57:19 +0000
Subject: [PATCH 0/4] keyutils: fix compilation error with C++
Message-Id: <20200702085723.7026-1-cvubrugier@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

These patches are for the userspace keyutils program and library.

While working on a C++ program that could take advantage of the
keyutils library, I observed that the compilation fails because the
"keyutils.h" header file contains a parameter named "private" which is
a C++ reserved keyword.

* Patch #1 fixes a few typos in the man pages.
* Patch #2 fixes the aforementioned issue.
* Patch #3 helps prevent a similar issue from happening in the future.
* Patch #4 fixes an issue reported by C++ compilers at link time.

With best regards,

Christophe Vu-Brugier (4):
  man: fix typos
  Fix compilation error when keyutils.h is used in C++
  Check that keyutils.h has valid C++ syntax at build time
  Fix error when a C++ program is linked with libkeyutils

 Makefile                  | 16 +++++++++++++++-
 keyutils.c                |  4 ++--
 keyutils.h                | 10 +++++++++-
 man/keyctl.3              |  4 ++--
 man/keyctl_capabilities.3 |  2 +-
 man/keyctl_chown.3        |  2 +-
 man/keyctl_clear.3        |  3 +--
 man/keyctl_link.3         |  3 +--
 man/keyctl_move.3         |  3 +--
 man/keyctl_read.3         |  3 +--
 man/keyctl_revoke.3       |  2 +-
 man/keyctl_set_timeout.3  |  2 +-
 man/keyctl_setperm.3      |  2 +-
 man/keyctl_update.3       |  2 +-
 14 files changed, 38 insertions(+), 20 deletions(-)

-- 
2.27.0
