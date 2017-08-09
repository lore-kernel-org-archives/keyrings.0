From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 09 Aug 2017 02:51:29 +0000
Subject: [PATCH 0/3] Fix y2038 issues for security/keys subsystem
Message-Id: <cover.1502246501.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

Since 'time_t', 'timeval' and 'timespec' types are not year 2038 safe on
32 bits system, this patchset tries to fix this issues for security/keys
subsystem and net/rxrpc subsystem which is connected with security/keys
subsystem.

Baolin Wang (3):
  security: keys: Replace time_t/timespec with time64_t
  security: keys: Replace time_t with time64_t for struct
    key_preparsed_payload
  net: rxrpc: Replace time_t type with time64_t type

 include/keys/rxrpc-type.h    |   21 +++++++++++++++++++++
 include/linux/key-type.h     |    2 +-
 include/linux/key.h          |    7 ++++---
 net/rxrpc/ar-internal.h      |    2 +-
 net/rxrpc/key.c              |   22 ++++++++++++++--------
 net/rxrpc/rxkad.c            |   14 +++++++-------
 security/keys/gc.c           |   20 ++++++++++----------
 security/keys/internal.h     |    8 ++++----
 security/keys/key.c          |   27 ++++++++++-----------------
 security/keys/keyring.c      |   18 +++++++++---------
 security/keys/permission.c   |    3 +--
 security/keys/proc.c         |   20 ++++++++++----------
 security/keys/process_keys.c |    2 +-
 13 files changed, 93 insertions(+), 73 deletions(-)

-- 
1.7.9.5

