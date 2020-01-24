From: Vasily Averin <vvs@virtuozzo.com>
Date: Fri, 24 Jan 2020 06:25:16 +0000
Subject: [PATCH 1/1] proc_keys_next should increase position index
Message-Id: <af9dcaa7-6e4f-281a-2bae-fb605cc55d2d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id 6283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 security/keys/proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/proc.c b/security/keys/proc.c
index 415f3f1..d0cde66 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -139,6 +139,8 @@ static void *proc_keys_next(struct seq_file *p, void *v, loff_t *_pos)
 	n = key_serial_next(p, v);
 	if (n)
 		*_pos = key_node_serial(n);
+	else
+		(*_pos)++;
 	return n;
 }
 
-- 
1.8.3.1
