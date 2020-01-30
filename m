From: Vasily Averin <vvs@virtuozzo.com>
Date: Thu, 30 Jan 2020 10:16:27 +0000
Subject: [PATCH v2] keys: proc_keys_next should increase position index
Message-Id: <22307ecd-3254-6077-8bc7-02693338b586@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <eaacb0b2-fd0d-480e-1868-0a1284c20185@virtuozzo.com>
In-Reply-To: <eaacb0b2-fd0d-480e-1868-0a1284c20185@virtuozzo.com>
To: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>

If seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output:

$ dd if=/proc/keys bs=1  # full usual output
0f6bfdf5 I--Q---     2 perm 3f010000  1000  1000 user      4af2f79ab8848d0a: 740
1fb91b32 I--Q---     3 perm 1f3f0000  1000 65534 keyring   _uid.1000: 2
27589480 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2f33ab67 I--Q---   152 perm 3f030000     0     0 keyring   _ses: 2
33f1d8fa I--Q---     4 perm 3f030000  1000  1000 keyring   _ses: 1
3d427fda I--Q---     2 perm 3f010000  1000  1000 user      69ec44aec7678e5a: 740
3ead4096 I--Q---     1 perm 1f3f0000  1000 65534 keyring   _uid_ses.1000: 1
521+0 records in
521+0 records out
521 bytes copied, 0,00123769 s, 421 kB/s

$ dd if=/proc/keys bsP0 skip=1  # read after lseek in middle of last line
dd: /proc/keys: cannot skip to specified offset
g   _uid_ses.1000: 1        <<<< end of last line
3ead4096 I--Q---     1 perm 1f3f0000  1000 65534 keyring   _uid_ses.1000: 1
   <<<< and whole last lien again
0+1 records in
0+1 records out
97 bytes copied, 0,000135035 s, 718 kB/s

$ dd if=/proc/keys bs00 skip=1   # read after lseek beyond end of file
dd: /proc/keys: cannot skip to specified offset
3ead4096 I--Q---     1 perm 1f3f0000  1000 65534 keyring   _uid_ses.1000: 1
   <<<< generates last line
0+1 records in
0+1 records out
76 bytes copied, 0,000119981 s, 633 kB/s

Cc: stable@vger.kernel.org
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
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
