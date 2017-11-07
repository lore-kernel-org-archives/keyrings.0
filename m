From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 07 Nov 2017 05:57:26 +0000
Subject: [PATCH] libceph: don't WARN() if user tries to add invalid key
Message-Id: <20171107055726.28099-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org
Cc: netdev@vger.kernel.org, keyrings@vger.kernel.org, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The WARN_ON(!key->len) in set_secret() in net/ceph/crypto.c is hit if a
user tries to add a key of type "ceph" with an invalid payload as
follows (assuming CONFIG_CEPH_LIB=y):

    echo -e -n '\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00' \
	| keyctl padd ceph desc @s

This can be hit by fuzzers.  As this is merely bad input and not a
kernel bug, replace the WARN_ON() with return -EINVAL.

Fixes: 7af3ea189a9a ("libceph: stop allocating a new cipher on every crypto request")
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 net/ceph/crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 489610ac1cdd..bf9d079cbafd 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -37,7 +37,9 @@ static int set_secret(struct ceph_crypto_key *key, void *buf)
 		return -ENOTSUPP;
 	}
 
-	WARN_ON(!key->len);
+	if (!key->len)
+		return -EINVAL;
+
 	key->key = kmemdup(buf, key->len, GFP_NOIO);
 	if (!key->key) {
 		ret = -ENOMEM;
-- 
2.15.0

