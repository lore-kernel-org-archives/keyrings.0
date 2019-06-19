From: David Howells <dhowells@redhat.com>
Date: Wed, 19 Jun 2019 15:35:56 +0000
Subject: [PATCH 0/6] keys: request_key() improvements [ver #2]
Message-Id: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org


Here's a fix and some improvements for request_key() intended for the next
merge window:

 (1) Fix the lack of a Link permission check on a key found by
     request_key(), thereby enabling request_key() to link keys that don't
     grant this permission to the target keyring (which must still grant
     Write permission).

     Note that the key must be in the caller's keyrings already to be
     found.

 (2) Invalidate used request_key authentication keys rather than revoking
     them, so that they get cleaned up immediately rather than hanging
     around till the expiry time is passed.

 (3) Move the RCU locks outwards from the keyring search functions so that
     a request_key_rcu() can be provided.  This can be called in RCU mode,
     so it can't sleep and can't upcall - but it can be called from
     LOOKUP_RCU pathwalk mode.

 (4) Cache the latest positive result of request_key*() temporarily in
     task_struct so that filesystems that make a lot of request_key() calls
     during pathwalk can take advantage of it to avoid having to redo the
     searching.

     It is assumed that the key just found is likely to be used multiple
     times in each step in an RCU pathwalk, and is likely to be reused for
     the next step too.

     Note that the cleanup of the cache is done on TIF_NOTIFY_RESUME, just
     before userspace resumes, and on exit.

The patches can be found on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-request

and this depends on keys-misc.

David
---
David Howells (6):
      keys: Fix request_key() lack of Link perm check on found key
      keys: Invalidate used request_key authentication keys
      keys: Move the RCU locks outwards from the keyring search functions
      keys: Provide request_key_rcu()
      keys: Cache result of request_key*() temporarily in task_struct
      keys: Kill off request_key_async{,_with_auxdata}


 Documentation/security/keys/core.rst        |   38 ++-----
 Documentation/security/keys/request-key.rst |   33 +++----
 include/keys/request_key_auth-type.h        |    1 
 include/linux/key.h                         |   14 +--
 include/linux/sched.h                       |    5 +
 include/linux/tracehook.h                   |    7 +
 kernel/cred.c                               |    9 ++
 security/keys/Kconfig                       |   17 +++
 security/keys/internal.h                    |    6 +
 security/keys/key.c                         |    4 -
 security/keys/keyring.c                     |   16 ++-
 security/keys/proc.c                        |    4 +
 security/keys/process_keys.c                |   41 ++++----
 security/keys/request_key.c                 |  137 ++++++++++++++++++---------
 security/keys/request_key_auth.c            |   60 +++++++-----
 15 files changed, 228 insertions(+), 164 deletions(-)
