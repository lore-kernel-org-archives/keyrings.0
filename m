From: David Howells <dhowells@redhat.com>
Date: Mon, 30 Oct 2017 15:38:09 +0000
Subject: [PATCH 3/4] security: keys: Replace time_t with time64_t for struct key_preparsed_payload
Message-Id: <150937788989.31781.5673897968859253387.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150937786557.31781.15521097996984061107.stgit@warthog.procyon.org.uk>
In-Reply-To: <150937786557.31781.15521097996984061107.stgit@warthog.procyon.org.uk>
To: tglx@linutronix.de
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org

From: Baolin Wang <baolin.wang@linaro.org>

The 'struct key_preparsed_payload' will use 'time_t' which we will
try to remove in the kernel, since 'time_t' is not year 2038 safe on
32bits systems.

Thus this patch replaces 'time_t' with 'time64_t' which is year 2038
safe on 32 bits system for 'struct key_preparsed_payload', moreover
we should use the 'TIME64_MAX' macro to initialize the 'time64_t'
type variable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
---

 include/linux/key-type.h |    2 +-
 security/keys/key.c      |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 9520fc3c3b9a..05d8fb5a06c4 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -44,7 +44,7 @@ struct key_preparsed_payload {
 	const void	*data;		/* Raw data */
 	size_t		datalen;	/* Raw datalen */
 	size_t		quotalen;	/* Quota length for proposed payload */
-	time_t		expiry;		/* Expiry time of key */
+	time64_t	expiry;		/* Expiry time of key */
 } __randomize_layout;
 
 typedef int (*request_key_actor_t)(struct key_construction *key,
diff --git a/security/keys/key.c b/security/keys/key.c
index 291a67c45b65..d5c8941ae3fd 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -446,7 +446,7 @@ static int __key_instantiate_and_link(struct key *key,
 			if (authkey)
 				key_revoke(authkey);
 
-			if (prep->expiry != TIME_T_MAX) {
+			if (prep->expiry != TIME64_MAX) {
 				key->expiry = prep->expiry;
 				key_schedule_gc(prep->expiry + key_gc_delay);
 			}
@@ -492,7 +492,7 @@ int key_instantiate_and_link(struct key *key,
 	prep.data = data;
 	prep.datalen = datalen;
 	prep.quotalen = key->type->def_datalen;
-	prep.expiry = TIME_T_MAX;
+	prep.expiry = TIME64_MAX;
 	if (key->type->preparse) {
 		ret = key->type->preparse(&prep);
 		if (ret < 0)
@@ -834,7 +834,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	prep.data = payload;
 	prep.datalen = plen;
 	prep.quotalen = index_key.type->def_datalen;
-	prep.expiry = TIME_T_MAX;
+	prep.expiry = TIME64_MAX;
 	if (index_key.type->preparse) {
 		ret = index_key.type->preparse(&prep);
 		if (ret < 0) {
@@ -968,7 +968,7 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 	prep.data = payload;
 	prep.datalen = plen;
 	prep.quotalen = key->type->def_datalen;
-	prep.expiry = TIME_T_MAX;
+	prep.expiry = TIME64_MAX;
 	if (key->type->preparse) {
 		ret = key->type->preparse(&prep);
 		if (ret < 0)

