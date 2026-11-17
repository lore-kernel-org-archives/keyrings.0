Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874650;
	b=vqZl8ISN7H5F9DepvnZ/uwx+WURcxYFiBsuE0QaojmGO33NjvN4SOnNSSVQiwYRl/l9+
	 4OyJNcocAPrgCnObLCtDH5QtMmC1wVsuJGWlNBU61N5uA6EQcR8rryBvw7r/j1AIazBSO
	 Z9LfvrxtJPYgl2Xl+GXwInLo9/Xvp1jE4gd6oohS7F13L+xMK9IjVl0l9GlZQ1D1hCIgt
	 fIk48P8bE/5HIxoPvuSfpko5+lxTL1P35GLSg5QDVtLe0q8dHDMQksGvYLtrbx/b+yHvc
	 uEIWItxLCN1AK+2MwRgpn8wxAWE0HEizRfKbrDsmWdolcNJHSLPWXhd7DaPwd8aUFaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874650;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=h/aLbf58NzkkZARWQ3SiH5sZH0IamrMPQWthui0CRLA=;
	b=vXzhds3izvr026KpRLiXr3c1XNxLerZf7i+hwki4BvIC4eO9sRBhfhJc+NwnrO0GuTPz
	 DRAMmXAUHnib247duj86ngzoB7Jj3w+MGdXFvYvL5/rrd/rxK01/V2mCyIxeTn5BrxFvY
	 wfANxpR5Btmdwvc2+RpeUZbVtYbTXN7PbeEkJe15v+i5ejJ0Y04XsaC2IyDXpl6iZ4dZ2
	 TcaDiBA65EDga4IBcbWnFQAYjX0ZBTZBKCAR8s45jjiuZ/no2pBgc/O6E/tPaPK48aPa8
	 tIfqBkK7jeniZ+V4gebPujP5yQS8MLWM7X8fY1L6p73jD9XbXJqWFBvdJffagVyEMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logarcheon.com;
	spf=pass smtp.mailfrom=logarcheon.com;
	dkim=pass header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=LQrt+a5L;
	arc=none smtp.remote-ip=185.70.43.20
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A2C606A88D;
	Tue, 17 Nov 2026 00:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A2C606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=LQrt+a5L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logarcheon.com;
	s=protonmail3; t=1794874641; x=1795133841;
	bh=h/aLbf58NzkkZARWQ3SiH5sZH0IamrMPQWthui0CRLA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LQrt+a5LbmdsYlJSkMFtK1yNMdjs/rN1rm+xikCtvVVYyMQs9tQESuvQEbmMoEEFC
	 sQ/C0RnUH0PW9KW+PQjx/UE//UvpAw4ro0XJJ47aTx7YlMxFJDF8kCDzc9C2zGuCsR
	 eULl/qv6Q791bhQXX9PMADjv/0k7QHzH6KUNHRG4/QfEi6ucR112cliFD8hmHFXq7X
	 GJxHsE0eyf0y04pWbq3ViipPFShKyGfVDCIfvwGa/UMuIOMlFfjwuJx2aX7KBIjAfG
	 6PsoLCNFa79MQ5kfDlzhvMZ3Ow0Vl1+9fy+Jg/MiN6sgxu/9YSNZTirR3VxKq6+iJI
	 0GbdWfuCjgyow==
Date: Tue, 17 Nov 2026 00:17:17 +0000
To: Andrew Morton <akpm@linux-foundation.org>
From: William Chuang <founder@logarcheon.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, William Chuang <founder@logarcheon.com>
Subject: [RFC PATCH] lib/asn1_decoder: add KUnit test suite
Message-ID: <20261117001711.47722-1-founder@logarcheon.com>
Feedback-ID: 145408520:user:proton
X-Pm-Message-ID: 86b6426ac1a80daf24011e276c1e9a93c93eefe9
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

Add a KUnit test suite for the ASN.1 BER/DER decoder in
lib/asn1_decoder.c.  A tiny two-field grammar (SEQUENCE { INTEGER,
OCTET STRING }) drives asn1_ber_decoder() with well-formed and
malformed byte strings and checks that valid input is parsed and each
class of malformed input is rejected with the documented error code
rather than over-read.

The suite has 13 cases: one well-formed decode; eight malformed-input
rejections (truncation, length overrun, long tag, wrong tag, oversize,
short header, missing and malformed end-of-contents); three
success-path cases (indefinite length with end-of-contents, long-form
length, zero-length string); and one bounded deterministic
random-stress case whose callbacks assert that every slice handed back
lies within the input buffer (KASAN additionally catches any
over-read).

