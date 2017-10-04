From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Date: Wed, 04 Oct 2017 08:45:09 +0000
Subject: [PATCH] KEYS: checking the input id parameters before finding asymmetric key
Message-Id: <20171004084509.28481-1-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>

For finding asymmetric key, the input id_0 and id_1 parameters can
not be NULL at the same time. This patch adds the BUG_ON checking
for id_0 and id_1.

Cc: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 crypto/asymmetric_keys/asymmetric_type.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index e4b0ed3..3a3b028 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -57,6 +57,8 @@ struct key *find_asymmetric_key(struct key *keyring,
 	char *req, *p;
 	int len;
 
+	BUG_ON(!id_0 && !id_1);
+
 	if (id_0) {
 		lookup = id_0->data;
 		len = id_0->len;
-- 
2.10.2

