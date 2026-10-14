Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590D3A5E87;
	Wed, 14 Oct 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993720; cv=none; b=WsNI5xoHQxhxgsJiUdlQOkJmRcm+hfnf5C+6kvnxjEO/jXxNKZnlauqv7INJK5bpqhiESP5qnKxi+FNRimuD7k4VBNvpqtmGtWLFpnE5+mK2ujQHU+LsDBjQJGugvMrl32bU1AkuJlOKVfK/9UelDWlgJMNMDw6jIqlrysDb8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993720; c=relaxed/simple;
	bh=j44yq0zaHhmcG8C94wliOaeox3WE86EMI6gQSQIzK+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDIMC1ZnSRQXR5Tk6B6cbQhXk9VHtTc61V/Pv9KUAu54AHx8aP1fcZ3NhDz6G9Yoem+CBAyLKYZtsJR/IyQbZCvG5EJn3VTOx4KS6XztrHqnlzmL7mfzp16EpIQA3yDEvvr+EorkF/CD/WikczShW8Hif1RRTYfinNpS6QE8Qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD8TrTh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD8TrTh6"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9B7C01F000C4;
	Wed, 14 Oct 2026 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791993718;
	bh=onZOSGBZ2q+IAeaj4lhP92AA9KPucyMX6J+jm+4IGyw=;
	h=From:To:Cc:Subject:Date;
	b=cD8TrTh6WIiVAbFJq3uThix78gOnhiFEecE7XT3Q3/2rTgdDSG1Mny6T0BYmmNlGX
	 SyNTHLaextatJCyeFcUVAvzBTQatb8CuL0ixV4IkOPKiiAWaN7h3VfRVlFDKdMzXh4
	 D/LwC9onMV1wA0zCp3kKWoTRvTPT+pClsflddPybP94eFEQ70kjC5P0fpy4aBtq2zN
	 M7TN4pzCysCEz9OwJHu5xMo7bdh9n8sAxGO0SqvDeEzDR9ZdByuWugo6ZM4QE3tor4
	 /zqXOIgQ5FFoqRLaNxY9f4bVG38jy+ziqkZ8lwLTiltK8BFvnElPZ1wNbax9AJ2wY2
	 bxY2AHtWSO1iw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rae Moar <raemoar63@gmail.com>,
	Ryota Sakamoto <sakamo.ryota@gmail.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Kir Chou <note351@hotmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit))
Subject: [PATCH] lib/tests: kunit for associative array
Date: Wed, 14 Oct 2026 19:01:38 +0300
Message-ID: <20261014160144.1835860-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a kunit test for lib/assoc_array.c, which maintains a shadow model
across assoc_array operations, and checks its integrity after every
operation.

I wrote a draft version so that I could properly test 'assoc-array-fixes'
tag at Linus' tree, and spent today rewriting a new more polished version
with as good description as I could possibly could on how the seeded test
keys were cherry-picked. Along the way I also tweaked the numbers to be
a bit less messier set than in my original version.

The transcripts that follow were executed with this command-line:

    ./tools/testing/kunit/kunit.py run --raw_output assoc_array

With 'assoc-array-fixes' commits and its subsequent tag iterations all
eight tests pass, and without them all of them fail.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 lib/Kconfig.debug             |  15 +
 lib/tests/Makefile            |   1 +
 lib/tests/assoc_array_kunit.c | 570 ++++++++++++++++++++++++++++++++++
 3 files changed, 586 insertions(+)
 create mode 100644 lib/tests/assoc_array_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6b24a2c89b84..3e8d3852f53c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2857,6 +2857,21 @@ config HASHTABLE_KUNIT_TEST

 	  If unsure, say N.

+config ASSOC_ARRAY_KUNIT_TEST
+	tristate "KUnit test for assoc_array" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select ASSOCIATIVE_ARRAY
+	help
+	  This builds the assoc_array KUnit test suite.
+	  It tests the basic functionality of the API defined in
+	  include/linux/assoc_array.h.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config LINEAR_RANGES_TEST
 	tristate "KUnit test for linear_ranges"
 	depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 3cac3b63a752..107e16b4ebc1 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -4,6 +4,7 @@

 # KUnit tests
 CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
