Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66383806C1;
	Fri, 28 Aug 2026 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939559; cv=none; b=JlqiK+gniATVJ6JDUtZnmlGtQynWGB0RpcbT0uz/e/XaXCIVtYHXLsPaNwh0RTuPR9g1lfsqSRbW8cOQBK52wp9M4pKoFokVUOrtVkzMLkryJy2kSPblpBxPp8jVFhFrWsPBXtADHgS3feT7aDbZRe/ncKddrRdySU/YCLhnWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939559; c=relaxed/simple;
	bh=R81Z9WqYmMOYaX/ukTaLItHJyeiS2OMaFxQ6aGSP4jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mu6a2M2JqoPZmj93ZA4T1sDmE4eN7wJt/6pmyS6uyL9ux20K1bmSffxY2BoQK9k3jjlPxUDhm6YyQvOjfOOSTVviaDV1So6DST+BERUB3aQC/CMLaziwTa2/TbA2A8h1DPbAS+zvE9TfwUEDDkZ6e7rd1gheuK8Ram7diSgPxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=IBnwD459; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IBnwD459"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=j0zWQjZ+MdktzDKRmOmKDO3daeQGpAgWnimbcBIohMM=; b=IBnwD459ZW+zmFWv/pxpQ+83EQ
	DBgOlC8ZJkq/8rZz+yHF5w3mf3fThFTkJ2WRtnzkAPrukiBeNSabCf1jR/nFBeNBe5DMQsT7GhBQV
	EDkzS1M3bFof8/JF3ruuFn0jMIlK1QvgTrCLoMJFJVqzmhfbLNCbnDtvnUnqz/BZA9IKAEQKQ3iR3
	sthqJ/4xMtZrMxHM4mzw4d5DgA5rG7hEoHThuY1WM9oVNgbPqlbPXR0NfMK9dQahqzvo35xGK7PyR
	XPGVHSXuJQJPpGIylqlGyHdO+rNre4q2TCqaV2q5c0OGMQvhljfHEW/UhTb1VJUvrNLw14QW58v8y
	k3MHzYdw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x00ke-0000Zf-0I;
	Fri, 28 Aug 2026 19:52:28 +0200
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
Subject: [PATCH bpf-next v4 00/11] BPF keyring and signed loader ML-DSA support
Date: Fri, 28 Aug 2026 19:52:16 +0200
Message-ID: <20260828175227.1537793-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28106/Fri Aug 28 08:27:08 2026)

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

v3 -> v4:
  - Refactor the keyring dispatch a bit better wrt if/else chaining (BPF CI)
  - Improve selftest for bpf keyring in signed loader wrt skips (BPF CI)
  - selftests/bpf/config sorting (BPF CI)
  - Misc documentation improvement (BPF CI)
v2 -> v3:
  - Added KEY_SPEC_BPF_KEYRING rather than VERIFY_USE_BPF_KEYRING
    then it can also be looked up via lookup_user_key (Christian Brauner)
  - Added CMS_NO_SIGNING_TIME to bpftool patch (Sashiko)
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
  bpf, keys: Add a bpf keyring for program signature validation
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
 Documentation/bpf/signing.rst                 | 283 +++++++--
 include/linux/bpf.h                           |  13 +
 include/linux/key.h                           |   2 +
 include/uapi/linux/keyctl.h                   |   1 +
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/keys.c                             |  73 +++
 kernel/bpf/verifier.c                         |  32 +-
 security/keys/process_keys.c                  |  25 +
 tools/bpf/bpftool/main.h                      |   2 +-
 tools/bpf/bpftool/sign.c                      |  24 +-
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/signed_loader.c  | 600 +++++++++++++++---
 .../bpf/prog_tests/verify_pkcs7_sig.c         |   4 +-
 .../testing/selftests/bpf/verify_sig_setup.sh |  63 +-
 tools/testing/selftests/bpf/vmtest.sh         |  16 +-
 17 files changed, 1003 insertions(+), 158 deletions(-)
 create mode 100644 kernel/bpf/keys.c

-- 
2.43.0