Tested with KUnit on UML:

  $ ./tools/testing/kunit/kunit.py run asn1_decoder
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D asn1_decoder (13 subtest=
s) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [PASSED] asn1_test_decode_valid
  ...
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] asn1_deco=
der =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Testing complete. Ran 13 tests: passed: 13

This suite was developed with the assistance of an AI coding assistant
(Claude Opus 4.8): the test vectors and C were drafted with the
assistant and reviewed by hand, and this changelog was written with its
help.  Beyond the KUnit run above, the decoder was checked against the
suite with an independent verification kit -- exhaustive enumeration and
randomized, grammar-biased and coverage-guided (libFuzzer) fuzzing under
a guard page and KASAN/UBSan, CBMC bounded model checking of the real
decoder, and Coq and Lean models of the no-over-read invariant; no
over-read was found.  That kit is maintained separately and is not part
of this patch.  I understand the code and take responsibility for it.

Signed-off-by: William Chuang <founder@logarcheon.com>
---
 lib/Kconfig.debug              |  17 ++
 lib/tests/Makefile             |   4 +
 lib/tests/asn1_decoder_kunit.c | 360 +++++++++++++++++++++++++++++++++
 lib/tests/asn1_test.asn1       |  11 +
 4 files changed, 392 insertions(+)
 create mode 100644 lib/tests/asn1_decoder_kunit.c
 create mode 100644 lib/tests/asn1_test.asn1

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a6..f69025ae3cb9d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2998,6 +2998,23 @@ config BASE64_KUNIT
=20
 =09  If unsure, say N.
=20
+config ASN1_DECODER_KUNIT_TEST
+=09tristate "KUnit tests for the ASN.1 BER/DER decoder" if !KUNIT_ALL_TEST=
S
+=09depends on KUNIT
+=09default KUNIT_ALL_TESTS
+=09select ASN1
+=09help
+=09  This builds the KUnit tests for the ASN.1 BER/DER decoder in
+=09  lib/asn1_decoder.c.  A tiny grammar drives asn1_ber_decoder() with
+=09  well-formed and malformed input and checks that valid input is
+=09  parsed and each class of malformed input is rejected rather than
+=09  over-read.
+
+=09  For more information on KUnit and unit tests in general please refer
+=09  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+=09  If unsure, say N.
+
 config BITS_TEST
 =09tristate "KUnit test for bit functions and macros" if !KUNIT_ALL_TESTS
 =09depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index df0537e1b91fa..4e5b6016c4e4c 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -60,3 +60,7 @@ obj-$(CONFIG_RATELIMIT_KUNIT_TEST) +=3D test_ratelimit.o
 obj-$(CONFIG_UUID_KUNIT_TEST) +=3D uuid_kunit.o
=20
 obj-$(CONFIG_TEST_RUNTIME_MODULE)=09=09+=3D module/
+
+obj-$(CONFIG_ASN1_DECODER_KUNIT_TEST) +=3D asn1_decoder_kunit_test.o
+asn1_decoder_kunit_test-y :=3D asn1_decoder_kunit.o asn1_test.asn1.o
+$(obj)/asn1_decoder_kunit.o: $(obj)/asn1_test.asn1.h
diff --git a/lib/tests/asn1_decoder_kunit.c b/lib/tests/asn1_decoder_kunit.=
c
new file mode 100644
index 0000000000000..5196df7b281a3
--- /dev/null
+++ b/lib/tests/asn1_decoder_kunit.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * KUnit tests for the ASN.1 BER/DER decoder in lib/asn1_decoder.c.
+ *
+ * A tiny grammar (asn1_test.asn1: SEQUENCE { INTEGER, OCTET STRING }) dri=
ves
+ * the decoder.  The cases feed well-formed and malformed DER byte strings=
 to
