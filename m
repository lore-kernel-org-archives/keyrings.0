Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592568;
	b=ZRk4/bMZwz4xVrjO/viBYO/4uqktv2Prv5pGr4nCnBqXxoeNpw6vwuLNyWxV8exiZYjN
	 6IGQi6tc0CjPZ2uFlvAKupKd92atf6ruUEc5DeclptspmBowKvJZer92xqcXGeF7Ug2pM
	 pPWD9iSzw9/Gf7CgST4lBM92E6esYnhtJza7RrR5TR2Epbm7/pDkW4/C0u2HcxLB5/jse
	 5ind7rxGjjlpYAGq6jJZk2Z5pJFUx+6XWTHBPsRkMIuhHcXQA9gHrKVMguL4C+IPI+0aW
	 6PdvqgSO+JtYUAAQQx1Y//RKJQmxodVwPzUeKiwyVmnwvrf6NVVx5HTnuWUcHDXzZOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592568;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-Mailer;
	bh=ealE+2iqS8S/UaHnqwRQZ/xETA6Ub79rakl0qAH5nlc=;
	b=HIcUS1Uaxa6Ndw9sefgYrLgR9cIa7ZQT/eKpRMMH1CSFfP/WIVgquCSIf7CWtmQRMFpI
	 QgboyJtYsPenBZYzORZZ9eKz9Y25xgZjr6EgLjxf7dCMRCkMoOAaj6UALHBG8zy6enkHe
	 SU0IgyNGfX1hwB/ZpyoHWbjdQcNtW7MRUiis2H2et4Qg6ggcFaSiQ+by5Z6ZH66yHSER3
	 hIgEJNj3lP1u6RU8h3qU2UWjFh3KQo84FLhdEvEy7yM0pRBQIGqXCSsmg8BpSEpgSVJKk
	 Z6kV0yY9wBLB6j92F9EwzL1Lj3hdNxNS4ZHZP9p9NRInNR7ndb0Lcj1ioeaW1sCsB9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ws6JXbR5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AA88E60A261F;
	Wed, 21 Oct 2026 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ws6JXbR5
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AC0BD1F000CA;
	Wed, 21 Oct 2026 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792592567;
	bh=ealE+2iqS8S/UaHnqwRQZ/xETA6Ub79rakl0qAH5nlc=;
	h=Date:From:To:Cc:Subject;
	b=Ws6JXbR5pSLBkeIFksdBInn5pZBRmjOpByTTBnTpLoVZRvg91XE/awqvqU8Kqgc83
	 yIQLa/PexJWVLiIr4oEyA9htSTC8nMr7E+160xSVkTsfd8iCicSTBEiYH6UowohY9Z
	 GXzsiIjVziW2ogQvo+n6072P5lamrlD6GWJ5nKuG/9emLXaBK7v8NLkR0cBwLX20LT
	 zOxAJltlKhb167E6uqbAcSVw0fppl+gboKmueasYH6ZQ2gVrbxKn+VI/EeYM5Qvozv
	 +BRpQ5vVUrqeMNCcEqqYck+69GxHqSXV0fBq1CTQQPIAGHIY5oHNCsECJoSl4YbDoD
	 ermm9hUND8bgg==
Date: Wed, 21 Oct 2026 17:22:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>, Kyle Zeng <kylebot@openai.com>,
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] KEYS: changes for v7.4-rc1
Message-ID: <atjKs7PTN8CgndJg@kernel.org>
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

