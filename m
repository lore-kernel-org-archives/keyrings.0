Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F74499B3;
	Tue, 25 Aug 2026 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667943; cv=none; b=EbETfrUXE2kP2KRFWUw7IMN5lXW8ZDghWcOCJ/FpJ83iBkYEcKgkI5ws/4Xkij2ETrMsbOqluZU5CH4GSd0wYRTWCIwptH2YRWl/QJIDRFe4llnw/ds7c404x/+NpBJ+ONFpvNKKuB3KTeF4JRURc8UuvMqeKEsDyYyffxOvIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667943; c=relaxed/simple;
	bh=Xl7//cOJHLXrgciycB/BnZT+Xe9YXxcdtcnlO0zcayI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukweBByWVKtwNRkc7CnyzgEp1bx6Te0H/c07zossKP2Ov3PqiJRjc9Tew+27JAgD0bLLEvGZZTb/UxpkS5+4C17CZ7zqM3eBisDdNZb1F0Qb2aoqpIoZcm++AGjWL8YY37OZlv2O1daKn2nyd4n2L1x01t0aRtlHJNDk4QUJ8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GMPqKXgk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GMPqKXgk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=YfH7iXUdWgF18bbjYHparAJ7NozfCGP8GHR689MZt84=; b=GMPqKXgkaBZBTK2QhylfGLRgSs
	QANjgYJJXLkJrfsHDN8HSDy2kwBJzNPbR/Gr2vCLmo+tzn8le5OdKjPAjmRoeCJs6GgaJCTgExMVZ
	MuK4nJzIeSDRM+/n65v9gSKbURxhSEIMwMpe1U6Uao5XYir3H6OytCekzVWr29q33i9jJFvbsoaLX
	pjurV1gcL55fup36eoSRnggldU79RJgCHTSIPYfQpc/3vj4TbdEvNysjkUK6G3ocxApOanQwEMpcU
	gzpEBAP3+rdX3PLZKrkVEk9/NmJTwlv1G6QMqk0AaDynfLEsnRiMg/hcPPCOGWc8AkuRekosnNUYl
	JcQmPPAQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wys5j-000N7a-0R;
	Tue, 25 Aug 2026 16:25:31 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	dhowells@redhat.com,
	jarkko@kernel.org,
	keyrings@vger.kernel.org
Subject: [PATCH bpf-next v2 00/11] BPF keyring and signed loader ML-DSA support
Date: Tue, 25 Aug 2026 16:25:19 +0200
Message-ID: <20260825142530.1329706-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28103/Tue Aug 25 08:27:08 2026)

Add a dedicated BPF keyring which is integrated for BPF signing. It
is modelled after the dm-verity keyring which was added in commit
033724b ("dm-verity: add dm-verity keyring") and which can eventually
be used also via systemd through the same enrollment method as in
dm-verity's case. It is selected with a new well-known keyring_id
VERIFY_USE_BPF_KEYRING and gives an operator a place to enroll a
BPF-only signing key at boot, specifically scoped to signed BPF
program loading. Next, to demonstrate that BPF signing is algorithm
agnostic, we add a few small tooling changes to support ML-DSA and
integrate everything into BPF selftest for BPF CI to ensure nothing
breaks with future changes. For more details, see individual commits.

v1 -> v2:
  - Mainly addressing LLM feedback in docs, commit message and
    selftests (BPF CI, sashiko)
    - Fix reasoning on BPF_PROG_MAX_SIGNATURE_SIZE
    - Add reasoning about bpftool MAX_SIG_SIZE change and pinning
      the CMS digest to SHA-512
    - Fix misc signing.rst phrasing
    - Fix a potential NULL deref in bpf_keyring_lookup selftest code
    - Add CONFIG_CRYPTO_SHA512=y to BPF selftest config
    - Clean up key material on ML-DSA signed loader test failure
    - Refactor duplicated bpf_attr setup for bpf keyring tests
    - Fix wording in kernel-parameters.txt

Daniel Borkmann (11):
  bpf: Add a bpf keyring for program signature validation
  bpf: Refuse caller-supplied keyrings when the bpf one is active
  bpf: Raise the bound on a program's signature size
  bpftool: Support ML-DSA program signing
  selftests/bpf: Add a test for the sealed bpf keyring
  selftests/bpf: Rebuild signed lskels when signing key changes
  selftests/bpf: Rename the verify_sig_setup.sh setup into setup-rsa
  selftests/bpf: Add an end-to-end ML-DSA signed loader test
  selftests/bpf: Allow appending to guest kernel cmdline in vmtest.sh
  selftests/bpf: Add tests for bpf keyring in signed loader
  Documentation/bpf: Document the bpf keyring and improve examples

 .../admin-guide/kernel-parameters.txt         |  16 +
 Documentation/bpf/signing.rst                 | 279 +++++++++--
 include/linux/bpf.h                           |  13 +
 include/linux/verification.h                  |  10 +
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/keys.c                             |  72 +++
 kernel/bpf/verifier.c                         |  43 +-
 tools/bpf/bpftool/main.h                      |   2 +-
 tools/bpf/bpftool/sign.c                      |  22 +-
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/signed_loader.c  | 472 ++++++++++++++++--
 .../bpf/prog_tests/verify_pkcs7_sig.c         |   4 +-
 .../testing/selftests/bpf/verify_sig_setup.sh |  63 ++-
 tools/testing/selftests/bpf/vmtest.sh         |  16 +-
 15 files changed, 915 insertions(+), 104 deletions(-)
 create mode 100644 kernel/bpf/keys.c

-- 
2.43.0