+ * asn1_ber_decoder() and check that valid input is parsed and the action
+ * callbacks fire with the expected values, while each class of malformed =
input
+ * is rejected (rather than over-read) with the documented error code.
+ *
+ * Copyright (C) 2026 Logarcheon Inc.
+ */
+#include <kunit/test.h>
+#include <linux/asn1_decoder.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "asn1_test.asn1.h"
+
+struct asn1_test_ctx {
+=09unsigned int=09int_calls;
+=09unsigned int=09str_calls;
+=09u8=09=09int_first;
+=09size_t=09=09str_len;
+=09u8=09=09str_buf[8];
+=09/*
+=09 * Optional slice oracle.  When @buf is set, every callback checks that
+=09 * the (value, vlen) slice it is handed lies inside [buf, buf + buflen)=
;
+=09 * the stress case uses this to catch a bad slice directly, without
+=09 * waiting for KASAN.  Tests that leave @buf NULL skip the check.
+=09 */
+=09const u8=09*buf;
+=09size_t=09=09buflen;
+=09bool=09=09slice_oob;
+};
+
+static void asn1_test_check_slice(struct asn1_test_ctx *ctx,
+=09=09=09=09  const void *value, size_t vlen)
+{
+=09const u8 *v =3D value;
+
+=09if (!ctx->buf || vlen =3D=3D 0)
+=09=09return;
+=09if (v < ctx->buf || v + vlen > ctx->buf + ctx->buflen)
+=09=09ctx->slice_oob =3D true;
+}
+
+/*
+ * Action callbacks referenced by asn1_test.asn1.  They must be non-static=
 and
+ * match the names used in the grammar; asn1_test.asn1.h declares them.
+ */
+int asn1_test_note_int(void *context, size_t hdrlen, unsigned char tag,
+=09=09       const void *value, size_t vlen)
+{
+=09struct asn1_test_ctx *ctx =3D context;
+
+=09ctx->int_calls++;
+=09asn1_test_check_slice(ctx, value, vlen);
+=09if (vlen >=3D 1)
+=09=09ctx->int_first =3D ((const u8 *)value)[0];
+=09return 0;
+}
+
+int asn1_test_note_str(void *context, size_t hdrlen, unsigned char tag,
+=09=09       const void *value, size_t vlen)
+{
+=09struct asn1_test_ctx *ctx =3D context;
+
+=09ctx->str_calls++;
+=09asn1_test_check_slice(ctx, value, vlen);
+=09ctx->str_len =3D vlen;
+=09if (vlen <=3D sizeof(ctx->str_buf))
+=09=09memcpy(ctx->str_buf, value, vlen);
+=09return 0;
+}
+
+/* SEQUENCE { INTEGER 0x2a, OCTET STRING "hi" } */
+static const u8 asn1_test_der_valid[] =3D {
+=090x30, 0x07,
+=09=090x02, 0x01, 0x2a,
+=09=090x04, 0x02, 0x68, 0x69,
+};
+
+/* A well-formed message is decoded and both actions fire with the right d=
ata. */
+static void asn1_test_decode_valid(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09int ret;
+
+=09ret =3D asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09       asn1_test_der_valid,
+=09=09=09       sizeof(asn1_test_der_valid));
+=09KUNIT_EXPECT_EQ(test, ret, 0);
+=09KUNIT_EXPECT_EQ(test, ctx.int_calls, 1u);
+=09KUNIT_EXPECT_EQ(test, ctx.int_first, (u8)0x2a);
+=09KUNIT_EXPECT_EQ(test, ctx.str_calls, 1u);
+=09KUNIT_EXPECT_EQ(test, ctx.str_len, (size_t)2);
+=09KUNIT_EXPECT_MEMEQ(test, ctx.str_buf, "hi", 2);
+}
+
+/* The SEQUENCE header claims 7 content octets but only 6 are present. */
+static void asn1_test_truncated_content(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09static const u8 der[] =3D {
+=09=090x30, 0x07,
+=09=09=090x02, 0x01, 0x2a,
+=09=09=090x04, 0x02, 0x68,=09/* final octet missing */
+=09};
+
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09=09=09 der, sizeof(der)),
+=09=09=09-EBADMSG);
+}
+
+/* The INTEGER length (0x7f) runs past the end of the containing SEQUENCE.=
 */
