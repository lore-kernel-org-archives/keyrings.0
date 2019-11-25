From: David Howells <dhowells@redhat.com>
Date: Mon, 25 Nov 2019 22:39:49 +0000
Subject: [GIT PULL] pipe: Notification queue preparation
Message-Id: <31452.1574721589@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Can you pull this please?  This is my set of preparatory patches for
building a general notification queue on top of pipes.  It makes a number
of significant changes:

 (1) It removes the nr_exclusive argument from __wake_up_sync_key() as this
     is always 1.  This prepares for step 2.

 (2) Adds wake_up_interruptible_sync_poll_locked() so that poll can be
     woken up from a function that's holding the poll waitqueue spinlock.

     [btw, I realise that I haven't un-sync'd the
      wake_up_interruptible_sync_poll() calls as you tentatively suggested.
      I can send a follow up patch to fix that if you still want it]

 (3) Change the pipe buffer ring to be managed in terms of unbounded head
     and tail indices rather than bounded index and length.  This means
     that reading the pipe only needs to modify one index, not two.

 (4) A selection of helper functions are provided to query the state of the
     pipe buffer, plus a couple to apply updates to the pipe indices.

 (5) The pipe ring is allowed to have kernel-reserved slots.  This allows
     many notification messages to be spliced in by the kernel without
     allowing userspace to pin too many pages if it writes to the same
     pipe.

 (6) Advance the head and tail indices inside the pipe waitqueue lock and
     use step 2 to poke poll without having to take the lock twice.

 (7) Rearrange pipe_write() to preallocate the buffer it is going to write
     into and then drop the spinlock.  This allows kernel notifications to
     then be added the ring whilst it is filling the buffer it allocated.
     The read side is stalled because the pipe mutex is still held.

 (8) Don't wake up readers on a pipe if there was already data in it when
     we added more.

 (9) Don't wake up writers on a pipe if the ring wasn't full before we
     removed a buffer.

PATCHES	BENCHMARK	BEST		TOTAL BYTES	AVG BYTES	STDDEV
=======	===============	===============	===============	===============	===============
-	pipe		      307457969	    36348556755	      302904639	       10622403
-	splice		      287117614	    26933658717	      224447155	      160777958
-	vmsplice	      435180375	    51302964090	      427524700	       19083037

rm-nrx	pipe		      311091179	    37093181356	      309109844	        7221622
rm-nrx	splice		      285628049	    27916298942	      232635824	      158296431
rm-nrx	vmsplice	      417703153	    47570362546	      396419687	       33960822

wakesl	pipe		      310698731	    36772541631	      306437846	        8249347
wakesl	splice		      286193726	    28600435451	      238336962	      141169318
wakesl	vmsplice	      436175803	    50723895824	      422699131	       40724240

ht	pipe		      305534565	    36426079543	      303550662	        5673885
ht	splice		      243632025	    23319439010	      194328658	      150479853
ht	vmsplice	      432825176	    49101781001	      409181508	       44102509

k-rsv	pipe		      308691523	    36652267561	      305435563	       12972559
k-rsv	splice		      244793528	    23625172865	      196876440	      125319143
k-rsv	vmsplice	      436119082	    49460808579	      412173404	       55547525

r-adv-t	pipe		      310094218	    36860182219	      307168185	        8081101
r-adv-t	splice		      285527382	    27085052687	      225708772	      206918887
r-adv-t	vmsplice	      336885948	    40128756927	      334406307	        5895935

r-cond	pipe		      308727804	    36635828180	      305298568	        9976806
r-cond	splice		      284467568	    28445793054	      237048275	      200284329
r-cond	vmsplice	      449679489	    51134833848	      426123615	       66790875

w-preal	pipe		      307416578	    36662086426	      305517386	        6216663
w-preal	splice		      282655051	    28455249109	      237127075	      194154549
w-preal	vmsplice	      437002601	    47832160621	      398601338	       96513019

