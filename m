From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 10 Jan 2019 20:30:19 +0000
Subject: [PATCH RESEND] man: keyctl_read(3): fix documentation for short buffer case
Message-Id: <20190110203019.85116-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When keyctl_read() is passed a buffer that is too small, the behavior is
inconsistent.  Some key types will fill as much of the buffer as
possible, while others won't copy anything.  Moreover, the in-kernel
documentation contradicted the man page on this point.

Update the man page to say that this point is unspecified.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 man/keyctl_read.3 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man/keyctl_read.3 b/man/keyctl_read.3
index 25821ad..852bc05 100644
--- a/man/keyctl_read.3
+++ b/man/keyctl_read.3
@@ -33,8 +33,8 @@ permission on a key to be able to read it.
 and
 .I buflen
 specify the buffer into which the payload data will be placed.  If the buffer
-is too small, the full size of the payload will be returned and no copy will
-take place.
+is too small, then the full size of the payload will be returned, and the
+contents of the buffer may be overwritten in some undefined way.
 .P
 .BR keyctl_read_alloc ()
 is similar to
@@ -62,8 +62,8 @@ though the byte-ordering is as appropriate for the kernel.
 On success
 .BR keyctl_read ()
 returns the amount of data placed into the buffer.  If the buffer was too
-small, then the size of buffer required will be returned, but no data will be
-transferred.
+small, then the size of buffer required will be returned, and the contents of
+the buffer may have been overwritten in some undefined way.
 .P
 On success
 .BR keyctl_read_alloc ()
-- 
2.20.1.97.g81188d93c3-goog
