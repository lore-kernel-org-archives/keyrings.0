From: Waiman Long <longman@redhat.com>
Date: Tue, 17 Mar 2020 19:41:39 +0000
Subject: [PATCH v4 3/4] KEYS: Remove __user annotation from dns_resolver_read()
Message-Id: <20200317194140.6031-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200317194140.6031-1-longman@redhat.com>
In-Reply-To: <20200317194140.6031-1-longman@redhat.com>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>, Waiman Long <longman@redhat.com>

As the keyctl_read_key() has been modified to use a temporary kernel
buffer to read out the key data instead of passing in the user-supplied
buffer directly, there is no need to use the __user annotation for
dns_resolver_read().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 net/dns_resolver/dns_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 3e1a90669006..ad53eb31d40f 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -302,7 +302,7 @@ static void dns_resolver_describe(const struct key *key, struct seq_file *m)
  * - the key's semaphore is read-locked
  */
 static long dns_resolver_read(const struct key *key,
-			      char __user *buffer, size_t buflen)
+			      char *buffer, size_t buflen)
 {
 	int err = PTR_ERR(key->payload.data[dns_key_error]);
 
-- 
2.18.1
