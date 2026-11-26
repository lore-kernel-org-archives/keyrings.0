Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795721434;
	b=EgyCjdsK8T/lM5oU0WgAYHGVLlYtPcDgwfT/7q9XFqWvRJR5ipiml+u0OfkFIclaXZCq
	 jQiQhQNQ3csyznnkxOQmTk85y7wR1r5m/bkid8lXGx3bPZZkFPe5YtED9gKV55PcjXgW1
	 2eWEHc1M4GkfobJ/7C2jZiMczIq6TsLVC447OjYZYTKt12u/GbGg3jb/EgcKArrReXrjn
	 5ZMIRJp2SwxiKIuKkVCfcc5qxB3i4RL0FpLrLfgbRwXsv4hVQoqeauv89V14XcdifSG8K
	 U4tUeNf4b2b6sQ1XoDxS/VPBFleuUzeqDdx5BqC2yjHT05EWFpYRvfmV1F0rT18qV4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795721434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-Mailer;
	bh=wC1lrTNLODTlKecpUIBVir+FRI0SNxKt/usSsDfnlF4=;
	b=TNqXoTbAG0je4+s4r2Iotlv2/yDYaQlV3h0HFpXl5cohJbp2AyPPCrkUVAOJINzBij5+
	 uifqg6vEnRsHg2UJt9NHaoiB8njIaMvi03jUaJ7+fmFUzojCB8FdfaEHVSuSx27CuRG9O
	 wj1/9AWEFOU87cSFOvjsnlOJqVOinWMnt1ECIcvRbapJOIwBWz2pUHOmauKgpNjxwTzeb
	 AmUn0Wsau11fM6P+BtAAUfhbNTztBD5VEzSpQ72BcvIrlugj01UzVdKfqvcU7FkHAsGTy
	 4evKDaJrMKwWhhfFyRXoKTKzjokVwlIPrz1XgX9cS3gJowp0fiyXJ9pURi5+3ZJtybw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohbmK80F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E5BB8606A31C;
	Thu, 26 Nov 2026 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohbmK80F
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 06C081F000C0;
	Thu, 26 Nov 2026 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795721433;
	bh=wC1lrTNLODTlKecpUIBVir+FRI0SNxKt/usSsDfnlF4=;
	h=Date:From:To:Cc:Subject;
	b=ohbmK80F7tDqpguaOkE0sEfJ10hFseiNyMLf7xpCCfxhjSGQBxWQ4Yhiz5ILMaTr0
	 UYQA9PJsiQcQz4dZWq5C/6hQu76dhXmglKu2EczTC5dfoe/EoVi1RIRfrW3x/XBVkC
	 N41tOzJfJXMfQ+nFpzmz3lRvy3Q3KB4Z+woFaIl5rJBjFTgiA033f/qlZzN9PeYvPN
	 h5suftAXhzi8rmUUKz4jgJYzgGaGAYX/Q80snPUgMDPlF1ADyYQ5mJmsG7BWU9tOJO
	 4zDwaEQ+qhYy1ryjecng11SCBMCN/fNCmjUhoW/ATJ6DXAg+tJd0QcqJmmKm4XWvkE
	 uIHK5qsuBX8jg==
Date: Thu, 26 Nov 2026 21:30:30 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] KEYS: changes for v7.4-rc5
Message-ID: <awiI1qcs1TjtU3Sq@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc

The following changes since commit 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4:

  Merge tag 'assoc-array-fixes-v2' (2026-11-16 09:35:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc5

for you to fetch changes up to 1bcff832c48d83c5132662bec83bda37f566d8a2:

  KEYS: Fix crash on big_key read (2026-11-24 19:48:15 +0200)

----------------------------------------------------------------
[GIT PULL] KEYS: changes for v7.4-rc5

The summary of bug fixes in this PR:

1. Trusted keys: initialize backend static calls before ->init(),
   synchronize TEE session lifetime against device removal (and disable
   sysfs bind/unbind), and propagate CAAM option parsing errors.
2. keyctl_pkey: fix user buffer bounds in keyctl_pkey_e_d_s() and
   keyctl_pkey_verify(), and zero temporary buffers with
   kfree_sensitive().
3. Key instantiation: take key->sem during instantiation and rejection
   to serialize key->user access against keyctl_chown_key().
4. big_key: instantiate the new payload before destroying the old one in
   big_key_update() so -EDQUOT cannot leave a positive key with a
   cleared payload.

As per SRCU fix that  I forwarded, I'll put that to linux-next after
this PR has been accepted to see how it flys at first.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

----------------------------------------------------------------
Guicai Ma (2):
      KEYS: Fix userspace buffer overflow in keyctl_pkey_e_d_s()
      KEYS: Use kfree_sensitive() in keyctl_pkey_e_d_s()

Henry Martin (1):
      KEYS: Fix crash on big_key read

Jarkko Sakkinen (4):
      KEYS: trusted: Update static calls before init
      KEYS: trusted: TEE: Synchronize session lifetime
      KEYS: trusted: TEE: Disable sysfs bind attributes
      KEYS: Fix asym key overflow in keyctl_pkey_verify()

Keisuke Tsukuda (1):
      KEYS: trusted: caam: propagate protected key option parsing errors

Sinan Turunc (1):
      KEYS: serialise key instantiation against keyctl_chown_key()

 security/keys/big_key.c                   | 16 ++++--
 security/keys/key.c                       |  4 ++
 security/keys/keyctl_pkey.c               | 21 +++++---
 security/keys/trusted-keys/trusted_caam.c |  4 +-
 security/keys/trusted-keys/trusted_core.c | 15 ++++--
 security/keys/trusted-keys/trusted_tee.c  | 89 +++++++++++++++++++++++--------
 6 files changed, 110 insertions(+), 39 deletions(-)
