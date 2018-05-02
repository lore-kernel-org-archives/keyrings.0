From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Date: Wed, 02 May 2018 23:08:11 +0000
Subject: [PATCH v6 4/4] KEYS: Print insert-sys-cert information to stdout instead of stderr
Message-Id: <20180502230811.2751-5-mkayaalp@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
In-Reply-To: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Keyrings <keyrings@vger.kernel.org>
Cc: Linux Integrity <linux-integrity@vger.kernel.org>, Linux Security <linux-security-module@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, George Wilson <gcwilson@us.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

Detailed INFO output should go to stdout instead of stderr.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
---
 scripts/insert-sys-cert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index a3bd7ea8a436..caa446fe91b8 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -32,7 +32,7 @@
 #define USED_SYM  "system_extra_cert_used"
 #define LSIZE_SYM "system_certificate_list_size"
 
-#define info(format, args...) fprintf(stderr, "INFO:    " format, ## args)
+#define info(format, args...) fprintf(stdout, "INFO:    " format, ## args)
 #define warn(format, args...) fprintf(stdout, "WARNING: " format, ## args)
 #define  err(format, args...) fprintf(stderr, "ERROR:   " format, ## args)
 
-- 
2.17.0

