Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442692;
	b=nzpQwt/yL0y+3zxhn/V/bQA6ote9BHV2FV4DZlXzeZCUcVf9u3b4lr0XkujC4/F+MVRG
	 +/eUxb4/v32Ha7XVXPF5cUUsOVHe80mCzL+XOmPWytea+HwIhGB0tFF8T9yGBvcY/bzno
	 eVJfIDpoWgYdsAiJc2j+vGk07ZAJqgwSJLiKyvqctEXySrCoYyjt6cTwAT/cLW9PHB+YP
	 6cJ7DpZhn6QJCORAjbTCuQNeGCxbk2oNgDzz5M4ecehzNv3ylpEsZr8HDCVusud12jIws
	 pCckrDhektcmZAHHoDiNiiKn5ZzBROoIuoqOtyWFN5VHhvlRyi0j22ko/eFaqtiJ1Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442692;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=O3I8mf8n3FTJhmHTEesrftYjlGJiq3bHpKQ86tB55E0=;
	b=pIAAYOizWfsjVoRN+Kmvf6eQx80SRZwjcYQdNhI1u7KpXVzhFVHAXmYQM8X7x4Eb7j4P
	 di+xdLuPS6Wp6TwM4JZNMWXe2JQNzdGyN8izdcx0ZaNGIIz8ULp8yyyKwBuvXv/bEto3M
	 Na6Mp71cQSE2UOiMg9OlWWoNW/EPH8d48BsXG4MnWcz+bvbFZz5Wvy6YcQlJ3RRyBKVk7
	 Um7zqrwzOYcNHOFXyWRMHsXTkulJ3W3XfeeUMyh5j26f9XldLtGZZfKqbRHie2NYTA8OS
	 D9wLlZjCZS7VpG+YUoEreCRM6LDONz/84NHNQ0nWhZ/t/frW3MqrvpbShnh1mRni3TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S413R+Bc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6D167606A32E;
	Thu, 12 Nov 2026 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S413R+Bc
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 932981F00A0D;
	Thu, 12 Nov 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442692;
	bh=O3I8mf8n3FTJhmHTEesrftYjlGJiq3bHpKQ86tB55E0=;
	h=Date:From:To:Cc:Subject;
	b=S413R+Bc22sJoo2RIkHceaS+59Pmlo6oabqwwvtpdBxK9l3OFjYrYKQ7dV6Go59IN
	 4cLpBhUq5Mh8XGtjnoKmk3hTiG+E0dIWYupcKkqWyKvqeg+IIe7yV+qVgzc4nw9hom
	 IkDFPQZPzV8yXcKaSFQ0eRMynDAbhz5GW6/gwGDj1r2+BgyPcIexkVM29lbdvu4vp/
	 r154R11iK9Is3AFiGYsSM3fwfx+hQUkc6wFm9hWkFm6mqjRiLLk/4K284MBQgIf5zI
	 b8PCk72rw8Z02JxuLlu+SojsccTY2Yb08ny2B7neR2aNB+6mPq8Xh8oKvWVydrjUEw
	 wqF1AVQr/5wPw==
Date: Thu, 12 Nov 2026 02:18:08 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER changes for v7.4-rc3
Message-ID: <avUFwDt0ZQjf2os-@kernel.org>
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

The following changes since commit b3dfbde62cf1981c4638939c159dfd087b7a72e9:

  Merge tag 'linux_kselftest-fixes-7.4-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2026-11-09 16:39:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v7.4-rc3

for you to fetch changes up to 03fcb358249dc715124b3616f814ea0ecc6ec36c:

  tpm: acpi: Fix memory leak at tpm_read_log_acpi() error path (2026-11-10 14:52:19 +0200)

----------------------------------------------------------------
[GIT PULL] TPM DEVICE DRIVER changes for v7.4-rc3

Briefly described this PR tag contains the following bug fixes:

  1. Add the missing check of the return value of crypto_kpp_set_secret()
     when creating an authenticated HMAC session.
  2. Check the payload size of EVENT_TAG entries before reading them, in
     order to avoid out-of-bounds reads with a truncated TPM 1.x event
     log.
  3. Flush the timeout work outside buffer_mutex in tpm_common_read(), as
     the work itself takes the same mutex, which can lead to a deadlock.
  4. Fix a memory leak of the event log buffer in the error path of
     tpm_read_log_acpi().

No other bigger story here except as I've put tpm2-sessions.c to my private
"address the vector" TODO-list. It's something I'd really like to refurbish
in near future as secure boot enabled hibernate will also depend on it (an
upcoming feature).

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

----------------------------------------------------------------
Eric Biggers (1):
      tpm: Check return value of crypto_kpp_set_secret()

Guanglei Zhu (1):
      tpm: eventlog: check the payload size before reading tag events

Hyunjung Ko (1):
      tpm: flush timeout work outside buffer_mutex to avoid deadlock

Takashi Iwai (1):
      tpm: acpi: Fix memory leak at tpm_read_log_acpi() error path

 drivers/char/tpm/eventlog/acpi.c  |  4 +---
 drivers/char/tpm/eventlog/tpm1.c  |  7 +++++++
 drivers/char/tpm/tpm-dev-common.c | 12 +++++++++++-
 drivers/char/tpm/tpm2-sessions.c  |  4 +++-
 4 files changed, 22 insertions(+), 5 deletions(-)
