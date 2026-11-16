Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807690;
	b=OGVQYWH8YteqyzBMusgrWLeoQW4LpBlfQGisF/dyb4EqVYyukE4YqPwaJWkXQYWGd4r1
	 +NDwBWBnZfPxCyhx1sh8MsL1WS/yIEI+aIpUTHvRdx32ycB4A0sNis+cC9tbkfUNVBrRh
	 TDl8PNRPEzLnF56cu33B5A7pIFizz+fW/dEMYIr1IGGSGeojpF/60p/IphW/qxufQHuOk
	 L5bYRLdt+dQ/xNcz0IHicWGpxcz+cKnjQiOQaNXBwvaKdRvlVUwPWUMQi+rJuausWx8Ae
	 B+lXRgi8VvNa9sc/VslquMMezhfpxSQGpxcPGAq63iySaQePUP7oa5eH46H5HiC7u6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807690;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=VMbPMMQ/Q4Ar4j8aeq+C7b5Mr9e7B0t7iqG3UGmzt0Q=;
	b=cAs/duE4Sqj4h82mF9gZblfcjC9pwBf6H5vwifF/bxkY6Fu3nsrnZfK7wemzfKwBfaW3
	 Hfcl1WE7fuFdrbrnN9s08Li8nsiR73FpPwybAVHrfU3djQlHqnK92cdKGRctgtLFhHyXW
	 EbgYA1Uc0dw4BjfrYHEMoIAexHWEBmGqJBfmQJdLnCsZVvTvvCrCoVQN1FKJodC6BLfoU
	 FMtYmwe0At5LJYjUPvkOuNI2/A8NylvGnyRfzyWWY2HomTSb9CwY7GuDDh9FYBWh3Nuhw
	 fynHW/PcbxTNAZFwDAM9fjGNZrwMp6jqmQKdCmNMqRElTZptfWk24wtoShYSsJkSN4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logarcheon.com;
	spf=pass smtp.mailfrom=logarcheon.com;
	dkim=pass header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=DXDUS2nD;
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC0606A323;
	Mon, 16 Nov 2026 05:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64CC0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=DXDUS2nD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logarcheon.com;
	s=protonmail3; t=1794807686; x=1795066886;
	bh=VMbPMMQ/Q4Ar4j8aeq+C7b5Mr9e7B0t7iqG3UGmzt0Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DXDUS2nDTGKnhnENzCu+YktjMWhKOtIgJeZ1hubhGdevuSLZtNa22PBehmE3ODcv6
	 yuVNrAo7LM2+2/QcE45xyhlHL7HcygWTJK+NUR0NbfgJUY9VBZ6kKlzAh8dxtrJ1Ue
	 dkKjDpKJVEHFF3fhTGhMs967VLGTn84CxwB6wnQW2mUJn0eHTabs7QQuDhXcjUlF0z
	 3orWIPnMQDW6o8TCH17fubIlK87RsLyqbOVfT2CapPHoTw16lXPs60Hw64+SgEhUf7
	 dTTmC/9nTc/J5WKCAEI3BwGadOZbNQy14/PrJcSLJULPNYMl+aBUT4XdMcWXSKjq9X
	 A3Y57Em8Ipbkg==
Date: Mon, 16 Nov 2026 05:41:21 +0000
To: akpm@linux-foundation.org
From: William Chuang <founder@logarcheon.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, William Chuang <founder@logarcheon.com>
Subject: [PATCH 1/2] lib/assoc_array: add KUnit test suite
Message-ID: <20261116054112.39078-2-founder@logarcheon.com>
In-Reply-To: <20261116054112.39078-1-founder@logarcheon.com>
References: <20261116054112.39078-1-founder@logarcheon.com>
Feedback-ID: 145408520:user:proton
X-Pm-Message-ID: 39b58d593bddc2d43556c38963f57593f087a6cb
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

lib/assoc_array.c has had no tests since it was added in 2013, though
it indexes the keys held in every keyring and has needed several
correctness fixes over the years.  Eric Biggers noted the gap while
reviewing one such fix and observed that the code runs easily in
userspace, so KUnit is a good fit.

Add a suite that drives an associative array through insertion,
replacement, deletion, clearance, iteration and garbage collection
while keeping a parallel model of the expected contents.  After each
operation it checks that every present key is found, every absent key
is not, iteration visits each object exactly once, and
nr_leaves_on_tree matches the model.  Objects are reference counted the
way keyrings count keys, so a leak, double free or premature free shows
up as a non-zero live count or a refcount warning; the suite passes
under KASAN.

