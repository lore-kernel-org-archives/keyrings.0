From: Liu Shixin <liushixin2@huawei.com>
Date: Mon, 14 Sep 2020 03:55:42 +0000
Subject: [PATCH -next] dh key: convert to use be32_add_cpu()
Message-Id: <20200914041747.3701948-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>

Convert cpu_to_be32(be32_to_cpu(E1) + E2) to use be32_add_cpu().

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 security/keys/dh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index 1abfa70ed6e1..2635cb8a4561 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -186,7 +186,7 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 
 		dlen -= h;
 		dst += h;
-		counter = cpu_to_be32(be32_to_cpu(counter) + 1);
+		be32_add_cpu(&counter, 1);
 	}
 
 	return 0;
-- 
2.25.1
