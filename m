Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801766;
	b=zHO+d1SJrTuIJ/2jnyQyRsCdDMCtpbxaEy/Wu6IFCmfs1yKebaxu9BZnFuv/OR7U0qCg
	 NPJ3IcdEX9szy7bPq0jVLXv29IWlR4CBmDuoRJlFHN3dh7/tOy6PRwGsfVvbHfRQO6dHn
	 FJpRymP9oB4z1rM0Do0OdcPf5+LGg9HZC5IQJmef04SyTs5vzQm599RmvtZS2DPAZDkkK
	 MYDzX/1/zqqJXgu0GhC/PXqVSUgmwF6xaeXC36nVy90wO6zsamhl4jG/UcGE1tV9Dal1j
	 didlIwjIv4jnJjcC/LiP0A/w+yuKXmCzetbaWOhhQ1Ns8WeGJv/2K9KVx3ygdgd2RmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801766;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Mime-Version:Content-Type:
	 Date:Message-Id:Subject:Cc:From:To:References:In-Reply-To:
	 X-Scanned-By;
	bh=Y/Gw+uO8dNWe1Q6KWKNGi2gbav0cIn6VvyubnYQMPkg=;
	b=gh1p3yTBloar9BFiDqqN2ffrv+HSkf4NpNioX2SrURHYoO7yWLuxm9sFYKlpdSrVGz0v
	 A3+23kKUcp+5sz5B4aflNzkoW+CowhJv9MAbAB7MMcFX9w+KlhL1bjbPTiyoCqm3hG0uX
	 fqMe+CIDzqX7YjncEh3YUThSmWt9++sYzEcuXaCPAA0jnAfrT9TppNALTnaXWcYYAuAOb
	 l4qKasHv44pBYu5xF6kaENzt7//oalwncdT9ZdmD3/bg1W8z3iz7YMXNAwmLFC8LMVAck
	 ACHDgPO96D8INmWUCBWbGyEjyj633yHUd4HQuZH7HvSQ87gygm9JR6Q52tqoR4Ay+7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlidYhnQ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403C606A31E
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 17:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B403C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlidYhnQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795801764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/Gw+uO8dNWe1Q6KWKNGi2gbav0cIn6VvyubnYQMPkg=;
	b=FlidYhnQC84sx2bcMIua3XRrO13Bm1FFGxRuvsXQvVfj4TY+yh/nA1jyd3WQk3hSBavQSV
	n88xjJC3obkRwi1TNQ3SgqMRMHEspaehNfZ8umIB5hQnylYDzjMueyQKk5sDUJK3xp3Pi+
	yQdnCrXYvOvG00qHd5NU10FTOvpA3Fg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-RW6IK39hMkGI2nB0A7B1LA-1; Fri,
 27 Nov 2026 17:49:20 +0000
X-MC-Unique: RW6IK39hMkGI2nB0A7B1LA-1
X-Mimecast-MFC-AGG-ID: RW6IK39hMkGI2nB0A7B1LA_1795801759
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2196E195604A;
	Fri, 27 Nov 2026 17:49:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAE5630002C2;
	Fri, 27 Nov 2026 17:49:17 +0000 (UTC)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e2767366775068f5a60759cf64536a5c74e96766aee942698b581447a777;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 27 Nov 2026 14:49:13 -0300
Message-Id: <DN66LCLCYBP5.O2KSAOOS8SYO@redhat.com>
Subject: Re: [PATCH 1/3] certs: blacklist: define skid: entries and add
 is_key_blacklisted()
Cc: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells"
 <dhowells@redhat.com>, "Roberto Sassu" <roberto.sassu@huawei.com>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Bruno Meneguele" <bmeneg@redhat.com>
To: "Mimi Zohar" <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
References: <20261106173149.707244-1-zohar@linux.ibm.com>
 <20261106173149.707244-2-zohar@linux.ibm.com>
In-Reply-To: <20261106173149.707244-2-zohar@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

--e2767366775068f5a60759cf64536a5c74e96766aee942698b581447a777
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed

On Fri Nov 6, 2026 at 2:31 PM -03, Mimi Zohar wrote:
> A "tbs:" blacklist entry is only compared against certificates being
> added to a keyring or presented in a signature chain, so it does not
> stop a key that is already loaded from being used as a trust anchor.
>
> Define a new "skid:<hex>" blacklist entry, holding a Subject Key
> Identifier, and add is_key_blacklisted(), which looks up the SKID of an
> asymmetric key in the system blacklist.  Entries are added like "tbs:"
> and "bin:" entries and are subject to CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE=
.
>
> blacklist_vet_description() now uses a prefix table, since the prefixes
> no longer all have the same length.  "tbs:" and "bin:" entries behave
> as before.
>
> For example, to add an entry for a certificate (the signed string must
> not include a trailing newline):
>
>   skid=3D$(openssl x509 -in cert.pem -noout -ext subjectKeyIdentifier |
>          sed -n '2s/[ :]//gp' | tr A-F a-f)
>   printf 'skid:%s' "$skid" > skid.txt
>   openssl smime -sign -binary -noattr -in skid.txt -signer signer.crt \
>           -inkey signer.key -outform DER -out skid.p7s
>   keyctl padd blacklist "skid:$skid" %:.blacklist < skid.p7s
>
> The SKID is also the hex string in the description of the key on a
> keyring, and its last four bytes are the key ID in the security.ima
> xattr, so an entry is easy to correlate with the key it revokes:
>
>   # keyctl show %:.ima | grep 073d
>   927946571 --als--v  0  0   \_ asymmetric: test signing key: b7809c3372a=
07fe87248dcec7ff047a40fb3073d
>   # keyctl show %:.blacklist | grep skid
>   1014808518 ----s--v 0  0   \_ blacklist: skid:b7809c3372a07fe87248dcec7=
ff047a40fb3073d
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog v1:
> - Addressed Sashiko issues: drop Kconfig change, linking issues when
> blacklist support configured, but without CONFIG_ASYMMETRIC_KEY_TYPE
> configured.
>
>  certs/blacklist.c             | 83 ++++++++++++++++++++++++-----------
>  include/keys/system_keyring.h | 12 +++++
>  2 files changed, 70 insertions(+), 25 deletions(-)
>
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index fa561c12eabf..9158bd9f9fc9 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -32,6 +32,7 @@
>
>  static const char tbs_prefix[] =3D "tbs";
>  static const char bin_prefix[] =3D "bin";
> +static const char skid_prefix[] =3D "skid";
>
>  static struct key *blacklist_keyring;
>

Hi Mimi,

the script certs/check-blacklist-hashes.awk needs to be updated to allow "s=
kid:"
hash type too, otherwise build fails with "unknown prefix":

$ echo '"skid:3afbecd5ee1d3d787c61270797e5c85065d030cc"' > certs/blacklist.=
txt
$ scripts/config --set-str SYSTEM_BLACKLIST_HASH_LIST certs/blacklist.txt
$ make certs/
  DESCEND objtool
  GEN     certs/blacklist_hash_list