+obj-$(CONFIG_ASSOC_ARRAY_KUNIT_TEST) += assoc_array_kunit.o
 obj-$(CONFIG_BASE64_KUNIT) += base64_kunit.o
 obj-$(CONFIG_BITOPS_KUNIT) += bitops_kunit.o
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
diff --git a/lib/tests/assoc_array_kunit.c b/lib/tests/assoc_array_kunit.c
new file mode 100644
index 000000000000..aeaab366daac
--- /dev/null
+++ b/lib/tests/assoc_array_kunit.c
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jarkko Sakinen
+ *
+ * This is a model based test and has a model invariant that is called after each
+ * and every operation accessing an associative array.
+ */
+
+#include <kunit/test.h>
+#include <linux/assoc_array.h>
+#include <linux/bitmap.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+
+#define ASSOC_ARRAY_TEST_NR_KEYS	64
+#define ASSOC_ARRAY_TEST_STOP_AFTER	5
+#define ASSOC_ARRAY_TEST_STOP_STATUS	123
+
+/*
+ * As a quick remainder, these are the basic building blocks of an associative
+ * array:
+ *
+ * - struct assoc_array_node: a tree node representing a nibble of the search
+ *   key.
+ * - struct assoc_array_shortcut: a tree node representing a sequence of nibbles
+ *   shared by multiple search keys with no divergence among them.
+ *
+ * The keys in array will be created in order in tests, and is a constructed in
+ * a way that splits reach the level 8:
+ *
+ * - 0..16:  Share prefix 0x21 at levels 0 and 4.
+ * - 17:     Splits root shortcut at level 4.
+ * - 18..34: Share chunk 0.
+ * - 35:     Splits shortcut at chunk boundary.
+ * - 36..46: Share prefix 0xbeef at levels 0..12.
+ * - 47:     Splits shortcut at level 8.
+ * - 48..63: Distinct leaves at level 0.
+ *
+ * The numbers were picked partly based on trial and error, and partly trying to
+ * find smallest possible numbers reaching the level 8.
+ */
+static const unsigned long assoc_array_test_keys[ASSOC_ARRAY_TEST_NR_KEYS * 2] = {
+	0x0000000000000121UL, 0x0000000000000000UL,
+	0x0000000000000221UL, 0x0000000000000000UL,
+	0x0000000000000321UL, 0x0000000000000000UL,
+	0x0000000000000421UL, 0x0000000000000000UL,
+	0x0000000000000521UL, 0x0000000000000000UL,
+	0x0000000000000621UL, 0x0000000000000000UL,
+	0x0000000000000721UL, 0x0000000000000000UL,
+	0x0000000000000821UL, 0x0000000000000000UL,
+	0x0000000000000921UL, 0x0000000000000000UL,
+	0x0000000000000a21UL, 0x0000000000000000UL,
+	0x0000000000000b21UL, 0x0000000000000000UL,
+	0x0000000000000c21UL, 0x0000000000000000UL,
+	0x0000000000000d21UL, 0x0000000000000000UL,
+	0x0000000000000e21UL, 0x0000000000000000UL,
+	0x0000000000000f21UL, 0x0000000000000000UL,
+	0x0000000000001021UL, 0x0000000000000000UL,
+	0x0000000000001121UL, 0x0000000000000000UL,
+	0x0000000000000001UL, 0x0000000000000000UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000010UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000020UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000030UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000040UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000050UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000060UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000070UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000080UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000090UL,
+	0xdeadbeefcafebabeUL, 0x00000000000000a0UL,
+	0xdeadbeefcafebabeUL, 0x00000000000000b0UL,
+	0xdeadbeefcafebabeUL, 0x00000000000000c0UL,
+	0xdeadbeefcafebabeUL, 0x00000000000000d0UL,
+	0xdeadbeefcafebabeUL, 0x00000000000000e0UL,
+	0xdeadbeefcafebabeUL, 0x00000000000000f0UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000100UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000110UL,
+	0xdeadbeefcafebabeUL, 0x0000000000000001UL,
+	0x000000000001beefUL, 0x0000000000000000UL,
+	0x000000000002beefUL, 0x0000000000000000UL,
+	0x000000000003beefUL, 0x0000000000000000UL,
+	0x000000000004beefUL, 0x0000000000000000UL,
+	0x000000000005beefUL, 0x0000000000000000UL,
+	0x000000000006beefUL, 0x0000000000000000UL,
+	0x000000000007beefUL, 0x0000000000000000UL,
+	0x000000000008beefUL, 0x0000000000000000UL,
+	0x000000000009beefUL, 0x0000000000000000UL,
+	0x00000000000abeefUL, 0x0000000000000000UL,
+	0x00000000000bbeefUL, 0x0000000000000000UL,
+	0x00000000000000efUL, 0x0000000000000000UL,
+	0x0000000000001000UL, 0x0000000000000000UL,
+	0x0000000000001001UL, 0x0000000000000000UL,
+	0x0000000000001002UL, 0x0000000000000000UL,
+	0x0000000000001003UL, 0x0000000000000000UL,
+	0x0000000000001004UL, 0x0000000000000000UL,
+	0x0000000000001005UL, 0x0000000000000000UL,
+	0x0000000000001006UL, 0x0000000000000000UL,
+	0x0000000000001007UL, 0x0000000000000000UL,
+	0x0000000000001008UL, 0x0000000000000000UL,
+	0x0000000000001009UL, 0x0000000000000000UL,
+	0x000000000000100aUL, 0x0000000000000000UL,
+	0x000000000000100bUL, 0x0000000000000000UL,
+	0x000000000000100cUL, 0x0000000000000000UL,
+	0x000000000000100dUL, 0x0000000000000000UL,
+	0x000000000000100eUL, 0x0000000000000000UL,
+	0x000000000000100fUL, 0x0000000000000000UL,
+};
+
+struct assoc_array_test_object {
+	unsigned long key[2];
+	unsigned long value;
+	refcount_t usage;
+};
+
+static unsigned long assoc_array_test_get_key_chunk(const void *index_key, int level)
+{
+	const unsigned long *key = index_key;
+	int chunk = level / ASSOC_ARRAY_KEY_CHUNK_SIZE;
+
+	return chunk < 2 ? key[chunk] : 0;
+}
+
+static unsigned long assoc_array_test_get_object_key_chunk(const void *object, int level)
+{
+	const struct assoc_array_test_object *obj = object;
+
+	return assoc_array_test_get_key_chunk(obj->key, level);
+}
+
+static bool assoc_array_test_compare_object(const void *object, const void *index_key)
+{
+	const struct assoc_array_test_object *obj = object;
+
+	return !memcmp(obj->key, index_key, sizeof(obj->key));
+}
+
+static int assoc_array_test_diff_objects(const void *object, const void *index_key)
+{
+	const struct assoc_array_test_object *obj = object;
+	const unsigned long *key = index_key;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(obj->key); i++) {
+		unsigned long diff = obj->key[i] ^ key[i];
+
+		if (diff)
+			return i * ASSOC_ARRAY_KEY_CHUNK_SIZE + __ffs(diff);
+	}
+
+	return -1;
+}
+
+static void assoc_array_test_free_object(void *object)
+{
+	struct assoc_array_test_object *obj = object;
+
+	if (refcount_dec_and_test(&obj->usage))
+		kfree(obj);
+}
+
+static const struct assoc_array_ops assoc_array_test_ops = {
+	.get_key_chunk = assoc_array_test_get_key_chunk,
+	.get_object_key_chunk = assoc_array_test_get_object_key_chunk,
+	.compare_object = assoc_array_test_compare_object,
+	.diff_objects = assoc_array_test_diff_objects,
+	.free_object = assoc_array_test_free_object,
+};
+
+struct assoc_array_test_model {
+	struct kunit *test;
+	struct assoc_array array;
+	unsigned long values[ASSOC_ARRAY_TEST_NR_KEYS];
+	bool present[ASSOC_ARRAY_TEST_NR_KEYS];
+	int nr_present;
+};
+
+struct assoc_array_test_iter {
+	const struct assoc_array_test_model *m;
+	DECLARE_BITMAP(visited, ASSOC_ARRAY_TEST_NR_KEYS);
+	int count;
+	int bad;
+};
+
+static void assoc_array_test_model_release(void *data)
+{
+	struct assoc_array_test_model *m = data;
+
+	assoc_array_destroy(&m->array, &assoc_array_test_ops);
+	rcu_barrier();
+}
+
+static int assoc_array_test_model_iterate(const void *object, void *data)
+{
+	const struct assoc_array_test_object *obj = object;
+	struct assoc_array_test_iter *it = data;
+	int i;
+
+	it->count++;
+	for (i = 0; i < ASSOC_ARRAY_TEST_NR_KEYS; i++) {
+		if (!assoc_array_test_compare_object(obj, &assoc_array_test_keys[i * 2]))
+			continue;
+		if (it->m->present[i] && obj->value == it->m->values[i] &&
+		    !__test_and_set_bit(i, it->visited))
+			return 0;
+		break;
+	}
+
+	it->bad++;
+	return 0;
+}
+
+static void assoc_array_test_invariant(struct assoc_array_test_model *m)
+{
+	struct assoc_array_test_iter it = { .m = m };
+	const struct assoc_array_test_object *obj;
+	int i;
+
+	KUNIT_EXPECT_EQ(m->test, m->array.nr_leaves_on_tree, m->nr_present);
+
+	for (i = 0; i < ASSOC_ARRAY_TEST_NR_KEYS; i++) {
+		obj = assoc_array_find(&m->array, &assoc_array_test_ops,
+				       &assoc_array_test_keys[i * 2]);
+		if (!m->present[i]) {
+			KUNIT_EXPECT_NULL(m->test, obj);
+			continue;
+		}
+
+		KUNIT_EXPECT_NOT_NULL(m->test, obj);
+		if (obj)
+			KUNIT_EXPECT_EQ(m->test, obj->value, m->values[i]);
+	}
+
+	KUNIT_EXPECT_EQ(m->test,
+			assoc_array_iterate(&m->array, assoc_array_test_model_iterate, &it),
+			0);
+	KUNIT_EXPECT_EQ(m->test, it.count, m->nr_present);
+	KUNIT_EXPECT_EQ(m->test, it.bad, 0);
+}
+
+static struct assoc_array_test_model *assoc_array_test_model_create(struct kunit *test)
+{
+	struct assoc_array_test_model *m;
+	int ret;
+
+	m = kunit_kzalloc(test, sizeof(*m), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, m);
+	m->test = test;
+	assoc_array_init(&m->array);
+
+	ret = kunit_add_action_or_reset(test, assoc_array_test_model_release, m);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	assoc_array_test_invariant(m);
+
+	return m;
+}
+
+static void assoc_array_test_model_insert(struct assoc_array_test_model *m,
+					  int i, unsigned long value)
+{
+	struct assoc_array_edit *edit;
+	struct assoc_array_test_object *obj;
+
+	obj = kzalloc_obj(*obj, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(m->test, obj);
+	memcpy(obj->key, &assoc_array_test_keys[i * 2], sizeof(obj->key));
+	obj->value = value;
+	refcount_set(&obj->usage, 1);
+
+	edit = assoc_array_insert(&m->array, &assoc_array_test_ops, obj->key, obj);
+	if (IS_ERR_OR_NULL(edit)) {
+		kfree(obj);
+		KUNIT_FAIL_AND_ABORT(m->test, "insert failed: %ld", PTR_ERR(edit));
+	}
+	assoc_array_apply_edit(edit);
+
+	if (!m->present[i]) {
+		m->present[i] = true;
+		m->nr_present++;
+	}
+	m->values[i] = value;
+
+	assoc_array_test_invariant(m);
+}
+
+static void assoc_array_test_model_delete(struct assoc_array_test_model *m, int i)
+{
+	struct assoc_array_edit *edit;
+
+	edit = assoc_array_delete(&m->array, &assoc_array_test_ops,
+				  &assoc_array_test_keys[i * 2]);
+	KUNIT_ASSERT_FALSE(m->test, IS_ERR(edit));
+
+	if (edit)
+		assoc_array_apply_edit(edit);
+	if (m->present[i]) {
+		m->present[i] = false;
+		m->nr_present--;
+	}
+
+	assoc_array_test_invariant(m);
+}
+
+static void assoc_array_test_model_clear(struct assoc_array_test_model *m)
+{
+	struct assoc_array_edit *edit;
+
+	edit = assoc_array_clear(&m->array, &assoc_array_test_ops);
+	KUNIT_ASSERT_FALSE(m->test, IS_ERR(edit));
+
+	if (edit)
+		assoc_array_apply_edit(edit);
+
+	memset(m->present, 0, sizeof(m->present));
+	m->nr_present = 0;
+
+	assoc_array_test_invariant(m);
+}
+
+static void assoc_array_test_model_destroy(struct assoc_array_test_model *m)
+{
+	assoc_array_destroy(&m->array, &assoc_array_test_ops);
+	assoc_array_init(&m->array);
+
+	memset(m->present, 0, sizeof(m->present));
+	m->nr_present = 0;
+
+	assoc_array_test_invariant(m);
+}
+
+static void assoc_array_test_model_fill(struct assoc_array_test_model *m)
+{
+	int i;
+
+	for (i = 0; i < ASSOC_ARRAY_TEST_NR_KEYS; i++)
+		assoc_array_test_model_insert(m, i, i);
+}
+
+struct assoc_array_test_gc_ctx {
+	bool (*keep)(const struct assoc_array_test_object *obj, void *data);
+	void *data;
+};
+
+static bool assoc_array_test_model_gc_filter(void *object, void *data)
+{
+	struct assoc_array_test_object *obj = object;
+	struct assoc_array_test_gc_ctx *ctx = data;
+
+	if (!ctx->keep(obj, ctx->data))
+		return false;
+	refcount_inc(&obj->usage);
+	return true;
+}
+
+static void assoc_array_test_model_gc(struct assoc_array_test_model *m,
+				      bool (*keep)(const struct assoc_array_test_object *obj,
+						   void *data),
+				      void *data)
+{
+	struct assoc_array_test_gc_ctx ctx = { .keep = keep, .data = data };
+	int i, ret;
+
+	ret = assoc_array_gc(&m->array, &assoc_array_test_ops,
+			     assoc_array_test_model_gc_filter, &ctx);
+	KUNIT_ASSERT_EQ(m->test, ret, 0);
+
+	for (i = 0; i < ASSOC_ARRAY_TEST_NR_KEYS; i++) {
+		if (m->present[i]) {
+			struct assoc_array_test_object obj = {
+				.value = m->values[i],
+			};
+
+			memcpy(obj.key, &assoc_array_test_keys[i * 2], sizeof(obj.key));
+
+			if (!keep(&obj, data)) {
+				m->present[i] = false;
+				m->nr_present--;
+			}
+		}
+	}
+
+	assoc_array_test_invariant(m);
+}
+
+static void assoc_array_test_model_cancel_insert(struct assoc_array_test_model *m,
+						 int i, unsigned long value)
+{
+	struct assoc_array_edit *edit;
+	struct assoc_array_test_object *obj;
+
+	obj = kzalloc_obj(*obj, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(m->test, obj);
+	memcpy(obj->key, &assoc_array_test_keys[i * 2], sizeof(obj->key));
+	obj->value = value;
+	refcount_set(&obj->usage, 1);
+
+	edit = assoc_array_insert(&m->array, &assoc_array_test_ops, obj->key, obj);
+	if (IS_ERR_OR_NULL(edit)) {
+		kfree(obj);
+		KUNIT_FAIL_AND_ABORT(m->test, "insert failed: %ld", PTR_ERR(edit));
+	}
+	assoc_array_cancel_edit(edit);
+	kfree(obj);
+
+	assoc_array_test_invariant(m);
+}
+
+static void assoc_array_test_model_cancel_delete(struct assoc_array_test_model *m, int i)
+{
+	struct assoc_array_edit *edit;
+
+	edit = assoc_array_delete(&m->array, &assoc_array_test_ops,
+				  &assoc_array_test_keys[i * 2]);
+	KUNIT_ASSERT_FALSE(m->test, IS_ERR(edit));
+
+	if (edit)
+		assoc_array_cancel_edit(edit);
+
+	assoc_array_test_invariant(m);
+}
+
+static void assoc_array_test_model_cancel_clear(struct assoc_array_test_model *m)
+{
+	struct assoc_array_edit *edit;
+
+	edit = assoc_array_clear(&m->array, &assoc_array_test_ops);
+	KUNIT_ASSERT_FALSE(m->test, IS_ERR(edit));
+
+	if (edit)
+		assoc_array_cancel_edit(edit);
+
+	assoc_array_test_invariant(m);
+}
+
+static int assoc_array_test_stop_iterator(const void *object, void *data)
+{
+	int *count = data;
+
+	if (++(*count) == ASSOC_ARRAY_TEST_STOP_AFTER)
+		return ASSOC_ARRAY_TEST_STOP_STATUS;
+
+	return 0;
+}
+
+static void assoc_array_test_model_iterate_stop(struct assoc_array_test_model *m)
+{
+	int count = 0;
+
+	KUNIT_EXPECT_EQ(m->test,
+			assoc_array_iterate(&m->array, assoc_array_test_stop_iterator, &count),
+			ASSOC_ARRAY_TEST_STOP_STATUS);
+	KUNIT_EXPECT_EQ(m->test, count, ASSOC_ARRAY_TEST_STOP_AFTER);
+
+	assoc_array_test_invariant(m);
+}
+
+static bool assoc_array_test_keep_even(const struct assoc_array_test_object *obj, void *data)
+{
+	return !(obj->value & 1);
+}
+
+static bool assoc_array_test_keep_none(const struct assoc_array_test_object *obj, void *data)
+{
+	return false;
+}
+
+static void assoc_array_test_fill_and_drain(struct kunit *test)
+{
+	struct assoc_array_test_model *m = assoc_array_test_model_create(test);
+	int i;
+
+	assoc_array_test_model_fill(m);
+
+	for (i = ASSOC_ARRAY_TEST_NR_KEYS - 1; i >= 0; i--)
+		assoc_array_test_model_delete(m, i);
+}
+
+static void assoc_array_test_replace(struct kunit *test)
+{
+	struct assoc_array_test_model *m = assoc_array_test_model_create(test);
+	int i;
+
+	assoc_array_test_model_fill(m);
+
+	for (i = 0; i < ASSOC_ARRAY_TEST_NR_KEYS; i++)
+		assoc_array_test_model_insert(m, i, i + ASSOC_ARRAY_TEST_NR_KEYS);
+}
+
+static void assoc_array_test_collapse(struct kunit *test)
+{
+	struct assoc_array_test_model *m = assoc_array_test_model_create(test);
+	int i;
+
+	assoc_array_test_model_fill(m);
+
+	for (i = ASSOC_ARRAY_TEST_NR_KEYS - 1; i >= 16; i--)
+		assoc_array_test_model_delete(m, i);
+
+	for (i = 16; i < 32; i++)
+		assoc_array_test_model_insert(m, i, i * 2);
+}
+
+static void assoc_array_test_iterate_stop(struct kunit *test)
+{
+	struct assoc_array_test_model *m = assoc_array_test_model_create(test);
+
+	assoc_array_test_model_fill(m);
+	assoc_array_test_model_iterate_stop(m);
+}
+
+static void assoc_array_test_gc(struct kunit *test)
+{
+	struct assoc_array_test_model *m = assoc_array_test_model_create(test);
+
+	assoc_array_test_model_fill(m);
+	assoc_array_test_model_gc(m, assoc_array_test_keep_even, NULL);
+	assoc_array_test_model_gc(m, assoc_array_test_keep_none, NULL);
+}
+
+static void assoc_array_test_cancel(struct kunit *test)
+{
+	struct assoc_array_test_model *m = assoc_array_test_model_create(test);
+
+	assoc_array_test_model_fill(m);
+
+	assoc_array_test_model_delete(m, 0);
+	assoc_array_test_model_cancel_insert(m, 0, 999);
+	assoc_array_test_model_cancel_delete(m, 1);
+	assoc_array_test_model_cancel_clear(m);
+}
+
+static void assoc_array_test_clear(struct kunit *test)
+{
+	struct assoc_array_test_model *m = assoc_array_test_model_create(test);
+
+	assoc_array_test_model_fill(m);
+	assoc_array_test_model_clear(m);
+	assoc_array_test_model_fill(m);
+}
+
+static void assoc_array_test_destroy(struct kunit *test)
+{
+	struct assoc_array_test_model *m = assoc_array_test_model_create(test);
+
+	assoc_array_test_model_fill(m);
+	assoc_array_test_model_destroy(m);
+	assoc_array_test_model_fill(m);
+}
+
+static struct kunit_case assoc_array_test_cases[] = {
+	KUNIT_CASE(assoc_array_test_fill_and_drain),
+	KUNIT_CASE(assoc_array_test_replace),
+	KUNIT_CASE(assoc_array_test_collapse),
+	KUNIT_CASE(assoc_array_test_iterate_stop),
+	KUNIT_CASE(assoc_array_test_gc),
+	KUNIT_CASE(assoc_array_test_cancel),
+	KUNIT_CASE(assoc_array_test_clear),
+	KUNIT_CASE(assoc_array_test_destroy),
+	{}
+};
+
+static struct kunit_suite assoc_array_test_suite = {
+	.name = "assoc_array",
+	.test_cases = assoc_array_test_cases,
+};
+
+kunit_test_suites(&assoc_array_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test for assoc_array");
--
2.47.3