The following changes since commit c03c1a14507dfaf8b856c2608f9ac216021fc222:

  Linux 7.3 (2026-10-18 13:14:58 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc1

for you to fetch changes up to 722658cac48a6ba49f5506fd74d010ad9dbb2f05:

  keys/trusted_keys: reuse TPM version in option handling (2026-10-20 18:15:40 +0300)

----------------------------------------------------------------
KEYS: changes for v7.4-rc1

HIGHLIGHTS
==========

A patch that Kyle Zeng submitted addresses a critical bug and complements
the ongoing rhashtable migration. The commit in question is de891c73c1cf
("keys: make keyring indexes independent of kernel addresses").

The index value for the  associative array has been calculated with the
following formula:

	mult_64x32_and_fold(description + type address + domain address)

By creating a sequence of dummy keys (e.g., "A", "B", "C", ...), it is
trivial to form a group of equations with a predictable hash function, and
ultimately break KASLR.

Kyle's solution is based on an ephemeral SipHash key and an atomic 64-bit
counter, which is encapsulated to a key_index_id(). This function is then
used to assign identifiers for types and domains, and since the IDs are
unique for each power on, they are as unique as memory addresses are.

With these ingredients the index value calculation can be changed into
form, which is not leaking any kernel addresses:

	SipHash(description + type id + domain id)

This is exactly what the Kyle's commit does.

FEATURES AND IMPROVEMENTS
=========================

- TPM fields were moved from trusted_key_options to the TPM backend.
  They cost memory for non-TPM backends.
- A TPM trusted key now caches tpm_is_tpm2() at the root of each call
  chain, and passes the result as a parameter. This decreases the amount
  of I/O traffic given that tpm_is_tpm2() starts and stops the chip via
  tpm_try_get_ops() and tpm_put_ops().

BUGS
====

- A TPM trusted key corrupted the return value of a failed key unsealing
  operation if the pcrlock feature was used.
- A TPM 2 trusted key allocated an off-by-four too large buffer for the
  decoded ASN.1 blob coming from keyctl add trusted.
- Sometimes a TPM 2 trusted key rejected created keys based on the
  TPM2_Create response size, treating them as too large. Now it correctly
  checks the extracted TPM2 key blob size.
- The keyctl reject operation raced with keyctl restrict_keyring because
  keyring->sem was not held in key_reject_and_link() before accessing
  keyring->restrict_link.
- keyctl_describe_key() was not holding key->sem while accessing its
  fields, which can lead to use-after-free of a retired key type.
- find_keyring_by_name() and procfs code were reading the UID from
  key->user->uid instead of key->uid. The latter is the cached value and
  is meant to protect against a use-after-free caused by keyctl chown.
- search_process_keyrings_rcu() did not properly RCU-dereference the
  authorization key payload, which could cause a null dereference if the
  payload was revoked.
- keyctl_read_key() checked key->type->read without holding key->sem,
  which can lead to use-after-free if the type is retired. Based on my
  suggestion, this was addressed in __keyctl_read_key(), which already
  did take key->sem.

----------------------------------------------------------------
Adrian Martinez (1):
      KEYS: Fix key_reject_and_link() race with keyring restriction

Cen Zhang (5):
      keys: Protect the type name while describing a key
      keys: Avoid the owner account dereference in named keyring lookup
      keys: Check the authorization payload in process keyring searches
      keys: Avoid owner account dereferences in /proc/keys
      keys: Protect the read method check against type removal

Kyle Zeng (1):
      keys: make keyring indexes independent of kernel addresses

Srish Srinivasan (4):
      keys/trusted_keys: return immediately after TPM unseal failure
      keys/trusted_keys: move TPM-specific fields into struct trusted_key_tpm
      keys/trusted/tpm2: Validate TPM2_Create object sizes separately
      keys/trusted_keys: reuse TPM version in option handling

Stefano Garzarella (1):
      KEYS: trusted: Fix blob allocation size in tpm2_key_decode()

Thomas Huth (1):
      security: keys: Fix comment of search_process_keyrings_rcu()

 include/keys/trusted-type.h               |  11 ---
 include/keys/trusted_tpm.h                |  14 +++
 include/linux/key-type.h                  |   1 +
 include/linux/key.h                       |   5 +
 security/keys/key.c                       |  13 ++-
 security/keys/keyctl.c                    |  15 +--
 security/keys/keyring.c                   | 152 +++++++++++++++--------------
 security/keys/proc.c                      |   4 +-
 security/keys/process_keys.c              |   7 +-
 security/keys/trusted-keys/trusted_tpm1.c | 154 ++++++++++++++++--------------
 security/keys/trusted-keys/trusted_tpm2.c |  94 ++++++++++--------
 11 files changed, 258 insertions(+), 212 deletions(-)
