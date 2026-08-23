Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D602C9D;
	Sun, 23 Aug 2026 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787454224; cv=none; b=IovB8trnbYLrnO7DRJI9/DRFzfpvZHwguHSdvr2Z8ulWd3yAQ51SMoGoZwv3FxxG3mtbJMYG0eAh37VD5/1JiDfRXveSunf8roXaAhu5Akw2V230Hnqi0sKByAlanD8ROGI/Dh/lXPbnSxu3TWImflbj9J6ni/auvIF6DkNiWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787454224; c=relaxed/simple;
	bh=d1ir6N71ozEd/kcDs9L1jvLcWM9tWjnENjlsk8ZX2LU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uehB6Qpl7Fj8xM4i9qQhyDLJguMJhEtIy7NZ4DvAk0nULeujBUlotZldlp8VmA4xVCsiVTUVL8KfzXny8UE+CvkNbsAObd7bVHFtLLL6Td4YYV9h7O8DebgOhG/yTyMk1wkhg+9xm+EDZ8Fr30eEyVtMa4wP6tTsHcNKgMW9SNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMKg4Dt1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMKg4Dt1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 21F2E1F000E9;
	Sun, 23 Aug 2026 03:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787454222;
	bh=/iUsPgrvL+UmTBxicXrFaNOKPTzY/U427jWY/jp+GWI=;
	h=Date:From:To:Cc:Subject;
	b=GMKg4Dt1buhocGxaRdxfYABhxK9ek1U29vHllGX2HB0OpKMzI53HB6zA8YPGWHfyC
	 qcfvi0E6H+Ka78g6xQ1sfgx8FAN/48zPlUg9dXyHI0KNl5l4UjGVPsi3dbS/dAx4Pv
	 VdRmqyYMJWozfAaaEAPAktUYxtS5EPxwT/o1EyDgqxKuKcA9sHkBloDMynOvb+cP9q
	 ThedWMpgOZ27qcVGpzM+facYguyeDmOx3uIsbr01tKzIP4w5dbI1QtAFPDWmMQu+hx
	 u9waUDzrtJFBn9E61ZRzOt8c7RzvSMoq5geS+yydJU9xPC+eqy5DPjtoSlxaRNSuCs
	 HIAp8O9xKfLBg==
Date: Sun, 23 Aug 2026 06:03:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [GIT PULL] KEYS: for-next-keys-v7.3
Message-ID: <aopjCf7Srz1ejx2I@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc

The following changes since commit 7f063b2f17eaba2a35e251aa53627f2a70d536e2:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2026-08-20 17:07:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-v7.3

for you to fetch changes up to 5e2d672280d97d83de43031d93761b12dadd7b8a:

  KEYS: trusted: Fix TPM teardown ordering (2026-08-21 04:33:21 +0300)

----------------------------------------------------------------
Hi,

My v7.3 pull request for keyrings has just a single bug fix.

BR, Jarkko

----------------------------------------------------------------
Chengfeng Ye (1):
      KEYS: trusted: Fix TPM teardown ordering

 security/keys/trusted-keys/trusted_tpm1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
