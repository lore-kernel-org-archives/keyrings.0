From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 27 Nov 2017 07:18:17 +0000
Subject: [PATCH] X.509: fix printing uninitialized stack memory when OID is empty
Message-Id: <20171127071817.25999-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: linux-crypto@vger.kernel.org, Alexander Potapenko <glider@google.com>, Eric Biggers <ebiggers@google.com>, Takashi Iwai <tiwai@suse.de>

From: Eric Biggers <ebiggers@google.com>

Callers of sprint_oid() do not check its return value before printing
the result.  In the case where the OID is zero-length, -EBADMSG was
being returned without anything being written to the buffer, resulting
in uninitialized stack memory being printed.  Fix this by writing
"(empty)" to the buffer in that case.

Fixes: 4f73175d0375 ("X.509: Add utility functions to render OIDs as strings")
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/oid_registry.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/oid_registry.c b/lib/oid_registry.c
index 5a75d127995d..3640170f0d65 100644
--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -115,8 +115,10 @@ int sprint_oid(const void *data, size_t datasize, char *buffer, size_t bufsize)
 	size_t ret;
 	int count;
 
-	if (v >= end)
+	if (v >= end) {
+		snprintf(buffer, bufsize, "(empty)");
 		return -EBADMSG;
+	}
 
 	n = *v++;
 	ret = count = snprintf(buffer, bufsize, "%u.%u", n / 40, n % 40);
-- 
2.15.0

