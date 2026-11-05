Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881354;
	b=Wsy48xoGsp/C9p1kvlT3HJPdi3sE03lcwoeKJsCpxt232uebbTRuVtBVtGpzLjoFvLJt
	 MaZ4+3bkUseaY2acCpb039Q15ghjhKE/8v7dCP4skI5PoStkeIN+g3Pt5PVUeffAGotoo
	 749PaDLqhch2RWxfxJFkI+K8GUnc57UZNleyh8E3TsOLXdaaNhnxd3hNzJUooToXO2LUJ
	 T3DySKPL1+Mba5d5PYMezucX/ln8372/DGQkTqjX/kIbV/nrf5SE56iSmeY1wpijy/WPX
	 LcBHK+69U39om71ykyVOd8nBm6ARil8Hv12XHws5J7UlK4DkZuNruItimypJmEMWfYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881354;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ezpYXNFsy1y6+X9znA1J9LRhp0aIQ8gmE31msJTlGEY=;
	b=wYWtJz+UtldP1BCO/fRjvcC6SjqXqSLdzPnjROH+nzmPnp8XsrgzhUR6IbTKKJc17ich
	 qWoKMy4ZDl4eJdF9kERD4aLC3pvXKJceFbv2BPlOfUBnqWwlYD2MG2NQY/YYi9HZIfzVK
	 z443L/7AFqFnNtYtvNTU7oTvZd0fO4tNJMdVf9p5WPUxafeF2poynKn12k2vY364pW04I
	 ApIPnZt/TpN96OjsNEuJ85kwTPy2ch+y6W5rVOUuVaGxcruE++m7m6QdF5L9NupDelR0C
	 ctXax41tEtDjxqHjHNSkQsMzYuGiXlY613+J4GzkPQzVMBx1nqpEjp4fb2bhcQ1dThA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKphP2Mf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A63606A32F
	for <keyrings@vger.kernel.org>; Thu,  5 Nov 2026 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKphP2Mf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DAD1F000C1;
	Thu,  5 Nov 2026 12:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881353;
	bh=ezpYXNFsy1y6+X9znA1J9LRhp0aIQ8gmE31msJTlGEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKphP2Mf8qAGLwAsViDCmatbud5ctRZ2+M67BeTLJl0/79Ue7dCHMzD+6WSPh4yHv
	 Wj+E06NYCrL652QyDNLWmKQs1r/1Yu9n7Zxr+jFnwNAcqURNvH0ILFZHCJj1ATUfsR
	 sx2DT/PgSdc9V/31/AlPnsZSuF9ZQRuJTC+QdpOPVr2VZcUZVaD70LdZiOYOLg9k9P
	 KRCfr/yF8r1goQGp42WW3nULJ9zM/r1tGl0k50NCs1vY04+k6B1SR6R0inN+F8gb9I
	 MW+mbY3+/QrvE7qd3UPCu5Jx4K+P1h16MbbvOCtkMfLSG1FEXUNjfT2BOF1A9ZCbl8
	 uOkP5u1b725Pg==
Message-ID: <sashiko-outbox-199019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] certs: blacklist: define skid: entries and add
 is_key_blacklisted()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mimi Zohar" <zohar@linux.ibm.com>
Cc: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, keyrings@vger.kernel.org
In-Reply-To: <20261105121227.4089147-2-zohar@linux.ibm.com>
References: <20261105121227.4089147-1-zohar@linux.ibm.com>
 <20261105121227.4089147-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:22:32 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] certs: blacklist: check-blacklist-hashes.awk rejects skid: prefix
- [Medium] certs: blacklist: undefined key_type_asymmetric in is_key_blackl=
isted()
--

commit 28646d9ec2c355c55a1dbd687d050b270243210e
Author: Mimi Zohar <zohar@linux.ibm.com>

certs: blacklist: define skid: entries and add is_key_blacklisted()

This commit introduces a new "skid:<hex>" blacklist entry type for revoking
already-loaded asymmetric keys by their Subject Key Identifier and adds
is_key_blacklisted() to query the system blacklist for a key's SKID.

> diff --git a/certs/Kconfig b/certs/Kconfig
> index 9d2bf7fb5b9e4..9e51f988ba3bd 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -155,10 +155,11 @@ config SYSTEM_BLACKLIST_HASH_LIST
>  	  If set, this option should be the filename of a list of hashes in the
>  	  form "<hash>", "<hash>", ... .  This will be included into a C
>  	  wrapper to incorporate the list into the kernel.  Each <hash> must be=
 a
> -	  string starting with a prefix ("tbs" or "bin"), then a colon (":"), a=
nd
> -	  finally an even number of hexadecimal lowercase characters (up to 128=
).
> +	  string starting with a prefix ("tbs", "bin" or "skid"), then a colon
> +	  (":"), and finally an even number of hexadecimal lowercase characters
> +	  (up to 128).

[Severity: Medium]
When CONFIG_SYSTEM_BLACKLIST_HASH_LIST is set, certs/Makefile runs
certs/check-blacklist-hashes.awk via cmd_check_and_copy_blacklist_hash_list
to validate the hash list file during the build:

certs/check-blacklist-hashes.awk:
	if (!match(part1[1], "^(tbs|bin):(.*)$", part2)) {
		print "Unknown prefix (item " NR "):", part1[1];
		exit 1;
	}

Since certs/check-blacklist-hashes.awk only allows tbs and bin prefixes,
won't any skid:<hex> entry in the file configured by
CONFIG_SYSTEM_BLACKLIST_HASH_LIST be rejected with an "Unknown prefix" error
and fail the kernel build?

> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index fa561c12eabfe..b1e2c178d3782 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c

[ ... ]

> @@ -244,6 +243,38 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_=
len,
>  }
>  EXPORT_SYMBOL_GPL(is_hash_blacklisted);
> =20
> +/**
> + * is_key_blacklisted - Determine if a key is blacklisted by its SKID
> + * @key: The key to be checked, e.g. a trust anchor found in a keyring
> + *
> + * Unlike a "tbs:" entry, which is only compared against certificates be=
ing
> + * added or presented in a chain, this checks a key that is already load=
ed, so
> + * that keys that cannot be unlinked from their keyring can still be rev=
oked.
> + * The identifier is taken from the key itself, not from the caller.
> + *
> + * Returns -EKEYREJECTED if the key's Subject Key Identifier is blacklis=
ted,
> + * 0 if it is not (or the key has no SKID), or another negative error.
> + */
> +int is_key_blacklisted(const struct key *key)
> +{
> +	const struct asymmetric_key_ids *kids;
> +	const struct asymmetric_key_id *skid;
> +
> +	if (!key || key->type !=3D &key_type_asymmetric)
> +		return 0;

[Severity: Medium]
In certs/Kconfig, SYSTEM_BLACKLIST_KEYRING only depends on KEYS and does not
depend on or select ASYMMETRIC_KEY_TYPE:

certs/Kconfig:
config SYSTEM_BLACKLIST_KEYRING
	bool "Provide system-wide ring of blacklisted keys"
	depends on KEYS

However, key_type_asymmetric is defined in
crypto/asymmetric_keys/asymmetric_type.c, which is only built when
CONFIG_ASYMMETRIC_KEY_TYPE is enabled.

If the kernel is built with CONFIG_SYSTEM_BLACKLIST_KEYRING=3Dy and
CONFIG_ASYMMETRIC_KEY_TYPE=3Dn, won't this unconditional reference to
key_type_asymmetric in is_key_blacklisted() cause a link failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105121227.4089=
147-1-zohar@linux.ibm.com?part=3D1