+static void asn1_test_length_overrun(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09static const u8 der[] =3D {
+=09=090x30, 0x03,
+=09=09=090x02, 0x7f, 0x00,
+=09};
+
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09=09=09 der, sizeof(der)),
+=09=09=09-EBADMSG);
+}
+
+/* A high-tag-number (long) tag form is not supported and must be rejected=
. */
+static void asn1_test_long_tag(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09static const u8 der[] =3D {
+=09=090x30, 0x03,
+=09=09=090x1f, 0x01, 0x00,=09/* tag low 5 bits =3D=3D 0x1f */
+=09};
+
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09=09=09 der, sizeof(der)),
+=09=09=09-EBADMSG);
+}
+
+/* A top-level tag that is not the expected SEQUENCE is rejected. */
+static void asn1_test_wrong_tag(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09static const u8 der[] =3D {
+=09=090x31, 0x07,=09=09=09/* SET instead of SEQUENCE */
+=09=09=090x02, 0x01, 0x2a,
+=09=09=090x04, 0x02, 0x68, 0x69,
+=09};
+
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09=09=09 der, sizeof(der)),
+=09=09=09-EBADMSG);
+}
+
+/* datalen above the decoder's 65535-octet ceiling returns -EMSGSIZE. */
+static void asn1_test_too_large(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09size_t len =3D 0x10000;=09=09/* 65536 > 65535 */
+=09u8 *buf;
+
+=09buf =3D kzalloc(len, GFP_KERNEL);
+=09KUNIT_ASSERT_NOT_NULL(test, buf);
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx, buf, len),
+=09=09=09-EMSGSIZE);
+=09kfree(buf);
+}
+
+/* A buffer too short to hold even one tag+length header is rejected. */
+static void asn1_test_short_header(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09static const u8 der[] =3D { 0x30 };
+
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09=09=09 der, sizeof(der)),
+=09=09=09-EBADMSG);
+}
+
+/* Indefinite-length constructed form with no terminating EOC is rejected.=
 */
