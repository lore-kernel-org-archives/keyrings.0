Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807698;
	b=Z8G7AwdKdKZkpA6VvAb8RDCg6u32OPUA2h+5jP6LjcGPVy2jY+zenbeLpYbJb4YV/Hat
	 XT8t44SPny4mORZQ30dbYqAhG7Doou+FlA4HaHudOZg7X5ZSbfVP9moqqfx7W3N9vLmyM
	 BeGpGg9xX9sjzDlU2RPosG1D10XjO5bCxqGvK614rexUBI8nkduQ09fOg/dqLh5IR5Vp3
	 qqXf61iQEcigRSPcU1Q2KMEbxPi1hEx1gIGQoWJNFuY18UqeXYAUOTxTrJqIU3GdKD/VO
	 iDbOAy779dFwYys21oV/rVRyUcrQPAanuaxg9bCpI3qw+FyG9hO6f7bse7RmJA5XmHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807698;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=xYknDDmseI99hYv4chbcbO63XN1jBCOShfuS+0H1RRc=;
	b=TggNgbN+tt5mu0Eyuk2l7UDbaiK7WKeaOsiPJZ8T4jlHM/sG22c1Hu7JqRPYkzVAYZGs
	 EuW6qByayN9lNBCm0gf+G3XMh8E7fYeg3cNchrLdYS6uvwM8+Hg1cUP5RpdB5cwVMVePH
	 5c8VPk53gRbKSQBh1DDmo3Nc+B0QfChowKli5w5RIBZf9+dS8WKCQqDFZi0segRnWKC0+
	 tP7xV4oJ0FdN0qSAvEUjEA+sIaA8opoP2Ry4bVJ5n4ZKuJZ8DW+IoWa5u9xOOWzfomgMm
	 SP0cKQGvIGK54vFpUZIxfdmENJLMj599Rlhv8t2z4MUVzCEXZe5tR5cTIon3IFawp9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logarcheon.com;
	spf=pass smtp.mailfrom=logarcheon.com;
	dkim=pass header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=HyySa4TQ;
	arc=none smtp.remote-ip=109.224.244.22
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99242606A329
	for <keyrings@vger.kernel.org>; Mon, 16 Nov 2026 05:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99242606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=HyySa4TQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logarcheon.com;
	s=protonmail3; t=1794807692; x=1795066892;
	bh=xYknDDmseI99hYv4chbcbO63XN1jBCOShfuS+0H1RRc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HyySa4TQa40WbtdKwdfSr2oeWVg042rFwaQXIyUpsHhfkw0Stdbtva1yUE+9Un/Pe
	 EOPYRwflNO/SnU8JxtoTpuOloDpLV8o3wARZ7K6qcbpzwG6beGL9HvVngPQdlXlK6v
	 TtS7ksN02KLwhqTQY4s/+K4UWL27xS+1AHklBsrJtd9gDwYTFuPZo1E372l/Pa5KPn
	 HqHuI6qxqzsHiR0Nq6VIeDlqRENU943I03J8WgS+YO3S35HM9qcQOudpe7YTvH5li4
	 bSG0kNnSb+lVRH2FDreZDABM9QmkiVPA2kEQfSLGnOSVGrEIFim6R9b8z6cNUfHLQ1
	 axabbMFCbtlsw==
Date: Mon, 16 Nov 2026 05:41:27 +0000
To: akpm@linux-foundation.org
From: William Chuang <founder@logarcheon.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, William Chuang <founder@logarcheon.com>
Subject: [PATCH 2/2] lib/assoc_array: fix lookups after splitting a root shortcut
Message-ID: <20261116054112.39078-3-founder@logarcheon.com>
In-Reply-To: <20261116054112.39078-1-founder@logarcheon.com>
References: <20261116054112.39078-1-founder@logarcheon.com>
Feedback-ID: 145408520:user:proton
X-Pm-Message-ID: 10c8cc6922e8aba57049b79d8a13dcf0f8816373
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

assoc_array_insert_mid_shortcut() splits a shortcut when a newly inserted
leaf diverges from it partway along.  When the divergence point (diff)
lies exactly one segment past the level at which the shortcut was
entered, the function takes its "no pre-shortcut" path and attaches the
new node directly in the shortcut's old place.

