From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 27 Nov 2017 07:17:51 +0000
Subject: [PATCH] X.509: fix buffer overflow detection in sprint_oid()
Message-Id: <20171127071751.25935-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: linux-crypto@vger.kernel.org, Alexander Potapenko <glider@google.com>, Eric Biggers <ebiggers@google.com>, Takashi Iwai <tiwai@suse.de>

From: Eric Biggers <ebiggers@google.com>

In sprint_oid(), if the input buffer were to be more than 1 byte too
small for the first snprintf(), 'bufsize' would underflow, causing a
buffer overflow when printing the remainder of the OID.

Fortunately this cannot actually happen currently, because no users pass
in a buffer that can be too small for the first snprintf().

Regardless, fix it by checking the snprintf() return value correctly.

For consistency also tweak the second snprintf() check to look the same.

Fixes: 4f73175d0375 ("X.509: Add utility functions to render OIDs as strings")
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/oid_registry.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/oid_registry.c b/lib/oid_registry.c
index 41b9e50711a7..5a75d127995d 100644
--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -120,10 +120,10 @@ int sprint_oid(const void *data, size_t datasize, char *buffer, size_t bufsize)
 
 	n = *v++;
 	ret = count = snprintf(buffer, bufsize, "%u.%u", n / 40, n % 40);
+	if (count >= bufsize)
+		return -ENOBUFS;
 	buffer += count;
 	bufsize -= count;
-	if (bufsize = 0)
-		return -ENOBUFS;
 
 	while (v < end) {
 		num = 0;
@@ -141,9 +141,9 @@ int sprint_oid(const void *data, size_t datasize, char *buffer, size_t bufsize)
 			} while (n & 0x80);
 		}
 		ret += count = snprintf(buffer, bufsize, ".%lu", num);
-		buffer += count;
-		if (bufsize <= count)
+		if (count >= bufsize)
 			return -ENOBUFS;
+		buffer += count;
 		bufsize -= count;
 	}
 
-- 
2.15.0