+static void asn1_test_missing_eoc(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09static const u8 der[] =3D {
+=09=090x30, 0x80,=09=09=09/* indefinite length */
+=09=09=090x02, 0x01, 0x2a,
+=09=09=090x04, 0x02, 0x68, 0x69,
+=09=09=09=09=09=09/* no 0x00 0x00 EOC */
+=09};
+
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09=09=09 der, sizeof(der)),
+=09=09=09-EBADMSG);
+}
+
+/* An EOC marker with a non-zero length octet is rejected. */
+static void asn1_test_invalid_eoc(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09static const u8 der[] =3D {
+=09=090x30, 0x80,=09=09=09/* indefinite length */
+=09=09=090x02, 0x01, 0x2a,
+=09=09=090x04, 0x02, 0x68, 0x69,
+=09=09=090x00, 0x01,=09=09/* EOC with bad length */
+=09};
+
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09=09=09 der, sizeof(der)),
+=09=09=09-EBADMSG);
+}
+
+/*
+ * Indefinite-length constructed form terminated by a proper end-of-conten=
ts
+ * marker is accepted, and both actions fire.  This exercises the success =
path
+ * of the indefinite-length branch (the failure paths are covered above).
+ */
+static void asn1_test_indefinite_ok(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09static const u8 der[] =3D {
+=09=090x30, 0x80,=09=09=09/* SEQUENCE, indefinite length */
+=09=09=090x02, 0x01, 0x2a,
+=09=09=090x04, 0x02, 0x68, 0x69,
+=09=09=090x00, 0x00,=09=09/* end-of-contents */
+=09};
+
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09=09=09 der, sizeof(der)),
+=09=09=090);
+=09KUNIT_EXPECT_EQ(test, ctx.int_calls, 1u);
+=09KUNIT_EXPECT_EQ(test, ctx.str_calls, 1u);
+=09KUNIT_EXPECT_EQ(test, ctx.str_len, (size_t)2);
+}
+
+/* A two-octet (0x81) long-form length is parsed the same as the short for=
m. */
+static void asn1_test_long_form_length(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09static const u8 der[] =3D {
+=09=090x30, 0x81, 0x07,=09=09/* long-form length: 1 octet, 0x07 */
+=09=09=090x02, 0x01, 0x2a,
+=09=09=090x04, 0x02, 0x68, 0x69,
+=09};
+
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09=09=09 der, sizeof(der)),
+=09=09=090);
+=09KUNIT_EXPECT_EQ(test, ctx.int_first, (u8)0x2a);
+=09KUNIT_EXPECT_EQ(test, ctx.str_len, (size_t)2);
+}
+
+/* A zero-length OCTET STRING is valid; the action fires with vlen =3D=3D =
0. */
+static void asn1_test_zero_length_string(struct kunit *test)
+{
+=09struct asn1_test_ctx ctx =3D {};
+=09static const u8 der[] =3D {
+=09=090x30, 0x05,
+=09=09=090x02, 0x01, 0x2a,
+=09=09=090x04, 0x00,=09=09/* OCTET STRING of length 0 */
+=09};
+
+=09KUNIT_EXPECT_EQ(test,
+=09=09=09asn1_ber_decoder(&asn1_test_decoder, &ctx,
+=09=09=09=09=09 der, sizeof(der)),
+=09=09=090);
+=09KUNIT_EXPECT_EQ(test, ctx.str_calls, 1u);
+=09KUNIT_EXPECT_EQ(test, ctx.str_len, (size_t)0);
+}
+
+/*
+ * Bounded deterministic stress.  A fixed-seed xorshift PRNG drives a few
+ * thousand pseudo-random byte strings (lengths 0..255) through the decode=
r.
+ * The decoder must never crash, and whenever it reports success the slice
+ * oracle in the callbacks must not have seen an out-of-range (value, vlen=
).
+ * On a KASAN build any over-read is caught in addition to the oracle.  Th=
e
+ * seed and iteration count are fixed so the case is reproducible and runs=
 in
+ * bounded time.
+ */
+static void asn1_test_random_stress(struct kunit *test)
+{
+=09static const unsigned int iterations =3D 4096;
+=09u32 state =3D 0x1a2b3c4du;=09=09/* fixed seed: reproducible */
+=09u8 *buf;
+=09unsigned int i;
+
+=09buf =3D kmalloc(256, GFP_KERNEL);
+=09KUNIT_ASSERT_NOT_NULL(test, buf);
+
+=09for (i =3D 0; i < iterations; i++) {
+=09=09struct asn1_test_ctx ctx =3D {};
+=09=09size_t len, j;
+=09=09int ret;
+
+=09=09state ^=3D state << 13;
+=09=09state ^=3D state >> 17;
+=09=09state ^=3D state << 5;
+=09=09len =3D state % 256;
+
+=09=09for (j =3D 0; j < len; j++) {
+=09=09=09state ^=3D state << 13;
+=09=09=09state ^=3D state >> 17;
+=09=09=09state ^=3D state << 5;
+=09=09=09buf[j] =3D state & 0xff;
+=09=09}
+
+=09=09ctx.buf =3D buf;
+=09=09ctx.buflen =3D len;
+=09=09ret =3D asn1_ber_decoder(&asn1_test_decoder, &ctx, buf, len);
+
+=09=09/* Any return is acceptable; a bad slice on success is not. */
+=09=09if (ret =3D=3D 0)
+=09=09=09KUNIT_EXPECT_FALSE(test, ctx.slice_oob);
+=09=09else
+=09=09=09KUNIT_EXPECT_LT(test, ret, 0);
+=09}
+
+=09kfree(buf);
+}
+
+static struct kunit_case asn1_decoder_test_cases[] =3D {
+=09KUNIT_CASE(asn1_test_decode_valid),
+=09KUNIT_CASE(asn1_test_truncated_content),
+=09KUNIT_CASE(asn1_test_length_overrun),
+=09KUNIT_CASE(asn1_test_long_tag),
+=09KUNIT_CASE(asn1_test_wrong_tag),
+=09KUNIT_CASE(asn1_test_too_large),
+=09KUNIT_CASE(asn1_test_short_header),
+=09KUNIT_CASE(asn1_test_missing_eoc),
+=09KUNIT_CASE(asn1_test_invalid_eoc),
+=09KUNIT_CASE(asn1_test_indefinite_ok),
+=09KUNIT_CASE(asn1_test_long_form_length),
+=09KUNIT_CASE(asn1_test_zero_length_string),
+=09KUNIT_CASE(asn1_test_random_stress),
+=09{}
+};
+
+static struct kunit_suite asn1_decoder_test_suite =3D {
+=09.name =3D "asn1_decoder",
+=09.test_cases =3D asn1_decoder_test_cases,
+};
+
+kunit_test_suite(asn1_decoder_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the ASN.1 BER/DER decoder");
+MODULE_LICENSE("GPL");
diff --git a/lib/tests/asn1_test.asn1 b/lib/tests/asn1_test.asn1
new file mode 100644
index 0000000000000..b3da8041a5b2a
--- /dev/null
+++ b/lib/tests/asn1_test.asn1
@@ -0,0 +1,11 @@
+-- SPDX-License-Identifier: GPL-2.0-or-later
+--
+-- Minimal grammar used only by the ASN.1 decoder KUnit tests
+-- (lib/tests/asn1_decoder_kunit.c).  It exercises a constructed type, a
+-- primitive INTEGER and a primitive OCTET STRING, each with an action, wh=
ich
+-- is enough to drive the decoder's tag/length handling and action dispatc=
h.
+
+TestData ::=3D SEQUENCE {
+=09num=09INTEGER ({ asn1_test_note_int }),
+=09str=09OCTET STRING ({ asn1_test_note_str })
+=09}

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
--=20
2.43.0