For a shortcut that hangs off a parent node that is correct: the parent
already consumes the entering segment, so the new node ends up indexed at
the right level.  For a shortcut at the root of the tree
(back_pointer =3D=3D NULL) there is no parent to consume that segment, so t=
he
new node is installed as the root and walked from level 0 even though it
was built to be indexed at level 'diff'.  Every node below it is then
walked one segment too shallow and assoc_array_find() can no longer reach
most of the leaves.  The leaves are still present -- assoc_array_iterate()
visits them all and nr_leaves_on_tree stays correct -- so the data is
intact but becomes unfindable.

This is not seen in normal use because index keys are recommended to
begin with a hash, which scatters them and makes a shared multi-segment
prefix with an earlier-diverging sibling very unlikely.  With poorly
scattered keys, which the documentation says must still work correctly,
as few as 18 insertions can lose lookups.

Create the pre-shortcut in the root case as well, so the leading
segment(s) that the shortcut skipped stay covered and the new node is
indexed at the correct level.  Non-root shortcuts are unaffected: the
added condition is guarded by back_pointer =3D=3D NULL.

Add a KUnit regression case, aa_test_root_shortcut_split, that inserts
18 poorly scattered keys and checks every one is still found; it fails
before this change and passes after.

Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
Signed-off-by: William Chuang <founder@logarcheon.com>
---
 lib/assoc_array.c             |  3 ++-
 lib/tests/assoc_array_kunit.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index b6c9723e1..272aeeedd 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -844,7 +844,8 @@ static bool assoc_array_insert_mid_shortcut(struct asso=
c_array_edit *edit,
 =09 * parent.
 =09 */
 =09level +=3D ASSOC_ARRAY_LEVEL_STEP;
-=09if (diff > level) {
+=09if (diff > level ||
+=09    (!shortcut->back_pointer && diff > level - ASSOC_ARRAY_LEVEL_STEP))=
 {
 =09=09pr_devel("pre-shortcut %d...%d\n", level, diff);
 =09=09keylen =3D round_up(diff, ASSOC_ARRAY_KEY_CHUNK_SIZE);
 =09=09keylen >>=3D ASSOC_ARRAY_KEY_CHUNK_SHIFT;
diff --git a/lib/tests/assoc_array_kunit.c b/lib/tests/assoc_array_kunit.c
index bd253b6f6..427c71d37 100644
--- a/lib/tests/assoc_array_kunit.c
+++ b/lib/tests/assoc_array_kunit.c
@@ -936,6 +936,33 @@ static void aa_test_random_ops(struct kunit *test)
 =09}
 }
=20
+/*
+ * Poorly scattered keys: 17 keys share an 8-bit prefix and cluster behind=
 a
+ * shortcut at the root of the tree, then one key diverges a nibble earlie=
r and
+ * splits that root shortcut.  The documentation permits poor scattering (=
it only
+ * widens and deepens the tree), so every key must still be found.
+ */
+static void aa_test_root_shortcut_split(struct kunit *test)
+{
+=09struct aa_ctx *ctx =3D aa_ctx_new(test, 18, 900);
+=09unsigned int i;
+
+=09for (i =3D 0; i < ctx->nr_slots; i++) {
+=09=09struct aa_key *key =3D &ctx->slots[i].key;
+
+=09=09memset(key, 0, sizeof(*key));
+=09=09aa_key_set_nibble(key, 4, i < 17 ? 0 : 1);=09/* nibble 1 */
+=09=09aa_key_set_nibble(key, 8, i & 0xf);=09=09/* nibble 2 */
+=09=09aa_key_set_nibble(key, 12, (i >> 4) & 0xf);=09/* nibble 3 */
+=09=09key->w[AA_KEY_WORDS - 1] =3D 0x100 + i;=09=09/* globally unique */
+=09}
+=09for (i =3D 0; i < ctx->nr_slots; i++)
+=09=09aa_insert(ctx, i);
+=09aa_check(ctx);
+=09aa_check_near_misses(ctx, 200);
+=09aa_ctx_finish(ctx);
+}
+
 static struct kunit_case assoc_array_test_cases[] =3D {
 =09KUNIT_CASE(aa_test_empty),
 =09KUNIT_CASE(aa_test_replace),
@@ -948,6 +975,7 @@ static struct kunit_case assoc_array_test_cases[] =3D {
 =09KUNIT_CASE_PARAM(aa_test_shortcut, aa_shortcut_gen_params),
 =09KUNIT_CASE(aa_test_gc_fold),
 =09KUNIT_CASE(aa_test_gc_all_or_nothing),
+=09KUNIT_CASE(aa_test_root_shortcut_split),
 =09KUNIT_CASE_SLOW(aa_test_random_ops),
 =09{}
 };
--=20
2.39.1


