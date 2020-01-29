From: Clay Chang <clayc@hpe.com>
Date: Wed, 29 Jan 2020 09:36:12 +0000
Subject: [PATCH] KEYS: check the certfile for ASN1 encoding before inserting
Message-Id: <20200129093612.16889-1-clayc@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com, dwmw2@infradead.org
Cc: keyrings@vger.kernel.org, Clay Chang <clayc@hpe.com>

The certfile to be inserted into the kernel must be in ASN1 encoding.
This patch implements a guard against invalid certfile.

Signed-off-by: Clay Chang <clayc@hpe.com>
---
 scripts/insert-sys-cert.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836c2342..2d9139887ba0 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -311,6 +311,11 @@ int main(int argc, char **argv)
 	if (!cert)
 		exit(EXIT_FAILURE);
 
+	if (cert[0] != 0x30 && cert[1] != 0x82) {
+		err("Invalid certfile.\n");
+		exit(EXIT_FAILURE);
+	}
+
 	hdr = map_file(vmlinux_file, &vmlinux_size);
 	if (!hdr)
 		exit(EXIT_FAILURE);
-- 
2.16.6
