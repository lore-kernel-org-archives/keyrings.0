From: David Howells <dhowells@redhat.com>
Date: Mon, 30 Oct 2017 15:37:45 +0000
Subject: [PATCH 0/4] Timer reduction function
Message-Id: <150937786557.31781.15521097996984061107.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: tglx@linutronix.de
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org


Hi Thomas,

Here's a set of patches, the first of which introduces a function,
reduce_timer(), that starts an inactive timer or reduces the expiry time on it
if the desired timeout is less than the current expiry time.

This is of immediate use in keyrings, where the gc timer currently sampled and
set if reduced without using a lock.  The other three patches upgrade
keyring's times to time64_t and then use reduce_timer() to manage the gc
timeout.

It is also of use in upcoming afs patches, where a collective timer is used to
manage a set of cell records, each of which has a timeout that is dependent on
DNS record lifetimes, and another collective timer is used to manage a set of
servers.

The advantage of reduce_timer() over mod_timer() is that the former won't
increase the timeout if the timer is already running.  Now, granted, this can
be done by wrapping the check of the timer and the call of mod_timer() in a
lock, but this requires an extra lock when the timer system has its own locks
that could be used - and will be taken unconditionally if mod_timer() is used
in this way.

I suspect this is of use in other places too - AF_RXRPC possibly, though there
since we usually want an exact timeout and usually further in the future, I'm
not sure whether it's faster to always modify the timer or whether it's faster
to take the expiration of the earlier timer that we no longer need and then
set the timer going again to the right time[*].

[*] In AF_RXRPC, timer expiration involves scheduling a work function to
    handle the timeout - which could then restart the timer if needed.  I need
    to overhaul this code to improve the timeout handling, and if
    reduce_timer() is available, I can separate out the setting of each
    timeout value.

David
---
Baolin Wang (2):
      security: keys: Replace time_t/timespec with time64_t
      security: keys: Replace time_t with time64_t for struct key_preparsed_payload

David Howells (2):
      Add a function to start/reduce a timer
      KEYS: Use reduce_timer() to shorten gc timeout


 include/linux/key-type.h     |    2 +-
 include/linux/key.h          |    7 +++---
 include/linux/timer.h        |    1 +
 kernel/time/timer.c          |   49 +++++++++++++++++++++++++++++++++++-------
 security/keys/gc.c           |   23 +++++++++-----------
 security/keys/internal.h     |    8 +++----
 security/keys/key.c          |   27 +++++++++--------------
 security/keys/keyring.c      |   18 ++++++++-------
 security/keys/permission.c   |    3 +--
 security/keys/proc.c         |   20 +++++++++--------
 security/keys/process_keys.c |    2 +-
 11 files changed, 92 insertions(+), 68 deletions(-)