Unknown prefix (item 1): skid:3afbecd5ee1d3d787c61270797e5c85065d030cc
make[3]: *** [certs/Makefile:21: certs/blacklist_hash_list] Error 1
make[2]: *** [scripts/Makefile.build:572: certs] Error 2
make[1]: *** [/home/brdeoliv/git/linux/Makefile:2244: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

It seems to be just a single line of code and the file documentation:

-       if (!match(part1[1], "^(tbs|bin):(.*)$", part2)) {
+       if (!match(part1[1], "^(tbs|bin|skid):(.*)$", part2)) {

At the same time, I noticed you also dropped the Kconfig documentation chan=
ge
for CONFIG_SYSTEM_BLACKLIST_HASH_LIST when you fixed Sashiko's report.

> @@ -40,36 +41,30 @@ extern __initconst const u8 revocation_certificate_li=
st[];
>  extern __initconst const unsigned long revocation_certificate_list_size;
>  #endif
>
> +static bool blacklist_prefix_valid(const char *desc, size_t len)
> +{
> +	return (len =3D=3D sizeof(tbs_prefix) - 1 &&
> +		!strncmp(desc, tbs_prefix, len)) ||
> +	       (len =3D=3D sizeof(bin_prefix) - 1 &&
> +		!strncmp(desc, bin_prefix, len)) ||
> +	       (len =3D=3D sizeof(skid_prefix) - 1 &&
> +		!strncmp(desc, skid_prefix, len));
> +}
> +
>  /*
> - * The description must be a type prefix, a colon and then an even numbe=
r of
> - * hex digits.  The hash is kept in the description.
> + * The description must be a type prefix ("tbs", "bin" or "skid"), a col=
on and
> + * then an even number of lower-case hex digits.  The hash (or, for "ski=
d", the
> + * Subject Key Identifier) is kept in the description.
>   */
>  static int blacklist_vet_description(const char *desc)
>  {
> -	int i, prefix_len, tbs_step =3D 0, bin_step =3D 0;
> -
> -	/* The following algorithm only works if prefix lengths match. */
> -	BUILD_BUG_ON(sizeof(tbs_prefix) !=3D sizeof(bin_prefix));
> -	prefix_len =3D sizeof(tbs_prefix) - 1;
> -	for (i =3D 0; *desc; desc++, i++) {
> -		if (*desc =3D=3D ':') {
> -			if (tbs_step =3D=3D prefix_len)
> -				goto found_colon;
> -			if (bin_step =3D=3D prefix_len)
> -				goto found_colon;
> -			return -EINVAL;
> -		}
> -		if (i >=3D prefix_len)
> -			return -EINVAL;
> -		if (*desc =3D=3D tbs_prefix[i])
> -			tbs_step++;
> -		if (*desc =3D=3D bin_prefix[i])
> -			bin_step++;
> -	}
> -	return -EINVAL;
> +	const char *colon =3D strchr(desc, ':');
> +	int i;
>
> -found_colon:
> -	desc++;
> +	if (!colon || !blacklist_prefix_valid(desc, colon - desc))
> +		return -EINVAL;
> +
> +	desc =3D colon + 1;
>  	for (i =3D 0; *desc && i < MAX_HASH_LEN; desc++, i++) {
>  		if (!isxdigit(*desc) || isupper(*desc))
>  			return -EINVAL;
> @@ -160,6 +155,10 @@ static char *get_raw_hash(const u8 *hash, size_t has=
h_len,
>  		type_len =3D sizeof(bin_prefix) - 1;
>  		type_prefix =3D bin_prefix;
>  		break;
> +	case BLACKLIST_HASH_SKID:
> +		type_len =3D sizeof(skid_prefix) - 1;
> +		type_prefix =3D skid_prefix;
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return ERR_PTR(-EINVAL);
> @@ -244,6 +243,40 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_=
len,
>  }
>  EXPORT_SYMBOL_GPL(is_hash_blacklisted);
>
> +#ifdef CONFIG_ASYMMETRIC_KEY_TYPE
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
> +
> +	kids =3D asymmetric_key_ids(key);
> +	if (!kids)
> +		return 0;
> +
> +	skid =3D kids->id[1];
> +	if (!skid || !skid->len)
> +		return 0;
> +
> +	return is_hash_blacklisted(skid->data, skid->len, BLACKLIST_HASH_SKID);
> +}
> +EXPORT_SYMBOL_GPL(is_key_blacklisted);
> +#endif
> +
>  int is_binary_blacklisted(const u8 *hash, size_t hash_len)
>  {
>  	if (is_hash_blacklisted(hash, hash_len, BLACKLIST_HASH_BINARY) =3D=3D
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.=
h
> index a6c2897bcc63..2ac1dae2063a 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -15,6 +15,8 @@ enum blacklist_hash_type {
>  	BLACKLIST_HASH_X509_TBS =3D 1,
>  	/* Raw data hash */
>  	BLACKLIST_HASH_BINARY =3D 2,
> +	/* Subject Key Identifier of a key (not a hash) */
> +	BLACKLIST_HASH_SKID =3D 3,
>  };
>
>  #ifdef CONFIG_SYSTEM_TRUSTED_KEYRING
> @@ -92,6 +94,16 @@ static inline int is_binary_blacklisted(const u8 *hash=
, size_t hash_len)
>  }
>  #endif
>
> +#if defined(CONFIG_SYSTEM_BLACKLIST_KEYRING) && \
> +    defined(CONFIG_ASYMMETRIC_KEY_TYPE)
> +extern int is_key_blacklisted(const struct key *key);
> +#else
> +static inline int is_key_blacklisted(const struct key *key)
> +{
> +	return 0;
> +}
> +#endif
> +
>  struct pkcs7_message;
>  #ifdef CONFIG_SYSTEM_REVOCATION_LIST
>  extern int add_key_to_revocation_list(const char *data, size_t size);
> --
> 2.56.0





--
Bruno Meneguele
PGP Key: http://bmeneg.com/pubkey.txt


--e2767366775068f5a60759cf64536a5c74e96766aee942698b581447a777
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----

wsCpBAEBCABdBYJrCcKcCRBh1GQVH5GiQzUUAAAAAAAcABBzYWx0QG5vdGF0aW9u
cy5vcGVucGdwanMub3JnEsYLSdME4OnumBKUuDqa4BYhBHVqOp0252XWw5l7rWHU
ZBUfkaJDAABKogf9GFxVptXl/MrZOfzQGOGFT/B6iALGAAoKkZiVEHgsHB0MfH2m
EbC0R7CpPjUmEDDfweR92J3Wu2NUUuYwcMxVH4YIqQbawoonD9aEku7G3URGaPWA
qSBKYwoxbTG3/467wDf92snxLFDgC1bC4ofQwz9ynfvH9/9tuQznekWdaJ7G43c1
42zygjLsyu748GGailNEjW/MrZTbSDvLjN6eOo89p2VhvvnDx5qGwzQv+b/bjF2p
kt22schgopEOmmylq2RWUeHRTFlUNkhhlnw9JmRQaO021ImDHAB9BA0wsHnH/Wle
uTcgB09hgZLG+Q0diUgv63eRitCw9ugUwCpdVw==
=tSap
-----END PGP MESSAGE-----
--e2767366775068f5a60759cf64536a5c74e96766aee942698b581447a777--

