Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759002;
	b=ZBpjJju9uJZEolmjNNaXH8EkpNEYSHLORsG5iNfwGSTxlbjpcH4nBZdefDuCNOv+Yt5U
	 GtzKLZL5Okyhfx+VfiY0hgjRJCbnLsgdtj0r3PhQVF2Pj3yERwbJIA3hTQ3XKeG7fAr4l
	 NoLftsgZO5XwA98zp0lWDxhKnSLCDtsGrnC6XUUXnaP0EbLnXJVFGKZkM6XZ4zLjnbEJ2
	 0h9heWfQkcTKYroGFduuU1CZcHdDcBcTDikmQR4MZKouKegA4Nnqc7q/H+9hg1quiEZXk
	 LT11Pom4PY9Pxrk3/4Jx+ug6Cj05OEQeNid8Fs/LONbeAfxiqcUlosO9Q+ra12kqqHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759002;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RaGtUh8FrKmyPvFMUEoPr3f7XuLh19AsiacLSnrZZP0=;
	b=v6sr+smcUproQcTTpUhdn9W+cx9ZVp6ursEOQ2nNZvoGGwB9RkNad/6D4ibjj33HtVx1
	 JnIEVVOQCwrQCP+s1JKxNxTdRNhRLYUx0pISA9IyCfe3Mo5s9O6tkUkglVxei7rp96GvA
	 P3CP5bEU7obVoANsy0Tz+6sUkXP9KX5ehBtN+UYV0tjkTxQb1qWyPpXipJ4YrypNugheh
	 vxHZFw3N0p9dGwNFbx6cGLWu7hCvCnmmrSnT+lMLoSHSFnZiZWzpJAgEzHLooBbGa/OZ6
	 jZAtIoxqGYhgGAOrST5VsHLgJyLe4fg9cT5g4CwAzadIJwWnwH4MkMFtmQsUChoztaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZxOl6pU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C4073606A31A;
	Fri, 23 Oct 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZxOl6pU
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1A4EE1F01825;
	Fri, 23 Oct 2026 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792759001;
	bh=RaGtUh8FrKmyPvFMUEoPr3f7XuLh19AsiacLSnrZZP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hZxOl6pU/CfgecAx5DkVSKhlHpRQoUaDuzMvIRHesZZAGqZw2wfIpugp/cCrU4+IO
	 90LyqQO9VBFPFk49KNCceouIjl2V2muGHR1t520J55Wke/IpdMK7PLE3gIcTf9Vrs8
	 GBShxEXC2cwqfwAfBTMq/6KsJscRRyUI0s+MSlBOJwQxGS972AhfS21mCPF5gOK0i2
	 glljXcDdtQkAt87OOi8ZShCL85GGfznuRCSBwtPxCq0Ta3ezG5p/TAAFMq9oBee02Q
	 hvn+Gi/Tzk1dR6bd8p/kPhEHmisfdO19ZJkD6gS3VtP9CZ+es8Dv+EYkWmmHAaFzc7
	 hxjh91YXqVl7A==
Date: Fri, 23 Oct 2026 15:36:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:LIBRARY CODE" <linux-kernel@vger.kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 0/6] KEYS: From assoc_array to rhashtable migration
Message-ID: <attU1XQg7BIvhPag@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
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
In-Reply-To: <20261023120953.1206778-1-jarkko@kernel.org>

On Fri, Oct 23, 2026 at 03:09:20PM +0300, Jarkko Sakkinen wrote:
> The keyring subsystem depends on assoc_array for searching keys by their
> description, type and domain. It is the sole user of this data structure,
> which has during the age of LLMs transformed into a maintenance nightmare.
> 
> assoc_array needs to be replaced with a data structure meeting the
> following criteria:
> 
> 1. Must be suitable for a sparse key-value store.
> 2. Must have multiple in-kernel users.
> 3. Would be nice if it had dedicated maintainers.
> 
> rhashtable is likely the best pick from the available options as it is
> designed for a sparse key space, has dedicated maintainers, and multiple
> in-kernel users.
> 
> CHANGES
> =======
> 
> v2:
> - Tried to address all the issues pointed out by David and Eric. Tell me
>   if something was ignored, as that would be an unintentional mishap.
> - Updated and trimmed the source code comments.
> - For assoc_array_edit I decided to go with two-element pointer array,
>   which shifts a bit what David suggested.
> - Dropped is_keyring flag. It was so obvious call so I mention it here
>   just in case because too obvious maxes out my self-doubt ;-)
> - Used cleanup.h primitives where I possibly could especially in order
>   to make fallible initializations more bug-resistant.
> - The already-ack'd bug fixes are included but will be dropped as soon
>   as I've sent them over to Linus.
> 
> VERSIONS
> ========
> 
> - v2:
>   https://lore.kernel.org/keyrings/20261016215326.4110064-1-jarkko@kernel.org/`
> 
> Jarkko Sakkinen (6):
>   KEYS: Expand key->{datalen,quotalen} to unsigned int
>   KEYS: Reject descriptions larger than KEY_MAX_DESC_SIZE
>   KEYS: Verify the key identity in __key_unlink_begin
>   KEYS: Introduce keyring_is_empty()
>   KEYS: Replace assoc_array with rhashtable
>   lib: Remove assoc_array
> 
>  Documentation/core-api/assoc_array.rst        |  564 ------
>  Documentation/core-api/index.rst              |    1 -
>  .../zh_CN/core-api/assoc_array.rst            |  473 -----
>  .../translations/zh_CN/core-api/index.rst     |    1 -
>  drivers/md/dm-verity-verify-sig.c             |    2 +-
>  fs/smb/client/cifsacl.c                       |    6 +-
>  fs/verity/signature.c                         |    2 +-
>  include/keys/keyring-type.h                   |    1 -
>  include/linux/assoc_array.h                   |   88 -
>  include/linux/assoc_array_priv.h              |  178 --
>  include/linux/key.h                           |   27 +-
>  lib/Kconfig                                   |   14 -
>  lib/Makefile                                  |    1 -
>  lib/assoc_array.c                             | 1724 -----------------
>  security/keys/Kconfig                         |    1 -
>  security/keys/internal.h                      |    9 +-
>  security/keys/key.c                           |   30 +-
>  security/keys/keyctl.c                        |    2 -
>  security/keys/keyring.c                       |  871 ++++-----
>  security/keys/request_key.c                   |   24 +-
>  .../dm-verity/test-dm-verity-keyring.sh       |    2 +-
>  21 files changed, 457 insertions(+), 3564 deletions(-)
>  delete mode 100644 Documentation/core-api/assoc_array.rst
>  delete mode 100644 Documentation/translations/zh_CN/core-api/assoc_array.rst
>  delete mode 100644 include/linux/assoc_array.h
>  delete mode 100644 include/linux/assoc_array_priv.h
>  delete mode 100644 lib/assoc_array.c
> 
> --
> 2.47.3
> 

I must have typoed my send-email command-line as Eric was supposed to be
Cc'do to the whole thread, duh. Will be addressed next round, apologies.

Br, Jarkko