Keys are generated in several layouts (dense integers, uniformly
random, high-bit-only and sparse clusters) to drive the tree into wide
nodes, deep clusters and shortcuts, and the index-key space is kept
small enough that near-miss probes exercise shortcut matching.  Some
cases rebuild the tree shapes behind earlier fixes and name the commit
they guard: the node split of commit ea6789980fda ("assoc_array: Fix a
buggy node-splitting case", CVE-2017-12193), shortcut creation of
commit bb2ba2d75a2d ("assoc_array: Fix shortcut creation"), the
leaf/meta comparison of commit 8d4a2ec1e0b4 ("assoc_array: don't call
compare_object() on a node") and the final-word trim of commit
a82c8a05e86f ("assoc_array: trim the final shortcut word using the
current chunk end").  Reverting any of those four fixes makes the suite
fail.

Run with:

  ./tools/testing/kunit/kunit.py run assoc_array

Signed-off-by: William Chuang <founder@logarcheon.com>
---
 lib/Kconfig.debug             |  17 +
 lib/tests/Makefile            |   1 +
 lib/tests/assoc_array_kunit.c | 963 ++++++++++++++++++++++++++++++++++
 3 files changed, 981 insertions(+)
 create mode 100644 lib/tests/assoc_array_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec..d68f29764 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2830,6 +2830,23 @@ config SYSCTL_KUNIT_TEST
=20
 =09  If unsure, say N.
=20
+config ASSOC_ARRAY_KUNIT_TEST
+=09tristate "KUnit test for the generic associative array" if !KUNIT_ALL_T=
ESTS
+=09depends on KUNIT
+=09select ASSOCIATIVE_ARRAY
+=09default KUNIT_ALL_TESTS
+=09help
+=09  This builds the KUnit test suite for the generic associative array
+=09  (lib/assoc_array.c), which indexes the keys held in keyrings.
+=09  It checks insertion, deletion, garbage collection and lookup
+=09  against a model of the expected contents, including the tree
+=09  shapes behind earlier fixes to the implementation.
+
+=09  For more information on KUnit and unit tests in general please refer
+=09  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+=09  If unsure, say N.
+
 config ERRSEQ_KUNIT_TEST
 =09tristate "KUnit test for errseq" if !KUNIT_ALL_TESTS
 =09depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index df0537e1b..3e9c4a67d 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -5,6 +5,7 @@
 # KUnit tests
 CFLAGS_bitfield_kunit.o :=3D $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_842_DECOMPRESS_KUNIT_TEST) +=3D 842_decompress_kunit.o
+obj-$(CONFIG_ASSOC_ARRAY_KUNIT_TEST) +=3D assoc_array_kunit.o
 obj-$(CONFIG_BASE64_KUNIT) +=3D base64_kunit.o
 obj-$(CONFIG_BITOPS_KUNIT) +=3D bitops_kunit.o
 obj-$(CONFIG_BITFIELD_KUNIT) +=3D bitfield_kunit.o
diff --git a/lib/tests/assoc_array_kunit.c b/lib/tests/assoc_array_kunit.c
new file mode 100644
index 000000000..bd253b6f6
--- /dev/null
+++ b/lib/tests/assoc_array_kunit.c
@@ -0,0 +1,963 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * KUnit tests for the generic associative array (lib/assoc_array.c).
+ *
+ * Every test keeps a model of what the array should hold and, after each
+ * operation, checks the array against it: every present key must be found=
,
+ * every absent key must not be, iteration must visit each object exactly
+ * once and nr_leaves_on_tree must equal the number of present keys.
+ * Objects are reference counted the way keyrings count keys, so leaks,
+ * double frees and premature frees show up as a non-zero live count or a
+ * refcount warning.
+ *
+ * Several cases rebuild the tree shapes behind earlier fixes to
+ * lib/assoc_array.c; each such case names the commit it guards.
+ */
+
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include <linux/assoc_array.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/prandom.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+
+#define AA_KEY_WORDS=093
+#define AA_KEY_BITS=09(AA_KEY_WORDS * BITS_PER_LONG)
+#define AA_MAGIC=090x61737363UL=09/* "assc" */
+
+struct aa_key {
+=09unsigned long w[AA_KEY_WORDS];
+};
+
+struct aa_ctx;
+
+struct aa_obj {
+=09unsigned long magic;
+=09struct aa_key key;
+=09refcount_t ref;
+=09struct aa_ctx *ctx;
+=09unsigned int idx;=09/* model slot */
+=09bool keep;=09=09/* gc verdict */
+};
+
+/* One model slot per key the test may use. */
+struct aa_slot {
+=09struct aa_key key;
+=09struct aa_obj *obj;=09/* NULL if the key is absent */
+};
+
+struct aa_ctx {
+=09struct kunit *test;
+=09struct assoc_array array;
+=09struct aa_slot *slots;
+=09unsigned int nr_slots;
+=09unsigned int *seen;=09/* iteration visit counts */
+=09atomic_t live;=09=09/* objects allocated and not yet freed */
+=09struct rnd_state rnd;
+};
+
+/* ---------- Operations table ---------- */
+
+static const struct aa_obj *aa_check_obj(const void *object)
+{
+=09const struct aa_obj *obj =3D object;
+
+=09if (obj->magic !=3D AA_MAGIC)
+=09=09kunit_fail_current_test("method called on a non-object %p", object);
+=09return obj;
+}
+
+static unsigned long aa_key_chunk(const struct aa_key *key, int level)
+{
+=09int i =3D level / ASSOC_ARRAY_KEY_CHUNK_SIZE;
+
+=09return i < AA_KEY_WORDS ? key->w[i] : 0;
+}
+
+static unsigned long aa_get_key_chunk(const void *index_key, int level)
+{
+=09return aa_key_chunk(index_key, level);
+}
+
+static unsigned long aa_get_object_key_chunk(const void *object, int level=
)
+{
+=09return aa_key_chunk(&aa_check_obj(object)->key, level);
+}
+
+static bool aa_compare_object(const void *object, const void *index_key)
+{
+=09return !memcmp(&aa_check_obj(object)->key, index_key, sizeof(struct aa_=
key));
+}
+
+static int aa_diff_objects(const void *object, const void *index_key)
+{
+=09const struct aa_key *a =3D &aa_check_obj(object)->key;
+=09const struct aa_key *b =3D index_key;
+=09int i;
+
+=09for (i =3D 0; i < AA_KEY_WORDS; i++) {
+=09=09unsigned long x =3D a->w[i] ^ b->w[i];
+
+=09=09if (x)
+=09=09=09return i * BITS_PER_LONG + __ffs(x);
+=09}
+=09return -1;
+}
+
+static void aa_put(struct aa_obj *obj)
+{
+=09if (refcount_dec_and_test(&obj->ref)) {
+=09=09atomic_dec(&obj->ctx->live);
+=09=09obj->magic =3D 0;
+=09=09kfree(obj);
+=09}
+}
+
+static void aa_free_object(void *object)
+{
+=09aa_put(object);
+}
+
+static const struct assoc_array_ops aa_ops =3D {
+=09.get_key_chunk=09=09=3D aa_get_key_chunk,
+=09.get_object_key_chunk=09=3D aa_get_object_key_chunk,
+=09.compare_object=09=09=3D aa_compare_object,
+=09.diff_objects=09=09=3D aa_diff_objects,
+=09.free_object=09=09=3D aa_free_object,
+};
+
+/* ---------- Context and model ---------- */
+
+/*
+ * Runs when the test ends, even after a failed assertion, so that no RCU
+ * callback can reach the context after KUnit has freed it.
+ */
+static void aa_ctx_cleanup(void *data)
+{
+=09struct aa_ctx *ctx =3D data;
+
+=09assoc_array_destroy(&ctx->array, &aa_ops);
+=09rcu_barrier();
+}
+
+static struct aa_ctx *aa_ctx_new(struct kunit *test, unsigned int nr_slots=
, u64 seed)
+{
+=09struct aa_ctx *ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+
+=09KUNIT_ASSERT_NOT_NULL(test, ctx);
+=09ctx->test =3D test;
+=09ctx->nr_slots =3D nr_slots;
+=09ctx->slots =3D kunit_kcalloc(test, nr_slots, sizeof(*ctx->slots), GFP_K=
ERNEL);
+=09ctx->seen =3D kunit_kcalloc(test, nr_slots, sizeof(*ctx->seen), GFP_KER=
NEL);
+=09KUNIT_ASSERT_NOT_NULL(test, ctx->slots);
+=09KUNIT_ASSERT_NOT_NULL(test, ctx->seen);
+=09assoc_array_init(&ctx->array);
+=09atomic_set(&ctx->live, 0);
+=09prandom_seed_state(&ctx->rnd, seed);
+=09KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, aa_ctx_cleanup, c=
tx), 0);
+=09return ctx;
+}
+
+static unsigned long aa_rand_long(struct aa_ctx *ctx)
+{
+=09unsigned long v =3D prandom_u32_state(&ctx->rnd);
+
+#if BITS_PER_LONG =3D=3D 64
+=09v =3D (v << 32) | prandom_u32_state(&ctx->rnd);
+#endif
+=09return v;
+}
+
+static unsigned int aa_rand_below(struct aa_ctx *ctx, unsigned int n)
+{
+=09return prandom_u32_state(&ctx->rnd) % n;
+}
+
+/* The four bits of @key starting at @bit (a multiple of 4). */
+static unsigned long aa_key_nibble(const struct aa_key *key, int bit)
+{
+=09return (key->w[bit / BITS_PER_LONG] >> (bit % BITS_PER_LONG)) & 0xf;
+}
+
+static void aa_key_set_nibble(struct aa_key *key, int bit, unsigned long v=
al)
+{
+=09int w =3D bit / BITS_PER_LONG, s =3D bit % BITS_PER_LONG;
+
+=09key->w[w] &=3D ~(0xfUL << s);
+=09key->w[w] |=3D (val & 0xf) << s;
+}
+
+/* Keep bits below @bit from @prefix and take the rest from @tail. */
+static void aa_key_splice(struct aa_key *key, const struct aa_key *prefix,
+=09=09=09  const struct aa_key *tail, int bit)
+{
+=09int i;
+
+=09for (i =3D 0; i < AA_KEY_WORDS; i++) {
+=09=09int lo =3D i * BITS_PER_LONG;
+=09=09unsigned long mask;
+
+=09=09if (bit <=3D lo)
+=09=09=09mask =3D 0;
+=09=09else if (bit >=3D lo + BITS_PER_LONG)
+=09=09=09mask =3D ULONG_MAX;
+=09=09else
+=09=09=09mask =3D (1UL << (bit - lo)) - 1;
+=09=09key->w[i] =3D (prefix->w[i] & mask) | (tail->w[i] & ~mask);
+=09}
+}
+
+static void aa_random_key(struct aa_ctx *ctx, struct aa_key *key)
+{
+=09int i;
+
+=09for (i =3D 0; i < AA_KEY_WORDS; i++)
+=09=09key->w[i] =3D aa_rand_long(ctx);
+}
+
+static struct aa_slot *aa_model_find(struct aa_ctx *ctx, const struct aa_k=
ey *key)
+{
+=09unsigned int i;
+
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09if (!memcmp(&ctx->slots[i].key, key, sizeof(*key)))
+=09=09=09return &ctx->slots[i];
+=09return NULL;
+}
+
+static unsigned int aa_model_count(struct aa_ctx *ctx)
+{
+=09unsigned int i, n =3D 0;
+
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09n +=3D !!ctx->slots[i].obj;
+=09return n;
+}
+
+static struct aa_obj *aa_obj_new(struct aa_ctx *ctx, unsigned int idx)
+{
+=09struct aa_obj *obj =3D kzalloc_obj(*obj);
+
+=09KUNIT_ASSERT_NOT_NULL(ctx->test, obj);
+=09obj->magic =3D AA_MAGIC;
+=09obj->key =3D ctx->slots[idx].key;
+=09obj->ctx =3D ctx;
+=09obj->idx =3D idx;
+=09refcount_set(&obj->ref, 1);
+=09atomic_inc(&ctx->live);
+=09return obj;
+}
+
+/* ---------- Operations, each applied to both the array and the model ---=
------- */
+
+static void aa_insert(struct aa_ctx *ctx, unsigned int idx)
+{
+=09struct aa_obj *obj =3D aa_obj_new(ctx, idx);
+=09struct assoc_array_edit *edit;
+
+=09edit =3D assoc_array_insert(&ctx->array, &aa_ops, &obj->key, obj);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(ctx->test, edit);
+=09assoc_array_apply_edit(edit);
+=09/* Any object previously at this key is now freed by the edit. */
+=09ctx->slots[idx].obj =3D obj;
+}
+
+static void aa_delete(struct aa_ctx *ctx, unsigned int idx)
+{
+=09struct assoc_array_edit *edit;
+
+=09edit =3D assoc_array_delete(&ctx->array, &aa_ops, &ctx->slots[idx].key)=
;
+=09if (!ctx->slots[idx].obj) {
+=09=09KUNIT_EXPECT_NULL(ctx->test, edit);
+=09=09return;
+=09}
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(ctx->test, edit);
+=09assoc_array_apply_edit(edit);
+=09ctx->slots[idx].obj =3D NULL;
+}
+
+static bool aa_gc_iterator(void *object, void *data)
+{
+=09struct aa_obj *obj =3D object;
+
+=09aa_check_obj(obj);
+=09if (!obj->keep)
+=09=09return false;
+=09refcount_inc(&obj->ref);
+=09return true;
+}
+
+/*
+ * Garbage collect, keeping the present keys for which @keep[i] is true.
+ * The verdicts are copied into the objects before the call, because a
+ * discarded object may be freed as soon as an RCU grace period ends.
+ */
+static void aa_gc(struct aa_ctx *ctx, const bool *keep)
+{
+=09unsigned int i;
+
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09if (ctx->slots[i].obj)
+=09=09=09ctx->slots[i].obj->keep =3D keep[i];
+
+=09KUNIT_ASSERT_EQ(ctx->test, assoc_array_gc(&ctx->array, &aa_ops,
+=09=09=09=09=09=09  aa_gc_iterator, NULL), 0);
+
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09if (!keep[i])
+=09=09=09ctx->slots[i].obj =3D NULL;
+}
+
+static int aa_iterator(const void *object, void *data)
+{
+=09struct aa_ctx *ctx =3D data;
+=09const struct aa_obj *obj =3D aa_check_obj(object);
+
+=09if (obj->idx < ctx->nr_slots)
+=09=09ctx->seen[obj->idx]++;
+=09return 0;
+}
+
+/* Check the array against the model. */
+static void aa_check(struct aa_ctx *ctx)
+{
+=09struct kunit *test =3D ctx->test;
+=09unsigned int i;
+
+=09KUNIT_EXPECT_EQ(test, ctx->array.nr_leaves_on_tree, aa_model_count(ctx)=
);
+
+=09for (i =3D 0; i < ctx->nr_slots; i++) {
+=09=09void *found =3D assoc_array_find(&ctx->array, &aa_ops,
+=09=09=09=09=09       &ctx->slots[i].key);
+
+=09=09KUNIT_EXPECT_PTR_EQ_MSG(test, found, ctx->slots[i].obj,
+=09=09=09=09=09"slot %u", i);
+=09}
+
+=09memset(ctx->seen, 0, ctx->nr_slots * sizeof(*ctx->seen));
+=09KUNIT_EXPECT_EQ(test, assoc_array_iterate(&ctx->array, aa_iterator, ctx=
), 0);
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09KUNIT_EXPECT_EQ_MSG(test, ctx->seen[i], ctx->slots[i].obj ? 1U : 0U,
+=09=09=09=09    "slot %u", i);
+}
+
+/* Probe with keys that differ from present keys in one random nibble. */
+static void aa_check_near_misses(struct aa_ctx *ctx, unsigned int probes)
+{
+=09unsigned int n;
+
+=09for (n =3D 0; n < probes; n++) {
+=09=09const struct aa_slot *slot =3D &ctx->slots[aa_rand_below(ctx, ctx->n=
r_slots)];
+=09=09const struct aa_slot *hit;
+=09=09struct aa_key key =3D slot->key;
+=09=09int bit =3D aa_rand_below(ctx, AA_KEY_BITS / 4) * 4;
+=09=09void *found;
+
+=09=09aa_key_set_nibble(&key, bit,
+=09=09=09=09  aa_key_nibble(&key, bit) ^ (1 + aa_rand_below(ctx, 15)));
+=09=09hit =3D aa_model_find(ctx, &key);
+=09=09found =3D assoc_array_find(&ctx->array, &aa_ops, &key);
+=09=09KUNIT_EXPECT_PTR_EQ_MSG(ctx->test, found, hit ? hit->obj : NULL,
+=09=09=09=09=09"near miss of slot bit %d", bit);
+=09}
+}
+
+/* Destroy the array and check that every object was freed exactly once. *=
/
+static void aa_ctx_finish(struct aa_ctx *ctx)
+{
+=09unsigned int i;
+
+=09assoc_array_destroy(&ctx->array, &aa_ops);
+=09KUNIT_EXPECT_NULL(ctx->test, ctx->array.root);
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09ctx->slots[i].obj =3D NULL;
+=09rcu_barrier();
+=09KUNIT_EXPECT_EQ(ctx->test, atomic_read(&ctx->live), 0);
+}
+
+static void aa_shuffle(struct aa_ctx *ctx, unsigned int *order, unsigned i=
nt n)
+{
+=09unsigned int i;
+
+=09for (i =3D 0; i < n; i++)
+=09=09order[i] =3D i;
+=09for (i =3D n - 1; i > 0; i--) {
+=09=09unsigned int j =3D aa_rand_below(ctx, i + 1);
+
+=09=09swap(order[i], order[j]);
+=09}
+}
+
+/* ---------- Basic API ---------- */
+
+static void aa_test_empty(struct kunit *test)
+{
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, 1, 1);
+
+=09aa_random_key(ctx, &ctx->slots[0].key);
+=09aa_check(ctx);
+=09KUNIT_EXPECT_NULL(test, assoc_array_delete(&ctx->array, &aa_ops,
+=09=09=09=09=09=09   &ctx->slots[0].key));
+=09KUNIT_EXPECT_NULL(test, assoc_array_clear(&ctx->array, &aa_ops));
+=09KUNIT_EXPECT_EQ(test, assoc_array_gc(&ctx->array, &aa_ops,
+=09=09=09=09=09     aa_gc_iterator, NULL), 0);
+=09aa_check(ctx);
+=09aa_ctx_finish(ctx);
+}
+
+/* Replacing an object frees the old one once a grace period has passed. *=
/
+static void aa_test_replace(struct kunit *test)
+{
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, 40, 2);
+=09unsigned int i;
+
+=09for (i =3D 0; i < ctx->nr_slots; i++) {
+=09=09ctx->slots[i].key.w[0] =3D i;
+=09=09aa_insert(ctx, i);
+=09}
+=09for (i =3D 0; i < ctx->nr_slots; i +=3D 3)
+=09=09aa_insert(ctx, i);
+=09aa_check(ctx);
+=09rcu_barrier();
+=09KUNIT_EXPECT_EQ(test, atomic_read(&ctx->live), ctx->nr_slots);
+=09aa_ctx_finish(ctx);
+}
+
+/* A cancelled edit leaves the array unchanged and the object to the calle=
r. */
+static void aa_test_cancel(struct kunit *test)
+{
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, 40, 3);
+=09struct assoc_array_edit *edit;
+=09struct aa_obj *obj;
+=09unsigned int i;
+
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09aa_random_key(ctx, &ctx->slots[i].key);
+=09for (i =3D 0; i < ctx->nr_slots - 1; i++)
+=09=09aa_insert(ctx, i);
+
+=09obj =3D aa_obj_new(ctx, ctx->nr_slots - 1);
+=09edit =3D assoc_array_insert(&ctx->array, &aa_ops, &obj->key, obj);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, edit);
+=09assoc_array_cancel_edit(edit);
+=09aa_check(ctx);
+=09KUNIT_EXPECT_EQ(test, refcount_read(&obj->ref), 1);
+=09aa_put(obj);
+
+=09edit =3D assoc_array_delete(&ctx->array, &aa_ops, &ctx->slots[0].key);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, edit);
+=09assoc_array_cancel_edit(edit);
+=09aa_check(ctx);
+
+=09edit =3D assoc_array_clear(&ctx->array, &aa_ops);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, edit);
+=09assoc_array_cancel_edit(edit);
+=09aa_check(ctx);
+
+=09aa_ctx_finish(ctx);
+}
+
+/*
+ * Insert with a NULL object and fill it in before applying, as
+ * __key_link_begin() and __key_link() do for keyrings.
+ */
+static void aa_test_insert_set_object(struct kunit *test)
+{
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, 64, 4);
+=09unsigned int i;
+
+=09for (i =3D 0; i < ctx->nr_slots; i++) {
+=09=09struct assoc_array_edit *edit;
+=09=09struct aa_obj *obj;
+
+=09=09aa_random_key(ctx, &ctx->slots[i].key);
+=09=09edit =3D assoc_array_insert(&ctx->array, &aa_ops, &ctx->slots[i].key=
, NULL);
+=09=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, edit);
+=09=09obj =3D aa_obj_new(ctx, i);
+=09=09assoc_array_insert_set_object(edit, obj);
+=09=09assoc_array_apply_edit(edit);
+=09=09ctx->slots[i].obj =3D obj;
+=09}
+=09aa_check(ctx);
+=09aa_ctx_finish(ctx);
+}
+
+static int aa_stop_iterator(const void *object, void *data)
+{
+=09unsigned int *calls =3D data;
+
+=09aa_check_obj(object);
+=09return ++(*calls) =3D=3D 5 ? 42 : 0;
+}
+
+/* Iteration stops at, and returns, the first non-zero callback result. */
+static void aa_test_iterate_stop(struct kunit *test)
+{
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, 100, 5);
+=09unsigned int i, calls =3D 0;
+
+=09for (i =3D 0; i < ctx->nr_slots; i++) {
+=09=09aa_random_key(ctx, &ctx->slots[i].key);
+=09=09aa_insert(ctx, i);
+=09}
+=09KUNIT_EXPECT_EQ(test, assoc_array_iterate(&ctx->array, aa_stop_iterator=
,
+=09=09=09=09=09=09  &calls), 42);
+=09KUNIT_EXPECT_EQ(test, calls, 5U);
+=09aa_ctx_finish(ctx);
+}
+
+/* Clearing frees every object; the array can be reused afterwards. */
+static void aa_test_clear(struct kunit *test)
+{
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, 300, 6);
+=09struct assoc_array_edit *edit;
+=09unsigned int i;
+
+=09for (i =3D 0; i < ctx->nr_slots; i++) {
+=09=09ctx->slots[i].key.w[0] =3D i;
+=09=09aa_insert(ctx, i);
+=09}
+=09edit =3D assoc_array_clear(&ctx->array, &aa_ops);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, edit);
+=09assoc_array_apply_edit(edit);
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09ctx->slots[i].obj =3D NULL;
+=09aa_check(ctx);
+=09rcu_barrier();
+=09KUNIT_EXPECT_EQ(test, atomic_read(&ctx->live), 0);
+
+=09for (i =3D 0; i < ctx->nr_slots; i +=3D 2)
+=09=09aa_insert(ctx, i);
+=09aa_check(ctx);
+=09aa_ctx_finish(ctx);
+}
+
+/* ---------- Key layouts ---------- */
+
+/*
+ * Index keys are consumed four bits per level, starting from the least
+ * significant bit of the first word.  Each layout below drives the tree
+ * into a different shape.
+ */
+enum aa_layout {
+=09AA_DENSE,=09/* small integers: wide, shallow nodes */
+=09AA_RANDOM,=09/* uniformly random keys */
+=09AA_HIGH_BITS,=09/* only the top nibble of each word varies: shortcuts *=
/
+=09AA_SPARSE,=09/* 2 bits in 4 random nibbles vary: deep clusters */
+};
+
+struct aa_layout_param {
+=09const char *name;
+=09enum aa_layout layout;
+=09unsigned int nr;
+};
+
+static const struct aa_layout_param aa_layout_params[] =3D {
+=09{ "dense",=09AA_DENSE,=09600 },
+=09{ "random",=09AA_RANDOM,=09600 },
+=09{ "high-bits",=09AA_HIGH_BITS,=09300 },
+=09{ "sparse",=09AA_SPARSE,=09250 },
+};
+
+KUNIT_ARRAY_PARAM_DESC(aa_layout, aa_layout_params, name);
+
+static void aa_fill_keys(struct aa_ctx *ctx, enum aa_layout layout)
+{
+=09int nibbles[4];
+=09unsigned int i, j;
+
+=09for (j =3D 0; j < ARRAY_SIZE(nibbles); j++)
+=09=09nibbles[j] =3D aa_rand_below(ctx, AA_KEY_BITS / 4) * 4;
+
+=09for (i =3D 0; i < ctx->nr_slots; i++) {
+=09=09struct aa_key *key =3D &ctx->slots[i].key;
+
+=09=09memset(key, 0, sizeof(*key));
+=09=09switch (layout) {
+=09=09case AA_DENSE:
+=09=09=09key->w[0] =3D i;
+=09=09=09break;
+=09=09case AA_RANDOM:
+=09=09=09aa_random_key(ctx, key);
+=09=09=09break;
+=09=09case AA_HIGH_BITS:
+=09=09=09for (j =3D 0; j < AA_KEY_WORDS; j++)
+=09=09=09=09key->w[j] =3D (unsigned long)((i >> (4 * j)) & 0xf) <<
+=09=09=09=09=09    (BITS_PER_LONG - 4);
+=09=09=09break;
+=09=09case AA_SPARSE:
+=09=09=09/* Base-4 digits of i spread over four distant nibbles. */
+=09=09=09for (j =3D 0; j < ARRAY_SIZE(nibbles); j++)
+=09=09=09=09aa_key_set_nibble(key, nibbles[j],
+=09=09=09=09=09=09  aa_key_nibble(key, nibbles[j]) |
+=09=09=09=09=09=09  ((i >> (2 * j)) & 3));
+=09=09=09break;
+=09=09}
+=09=09/* Duplicate keys would make the model ambiguous. */
+=09=09while (aa_model_find(ctx, key) !=3D &ctx->slots[i])
+=09=09=09key->w[AA_KEY_WORDS - 1] +=3D aa_rand_long(ctx) | 1;
+=09}
+}
+
+/*
+ * The complete life cycle: insert in random order, replace some, delete
+ * half, garbage collect, reinsert, clear.
+ */
+static void aa_test_lifecycle(struct kunit *test)
+{
+=09const struct aa_layout_param *p =3D test->param_value;
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, p->nr, 7 + p->layout);
+=09unsigned int *order;
+=09struct assoc_array_edit *edit;
+=09bool *keep;
+=09unsigned int i;
+
+=09order =3D kunit_kcalloc(test, p->nr, sizeof(*order), GFP_KERNEL);
+=09keep =3D kunit_kcalloc(test, p->nr, sizeof(*keep), GFP_KERNEL);
+=09KUNIT_ASSERT_NOT_NULL(test, order);
+=09KUNIT_ASSERT_NOT_NULL(test, keep);
+=09aa_fill_keys(ctx, p->layout);
+
+=09aa_shuffle(ctx, order, p->nr);
+=09for (i =3D 0; i < p->nr; i++)
+=09=09aa_insert(ctx, order[i]);
+=09aa_check(ctx);
+=09aa_check_near_misses(ctx, 200);
+
+=09for (i =3D 0; i < p->nr; i +=3D 7)
+=09=09aa_insert(ctx, i);
+=09aa_check(ctx);
+
+=09aa_shuffle(ctx, order, p->nr);
+=09for (i =3D 0; i < p->nr / 2; i++)
+=09=09aa_delete(ctx, order[i]);
+=09aa_check(ctx);
+=09aa_check_near_misses(ctx, 200);
+
+=09for (i =3D 0; i < p->nr; i++)
+=09=09keep[i] =3D aa_rand_below(ctx, 3) !=3D 0;
+=09aa_gc(ctx, keep);
+=09aa_check(ctx);
+
+=09for (i =3D 0; i < p->nr; i++)
+=09=09if (!ctx->slots[i].obj)
+=09=09=09aa_insert(ctx, i);
+=09aa_check(ctx);
+
+=09aa_shuffle(ctx, order, p->nr);
+=09for (i =3D 0; i < p->nr; i++)
+=09=09aa_delete(ctx, order[i]);
+=09aa_check(ctx);
+=09KUNIT_EXPECT_NULL(test, ctx->array.root);
+
+=09for (i =3D 0; i < p->nr; i++)
+=09=09aa_insert(ctx, i);
+=09edit =3D assoc_array_clear(&ctx->array, &aa_ops);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, edit);
+=09assoc_array_apply_edit(edit);
+=09for (i =3D 0; i < p->nr; i++)
+=09=09ctx->slots[i].obj =3D NULL;
+=09aa_check(ctx);
+=09aa_ctx_finish(ctx);
+}
+
+/* ---------- Regression cases ---------- */
+
+static const int aa_split_levels[] =3D {
+=090, 4, 8, BITS_PER_LONG - 4, BITS_PER_LONG, BITS_PER_LONG + 4,
+=092 * BITS_PER_LONG - 4, 2 * BITS_PER_LONG,
+};
+
+/*
+ * A node full of leaves that cluster in one slot, then a leaf that wants =
a
+ * different slot, at several depths and behind a shortcut: the node-split=
ting
+ * case fixed by commit ea6789980fda ("assoc_array: Fix a buggy node-split=
ting
+ * case"), CVE-2017-12193.
+ */
+static void aa_test_full_node_outlier(struct kunit *test)
+{
+=09unsigned int l;
+
+=09for (l =3D 0; l < ARRAY_SIZE(aa_split_levels); l++) {
+=09=09int level =3D aa_split_levels[l];
+=09=09struct aa_ctx *ctx =3D aa_ctx_new(test, 32, 100 + l);
+=09=09struct aa_key prefix;
+=09=09unsigned int i;
+
+=09=09aa_random_key(ctx, &prefix);
+=09=09for (i =3D 0; i < 16; i++) {
+=09=09=09struct aa_key *key =3D &ctx->slots[i].key;
+
+=09=09=09/* Share the prefix and the nibble at @level ... */
+=09=09=09aa_random_key(ctx, key);
+=09=09=09aa_key_splice(key, &prefix, key, level + 4);
+=09=09=09/* ... and differ in the next one. */
+=09=09=09aa_key_set_nibble(key, level + 4, i);
+=09=09}
+=09=09/*
+=09=09 * The outliers differ at @level itself; sixteen of them, so
+=09=09 * the node they land in has to split again.
+=09=09 */
+=09=09for (i =3D 16; i < ctx->nr_slots; i++) {
+=09=09=09ctx->slots[i].key =3D prefix;
+=09=09=09aa_key_set_nibble(&ctx->slots[i].key, level,
+=09=09=09=09=09  aa_key_nibble(&prefix, level) ^ 0x5);
+=09=09=09aa_key_set_nibble(&ctx->slots[i].key, level + 4, i - 16);
+=09=09}
+
+=09=09for (i =3D 0; i < ctx->nr_slots; i++) {
+=09=09=09aa_insert(ctx, i);
+=09=09=09aa_check(ctx);
+=09=09}
+=09=09for (i =3D 0; i < ctx->nr_slots; i++) {
+=09=09=09aa_delete(ctx, i);
+=09=09=09aa_check(ctx);
+=09=09}
+=09=09aa_ctx_finish(ctx);
+=09}
+}
+
+struct aa_shortcut_param {
+=09const char *name;
+=09int split;=09=09/* first bit at which the clustered keys differ */
+=09bool behind_node;=09/* reach the shortcut through a root node */
+};
+
+static const struct aa_shortcut_param aa_shortcut_params[] =3D {
+=09{ "word-1/4",=09=09BITS_PER_LONG - 4,=09false },
+=09{ "word",=09=09BITS_PER_LONG,=09=09false },
+=09{ "word+4",=09=09BITS_PER_LONG + 4,=09false },
+=09{ "1.5-words",=09=09BITS_PER_LONG * 3 / 2,=09false },
+=09{ "2-words-4",=09=092 * BITS_PER_LONG - 4,=09false },
+=09{ "2-words",=09=092 * BITS_PER_LONG,=09false },
+=09{ "2-words+4",=09=092 * BITS_PER_LONG + 4,=09false },
+=09{ "node/word",=09=09BITS_PER_LONG,=09=09true },
+=09{ "node/1.5-words",=09BITS_PER_LONG * 3 / 2,=09true },
+=09{ "node/2-words",=092 * BITS_PER_LONG,=09true },
+};
+
+KUNIT_ARRAY_PARAM_DESC(aa_shortcut, aa_shortcut_params, name);
+
+/*
+ * Keys that agree on every bit below @split make the tree descend through
+ * a shortcut ending at @split.  Shortcut creation and traversal had to be
+ * fixed for shortcuts ending on a word boundary, commit bb2ba2d75a2d
+ * ("assoc_array: Fix shortcut creation"), and for shortcuts whose last
+ * word is only partly used, commit a82c8a05e86f ("assoc_array: trim the
+ * final shortcut word using the current chunk end").
+ *
+ * The near-miss probes differ from the shortcut inside the skipped bits,
+ * so a walk that compares too few or too many shortcut bits returns a
+ * wrong object or fails to find a present one.
+ */
+static void aa_test_shortcut(struct kunit *test)
+{
+=09const struct aa_shortcut_param *p =3D test->param_value;
+=09const unsigned int clustered =3D 24, side =3D 8;
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, clustered + side + 64, 200 + p-=
>split);
+=09unsigned int *order;
+=09struct aa_key prefix;
+=09unsigned int i, n =3D 0;
+
+=09order =3D kunit_kcalloc(test, ctx->nr_slots, sizeof(*order), GFP_KERNEL=
);
+=09KUNIT_ASSERT_NOT_NULL(test, order);
+=09aa_random_key(ctx, &prefix);
+
+=09for (i =3D 0; i < clustered; i++, n++) {
+=09=09struct aa_key *key =3D &ctx->slots[n].key;
+
+=09=09aa_random_key(ctx, key);
+=09=09aa_key_splice(key, &prefix, key, p->split);
+=09=09aa_key_set_nibble(key, p->split, i);
+=09=09if (i >=3D 16)
+=09=09=09aa_key_set_nibble(key, p->split + 4, i);
+=09}
+=09/* Keys that leave the clustered set at the root node. */
+=09for (i =3D 0; p->behind_node && i < side; i++, n++) {
+=09=09aa_random_key(ctx, &ctx->slots[n].key);
+=09=09aa_key_set_nibble(&ctx->slots[n].key, 0,
+=09=09=09=09  aa_key_nibble(&prefix, 0) ^ (1 + i));
+=09}
+=09/*
+=09 * Absent keys that leave the prefix at every nibble below @split,
+=09 * inserted only in the second half of the test.
+=09 */
+=09for (i =3D 0; i < p->split / 4 && n < ctx->nr_slots; i++, n++) {
+=09=09struct aa_key *key =3D &ctx->slots[n].key;
+
+=09=09*key =3D prefix;
+=09=09aa_key_set_nibble(key, i * 4, aa_key_nibble(key, i * 4) ^ 0xa);
+=09}
+=09ctx->nr_slots =3D n;
+
+=09for (i =3D 0; i < clustered + (p->behind_node ? side : 0); i++)
+=09=09aa_insert(ctx, i);
+=09aa_check(ctx);
+=09aa_check_near_misses(ctx, 300);
+
+=09/* Now cut into the shortcut at every nibble. */
+=09for (i =3D clustered + (p->behind_node ? side : 0); i < n; i++) {
+=09=09aa_insert(ctx, i);
+=09=09aa_check(ctx);
+=09}
+=09aa_check_near_misses(ctx, 300);
+
+=09aa_shuffle(ctx, order, n);
+=09for (i =3D 0; i < n; i++) {
+=09=09aa_delete(ctx, order[i]);
+=09=09aa_check(ctx);
+=09}
+=09aa_ctx_finish(ctx);
+}
+
+/*
+ * Fill a node's slots with child nodes, then let garbage collection keep
+ * only @kept[s] leaves under slot s.  With few survivors per child the
+ * tree has to pack back down as part of the same pass, which exercises
+ * the node-folding code in assoc_array_gc().
+ */
+static void aa_gc_fold_one(struct kunit *test, const unsigned int *kept, u=
64 seed)
+{
+=09const unsigned int per_slot =3D 18;
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, 16 * per_slot, seed);
+=09bool *keep;
+=09unsigned int s, i;
+
+=09keep =3D kunit_kcalloc(test, ctx->nr_slots, sizeof(*keep), GFP_KERNEL);
+=09KUNIT_ASSERT_NOT_NULL(test, keep);
+
+=09for (s =3D 0; s < 16; s++) {
+=09=09for (i =3D 0; i < per_slot; i++) {
+=09=09=09unsigned int idx =3D s * per_slot + i;
+=09=09=09struct aa_key *key =3D &ctx->slots[idx].key;
+
+=09=09=09aa_random_key(ctx, key);
+=09=09=09aa_key_set_nibble(key, 0, s);
+=09=09=09keep[idx] =3D i < kept[s];
+=09=09}
+=09}
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09aa_insert(ctx, i);
+=09aa_check(ctx);
+=09aa_gc(ctx, keep);
+=09aa_check(ctx);
+
+=09/* The array must stay usable after compaction. */
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09if (!ctx->slots[i].obj)
+=09=09=09aa_insert(ctx, i);
+=09aa_check(ctx);
+=09aa_ctx_finish(ctx);
+}
+
+static void aa_test_gc_fold(struct kunit *test)
+{
+=09struct rnd_state rnd;
+=09unsigned int kept[16];
+=09unsigned int round, s;
+
+=09prandom_seed_state(&rnd, 302);
+=09for (round =3D 0; round < 40; round++) {
+=09=09/* Mostly empty children, a few with 1-3 survivors. */
+=09=09for (s =3D 0; s < 16; s++)
+=09=09=09kept[s] =3D prandom_u32_state(&rnd) % 4 ?
+=09=09=09=09  0 : 1 + prandom_u32_state(&rnd) % 3;
+=09=09aa_gc_fold_one(test, kept, 303 + round);
+=09}
+}
+
+/* Garbage collection that keeps nothing, or everything. */
+static void aa_test_gc_all_or_nothing(struct kunit *test)
+{
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, 500, 400);
+=09bool *keep;
+=09unsigned int i;
+
+=09keep =3D kunit_kcalloc(test, ctx->nr_slots, sizeof(*keep), GFP_KERNEL);
+=09KUNIT_ASSERT_NOT_NULL(test, keep);
+=09for (i =3D 0; i < ctx->nr_slots; i++) {
+=09=09aa_random_key(ctx, &ctx->slots[i].key);
+=09=09aa_insert(ctx, i);
+=09=09keep[i] =3D true;
+=09}
+=09aa_gc(ctx, keep);
+=09aa_check(ctx);
+
+=09memset(keep, 0, ctx->nr_slots * sizeof(*keep));
+=09aa_gc(ctx, keep);
+=09aa_check(ctx);
+=09rcu_barrier();
+=09KUNIT_EXPECT_EQ(test, atomic_read(&ctx->live), 0);
+
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09aa_insert(ctx, i);
+=09aa_check(ctx);
+=09aa_ctx_finish(ctx);
+}
+
+/* ---------- Randomised operations ---------- */
+
+/*
+ * Random inserts, replacements, deletions and garbage collections over a
+ * small, heavily clustered key space, checked after every operation.
+ */
+static void aa_test_random_ops(struct kunit *test)
+{
+=09unsigned int round;
+
+=09for (round =3D 0; round < 4; round++) {
+=09=09struct aa_ctx *ctx =3D aa_ctx_new(test, 128, 500 + round);
+=09=09bool *keep;
+=09=09unsigned int op, i;
+
+=09=09keep =3D kunit_kcalloc(test, ctx->nr_slots, sizeof(*keep), GFP_KERNE=
L);
+=09=09KUNIT_ASSERT_NOT_NULL(test, keep);
+=09=09aa_fill_keys(ctx, AA_SPARSE);
+
+=09=09for (op =3D 0; op < 1500; op++) {
+=09=09=09unsigned int r =3D aa_rand_below(ctx, 100);
+
+=09=09=09i =3D aa_rand_below(ctx, ctx->nr_slots);
+=09=09=09if (r < 55) {
+=09=09=09=09aa_insert(ctx, i);
+=09=09=09} else if (r < 97) {
+=09=09=09=09aa_delete(ctx, i);
+=09=09=09} else {
+=09=09=09=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09=09=09=09keep[i] =3D aa_rand_below(ctx, 2);
+=09=09=09=09aa_gc(ctx, keep);
+=09=09=09}
+=09=09=09aa_check(ctx);
+=09=09}
+=09=09aa_ctx_finish(ctx);
+=09}
+}
+
+static struct kunit_case assoc_array_test_cases[] =3D {
+=09KUNIT_CASE(aa_test_empty),
+=09KUNIT_CASE(aa_test_replace),
+=09KUNIT_CASE(aa_test_cancel),
+=09KUNIT_CASE(aa_test_insert_set_object),
+=09KUNIT_CASE(aa_test_iterate_stop),
+=09KUNIT_CASE(aa_test_clear),
+=09KUNIT_CASE_PARAM(aa_test_lifecycle, aa_layout_gen_params),
+=09KUNIT_CASE(aa_test_full_node_outlier),
+=09KUNIT_CASE_PARAM(aa_test_shortcut, aa_shortcut_gen_params),
+=09KUNIT_CASE(aa_test_gc_fold),
+=09KUNIT_CASE(aa_test_gc_all_or_nothing),
+=09KUNIT_CASE_SLOW(aa_test_random_ops),
+=09{}
+};
+
+static struct kunit_suite assoc_array_test_suite =3D {
+=09.name =3D "assoc_array",
+=09.test_cases =3D assoc_array_test_cases,
+};
+
+kunit_test_suite(assoc_array_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the generic associative array");
+MODULE_LICENSE("GPL");
--=20
2.39.1


