From: David Howells <dhowells@redhat.com>
Date: Wed, 22 May 2019 22:46:02 +0000
Subject: [PATCH 0/6] keys: request_key() improvements(vspace)s
Message-Id: <155856516286.11737.11196637682919902718.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org


Here's a fix and some improvements for request_key() intended for the next
merge window:

 (1) Fix the lack of a Link permission check on a key found by request_key(),
     thereby enabling request_key() to link keys that don't grant this
     permission to the target keyring (which must still grant Write
     permission).

     Note that the key must be in the caller's keyrings already to be found.

 (2) Invalidate used request_key authentication keys rather than revoking
     them, so that they get cleaned up immediately rather than hanging around
     till the expiry time is passed.

 (3) Move the RCU locks outwards from the keyring search functions so that a
     request_key_rcu() can be provided.  This can be called in RCU mode, so it
     can't sleep and can't upcall - but it can be called from LOOKUP_RCU
     pathwalk mode.

 (4) Cache the latest positive result of request_key*() temporarily in
     task_struct so that filesystems that make a lot of request_key() calls
     during pathwalk can take advantage of it to avoid having to redo the
     searching.

     It is assumed that the key just found is unlikely to be superseded
     between steps in an RCU pathwalk.

     Note that the cleanup of the cache is done on TIF_NOTIFY_RESUME, just
     before userspace resumes, and on exit.

I've included, for illustration, two patches to the in-kernel AFS filesystem
to make them use this.

The patches can be found on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-request

and this depends on keys-misc.  Note that the AFS patches aren't on this branch.

David
---
David Howells (6):
      keys: Fix request_key() lack of Link perm check on found key
      keys: Invalidate used request_key authentication keys
      keys: Move the RCU locks outwards from the keyring search functions
      keys: Cache result of request_key*() temporarily in task_struct
      afs: Provide an RCU-capable key lookup
      afs: Support RCU pathwalk


 Documentation/security/keys/core.rst        |    8 ++
 Documentation/security/keys/request-key.rst |   11 +++
 fs/afs/dir.c                                |   54 ++++++++++++++
 fs/afs/internal.h                           |    1 
 fs/afs/security.c                           |  102 +++++++++++++++++++++++----
 include/keys/request_key_auth-type.h        |    1 
 include/linux/key.h                         |    3 +
 include/linux/sched.h                       |    5 +
 include/linux/tracehook.h                   |    5 +
 kernel/cred.c                               |    9 ++
 security/keys/internal.h                    |    6 +-
 security/keys/key.c                         |    4 +
 security/keys/keyring.c                     |   16 ++--
 security/keys/proc.c                        |    4 +
 security/keys/process_keys.c                |   41 +++++------
 security/keys/request_key.c                 |   97 +++++++++++++++++++++++++-
 security/keys/request_key_auth.c            |   60 ++++++++++------
 17 files changed, 346 insertions(+), 81 deletions(-)
