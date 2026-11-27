Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748383;
	b=AIBRvt7HX75XmKTSbLVy5cres+bqCGHuQIfDmXF1Mj7nmjSQfBjClous4AKcTXPJE2CM
	 PP0tNMw3+Kb5VLQy35uLsBX7TmkKWAAoov2sJqDhIFeLdVR28gA3kU2g2obi9Z713V1Ne
	 eJfARRJxMeZJ1v5KvgR2zKpi6uEqU5862N3A3dCaEXSoCEGXuMXSjU9p0DaaYdWI71Gfh
	 s1F4XLHxIlLb0el1gFzPh5uYYiNcyUG1wClHYjpMk2RjtCxuL1APj7x02ljl9SwRCEQBP
	 xz+IIAeaU3L7NQefHvKW5MGdb0ge/pIWuOPu4Js24TYKcTjD0IDQLo/lg8hUzBABiPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748383;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=PSJbpwNYscaoPtLkKBtcM2ETmUbzMd8Ge7tSBLoV3QM=;
	b=pk9bA+jROuFyO7ucRAlUxmeCw/fAirV7UH+lGjI7gingT+MORE/sKECA/SFIv6RaDxi3
	 7QT0LA62WB15rODBz8VbCM5oqpu1VQUWrMI4kksKyD4sIkGQ9tk2hgagPmJgfBPqHTqIz
	 Oa85HBUpjNHV1HguEFI2yh7zsXDo32hCmpTUnN7beoCUejfFFfe42iQwtoVUmMTH72sV7
	 phIvZkhOb0yXV5TxwAPEmQsfNM7FNi5k6aw7dGNl5Sbxd61S1AWH7EUAemPejgFU0WCrr
	 hisTeosEz6D95b8Hzz5gzMUmOaxfMS4lbd0QpQD26g0242UGmEAAbz9ys23k3UtPtpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RonwJlgn;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23006606A32D
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 02:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23006606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RonwJlgn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795748382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PSJbpwNYscaoPtLkKBtcM2ETmUbzMd8Ge7tSBLoV3QM=;
	b=RonwJlgnrAVrhaAzJWPH0ipPq3dcViCMk4EzUk6eznkPHFr2az3QnRSF3NV1JymqZGSMuY
	YliSSTh6avyH4o51cUi/jyvWNXlF30hPf1DCvbaPI+/MDMBKhFRh3EmSWtkT77zh3SDPJd
	FpcCxpD/J7InTRs35yM6jr5FaVTvnPg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-MoHBRTmeMZavqSdn_mSSEg-1; Fri,
 27 Nov 2026 02:59:38 +0000
X-MC-Unique: MoHBRTmeMZavqSdn_mSSEg-1
X-Mimecast-MFC-AGG-ID: MoHBRTmeMZavqSdn_mSSEg_1795748377
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD73C1800349;
	Fri, 27 Nov 2026 02:59:36 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C52F230000E5;
	Fri, 27 Nov 2026 02:59:35 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dhowells@redhat.com,
	bauerman@linux.ibm.com,
	Bruno Meneguele <bmeneg@redhat.com>
Subject: [RFC PATCH 0/8] ima: measure modules with multiple appended signatures
Date: Thu, 26 Nov 2026 23:59:03 -0300
Message-ID: <20261127025912.1383750-1-bmeneg@redhat.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi,

This RFC presents the support for modules with multiple signatures, *and mixed
algorithms*, appended. A scenario that requires it today is the PQC transition
period where modules are signed with both, eg., ML-DSA and ECDSA.

Appraisal already handles that: pkcs7_verify() accepts the file if a trusted
signer verifies and no other signer fails (unknown keys is not considered
failure). But measurement doesn't: 'd-modsig' and the binary blacklist check
take the content digest from pkcs7_get_digest(), which fails with more than one
signer, so the file loads unmeasured.

Patches #1 and #2 (for stable) fix two PKCS#7 bugs found on the way: a failed
digest left in sig->m, and pkcs7_get_digest() returning the signed attributes
instead of the content digest. Patch #3 adds support for multiple signers on
PKCS#7 code, but IMA 'd-modsig' can't describe it, so patches #4-#7 add a
template (patch #5 standardizes how ima-modsig records ML-DSA in the same way
proposed here for its v2):

  ima-modsigv2 = d-ngv2 | n-ng | sig | d-modsig-list | modsig

'd-modsig-list' is <u32 count> x (<u32 entry_len><entry>), one 'd-modsig' entry
per signer in 'modsig' order, or "<sig algo>:" for direct data (eg. ML-DSA)
signatures:

  d-ngv2:        ima:sha256:a4fa30a9...48d3a449
  n-ng:          /test/t10-ecdsa512-mldsa65-noattr.ko
  sig:           030304...feff
  d-modsig-list: sha512:0e750939...f8c18dcb,mldsa65:
  modsig:        30820e1706092a864886f70d010702a0...

Another example with ECDSA-SHA512+RSA-SHA256 and ML-DSA-65+ML-DSA-87:

  d-modsig-list: sha512:0e750939...f8c18dcb,sha256:0ae76371...e37306f2
  d-modsig-list: mldsa65:,mldsa87:

A signer with no usable digest gets an empty entry; with none, the measurement
list entry is dropped, as with 'd-modsig'. Patch #8 blocks a file if any
signer's digest is blacklisted.

Open questions: (1) should a dropped measurement be reported more explicitly
than by its audit record? (2) a pure ML-DSA signer has no content digest to
match a 'bin:' entry; how should that fit with the 'skid:' proposal [1]?

I tested module loading in a QEMU/KVM x86_64 and kernel image kexec in a PPC64LE
LPAR with RSA, ECDSA and ML-DSA-65/87, one or two signers, mixed hash algorithms
and rejected cases (bad messageDigest, two ML-DSA signers with one bad).

Claude Opus helped read the code, review the patches and write the tests (and
this cover-letter). I reviewed and reworked every diff and I'm responsible for
all of it.

Thanks,
Bruno

[1] https://lore.kernel.org/all/20261106173149.707244-1-zohar@linux.ibm.com/


Bruno Meneguele (8):
  pkcs7: don't cache a failed digest in pkcs7_digest()
  pkcs7: return the content digest from pkcs7_get_digest()
  pkcs7: support multiple signers in pkcs7_get_digest()
  ima: get the modsig content digest of each signer
  ima: record data-signing algorithms by name in 'd-modsig'
  ima: add the 'd-modsig-list' template field
  ima: define the ima-modsigv2 template
  ima: check the digest of every modsig signer against the blacklist

 Documentation/security/IMA-templates.rst  |   8 +-
 crypto/asymmetric_keys/pkcs7_verify.c     |  83 +++++++--
 include/crypto/pkcs7.h                    |   7 +-
 security/integrity/ima/ima.h              |  15 +-
 security/integrity/ima/ima_appraise.c     |  15 +-
 security/integrity/ima/ima_modsig.c       |  48 +++--
 security/integrity/ima/ima_policy.c       |   3 +-
 security/integrity/ima/ima_template.c     |   8 +-
 security/integrity/ima/ima_template_lib.c | 208 ++++++++++++++++++----
 security/integrity/ima/ima_template_lib.h |   4 +
 10 files changed, 314 insertions(+), 85 deletions(-)

--
2.55.0

