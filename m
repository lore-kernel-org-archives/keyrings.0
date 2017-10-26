From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 26 Oct 2017 20:54:58 +0000
Subject: [PATCH] KEYS: fix in-kernel documentation for keyctl_read()
Message-Id: <20171026205458.105299-1-ebiggers3@gmail.com>
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

Update the in-kernel documentation to say that this point is
unspecified.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/security/keys/core.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 1266eeae45f6..16f196069721 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -628,12 +628,12 @@ The keyctl syscall functions are:
      defined key type will return its data as is. If a key type does not
      implement this function, error EOPNOTSUPP will result.
 
-     As much of the data as can be fitted into the buffer will be copied to
-     userspace if the buffer pointer is not NULL.
-
-     On a successful return, the function will always return the amount of data
-     available rather than the amount copied.
+     On success, the function will return the amount of data placed into the
+     buffer.
 
+     If the specified buffer is too small, then the size of the buffer required
+     will be returned, and it is unspecified whether any data will be copied
+     into the buffer.
 
   *  Instantiate a partially constructed key::
 
-- 
2.15.0.rc2.357.g7e34df9404-goog