w-redun	pipe		      307279630	    36329750422	      302747920	        8913567
w-redun	splice		      284324488	    27327152734	      227726272	      219735663
w-redun	vmsplice	      451141971	    51485257719	      429043814	       51388217

w-ckful	pipe		      305055247	    36374947350	      303124561	        5400728
w-ckful	splice		      281575308	    26841554544	      223679621	      215942886
w-ckful	vmsplice	      436653588	    47564907110	      396374225	       82255342

The patches column indicates the point in the patchset at which the benchmarks
were taken:

	0	No patches
	rm-nrx	"Remove the nr_exclusive argument from __wake_up_sync_key()"
	wakesl	"Add wake_up_interruptible_sync_poll_locked()"
	ht	"pipe: Use head and tail pointers for the ring, not cursor and length"
	k-rsv	"pipe: Allow pipes to have kernel-reserved slots"
	r-adv-t	"pipe: Advance tail pointer inside of wait spinlock in pipe_read()"
	r-cond	"pipe: Conditionalise wakeup in pipe_read()"
	w-preal	"pipe: Rearrange sequence in pipe_write() to preallocate slot"
	w-redun	"pipe: Remove redundant wakeup from pipe_write()"
	w-ckful	"pipe: Check for ring full inside of the spinlock in pipe_write()"

Changes:

 (*) Fix some bugs spotted by kbuild.

 ver #3:

 (*) Get rid of pipe_commit_{read,write}.

 (*) Port the virtio_console driver.

 (*) Fix pipe_zero().

 (*) Amend some comments.

 (*) Added an additional patch that changes the threshold at which readers
     wake writers for Konstantin Khlebnikov.

 ver #2:

 (*) Split the notification patches out into a separate branch.

 (*) Removed the nr_exclusive parameter from __wake_up_sync_key().

 (*) Renamed the locked wakeup function.

 (*) Add helpers for empty, full, occupancy.

 (*) Split the addition of ->max_usage out into its own patch.

 (*) Fixed some bits pointed out by Rasmus Villemoes.

 ver #1:

 (*) Build on top of standard pipes instead of having a driver.

David
---
The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/notifications-pipe-prep-20191115

for you to fetch changes up to 3c0edea9b29f9be6c093f236f762202b30ac9431:

  pipe: Remove sync on wake_ups (2019-11-15 16:22:54 +0000)

----------------------------------------------------------------
Pipework for general notification queue

----------------------------------------------------------------
David Howells (12):
      pipe: Reduce #inclusion of pipe_fs_i.h
      Remove the nr_exclusive argument from __wake_up_sync_key()
      Add wake_up_interruptible_sync_poll_locked()
      pipe: Use head and tail pointers for the ring, not cursor and length
      pipe: Allow pipes to have kernel-reserved slots
      pipe: Advance tail pointer inside of wait spinlock in pipe_read()
      pipe: Conditionalise wakeup in pipe_read()
      pipe: Rearrange sequence in pipe_write() to preallocate slot
      pipe: Remove redundant wakeup from pipe_write()
      pipe: Check for ring full inside of the spinlock in pipe_write()
      pipe: Increase the writer-wakeup threshold to reduce context-switch count
      pipe: Remove sync on wake_ups

 drivers/char/virtio_console.c |  16 ++-
 fs/exec.c                     |   1 -
 fs/fuse/dev.c                 |  31 +++--
 fs/ocfs2/aops.c               |   1 -
 fs/pipe.c                     | 232 +++++++++++++++++++++---------------
 fs/splice.c                   | 190 +++++++++++++++++------------
 include/linux/pipe_fs_i.h     |  64 +++++++++-
 include/linux/uio.h           |   4 +-
 include/linux/wait.h          |  11 +-
 kernel/exit.c                 |   2 +-
 kernel/sched/wait.c           |  37 ++++--
 lib/iov_iter.c                | 269 ++++++++++++++++++++++++------------------
 security/smack/smack_lsm.c    |   1 -
 13 files changed, 529 insertions(+), 330 deletions(-)
