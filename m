From: David Howells <dhowells@redhat.com>
Date: Mon, 24 Aug 2020 15:30:38 +0000
Subject: [PATCH 2/2] Modify the pipe(2) manpage for notification queues
Message-Id: <159828303892.330133.569968242547202064.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <159828303137.330133.10953708050467314086.stgit@warthog.procyon.org.uk>
In-Reply-To: <159828303137.330133.10953708050467314086.stgit@warthog.procyon.org.uk>
To: mtk.manpages@gmail.com, me@benboeckel.net
Cc: torvalds@linux-foundation.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org

Modify the pipe(2) manual page to cover support for notification queues

Signed-off-by: David Howells <dhowells@redhat.com>
---

 man2/pipe.2 |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/man2/pipe.2 b/man2/pipe.2
index 117f8950c..c50b38530 100644
--- a/man2/pipe.2
+++ b/man2/pipe.2
@@ -146,6 +146,13 @@ referred to by the new file descriptors.
 Using this flag saves extra calls to
 .BR fcntl (2)
 to achieve the same result.
+.TP
+.B O_NOTIFICATION_PIPE
+This enables use of the pipe as a notification transport (see
+.BR watch_queue (7)
+for more information).  When a pipe is in this mode, it may not be spliced as
+the insertion of notification messages into the pipe buffer can happen
+asynchronously and may cause splice to malfunction.
 .SH RETURN VALUE
 On success, zero is returned.
 On error, \-1 is returned,
@@ -292,4 +299,5 @@ main(int argc, char *argv[])
 .BR vmsplice (2),
 .BR write (2),
 .BR popen (3),
-.BR pipe (7)
+.BR pipe (7),
+.BR watch_queue (7)
