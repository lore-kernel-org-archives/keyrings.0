From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:32 +0000
Subject: [PATCH v2 3/7] keyctl_dh_compute.3: clarify keyctl_dh_compute_kdf
Message-Id: <20180927131436.23328-4-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 man/keyctl_dh_compute.3 | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/man/keyctl_dh_compute.3 b/man/keyctl_dh_compute.3
index bb1274c..09c5d21 100644
--- a/man/keyctl_dh_compute.3
+++ b/man/keyctl_dh_compute.3
@@ -104,10 +104,10 @@ parameter is specified with
 and is restricted to a maximum length by the kernel.
 .P
 The KDF returns the requested number of bytes specified with the
-.I genlen
-or the
 .I buflen
-parameter depending on the invoked function.
+parameter into the
+.I buffer
+argument.
 .P
 .I buffer
 and
@@ -128,7 +128,13 @@ On success
 .BR keyctl_dh_compute_alloc ()
 returns the amount of data in the buffer.
 .P
-On error, both functions set errno to an appropriate code and return the value
+On success
+.BR keyctl_dh_compute_kdf ()
+returns the amount of data placed into the buffer when
+.I buflen
+is non-zero.
+.P
+On error, all functions set errno to an appropriate code and return the value
 .BR -1 .
 .\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 .SH ERRORS
-- 
2.19.0.221.g150f307afc
