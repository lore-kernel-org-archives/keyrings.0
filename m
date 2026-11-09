Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186619;
	b=cv7n+oCKG+V37d7tGoxAuIGiCf9dylIA6GqAgEDHYotlf4OeMSzTEPNV8w7qsX039Lu/
	 5DyV/oAPShog1AzYbvPmXdLqoEf8tgiY4hyelph0hxoFAoBi0GEhxOAlHgYkjoPSClfRa
	 1p4nMHfz//s0mNMIkhcNqJ/KvOArNKUO8Fc538fYdGrrW7oymazZevqN2sxYeGO6P479N
	 LnqvlzLFFhMTmuqVz4V7wl7LaagCtD9Dzk7jfE6fm4Ws7hd3DjIPpu6M4xD2uKElruTyh
	 o27s+3qkXG70os8mZiMBuuEHg7sPImZiMdnp1OX/p5G6ILZJHSzwxyEhyVLHpR9lNFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186619;
	h=DMARC-Filter:DKIM-Signature:Mime-Version:References:
	 X-Lms-Return-Path:Date:Message-Id:To:Cc:Content-Transfer-Encoding:
	 Subject:From:In-Reply-To:Content-Type;
	bh=4jcjX6joc+srS3O97GeT+cQjpLftVRS/tISX9JrbOWQ=;
	b=aEGgawREHmrAye1fyZHdlsbq8e/AETuEoS6B+IgcgmvgfD1KVJ/Rvvw509tzxPEspiMi
	 zpGamGa8zNkTtoGUiQxdm+eD3YJS7IFQQdFSPn/lW29GNp/DGRzQsdIHB0cUYyzqa/fy7
	 /2lLGt+mXXNX3aOn5HtqApbtvPiUYzTeBcH2Zsf3Y71VjykrJB5lY+TdQepw+BA7BGcWi
	 35qJZ7UmApLfJ5+jzGY1bmRrMSzj6CoMdS7K+zw3+04ZzN+tyjMGobqyYEgcwtVgt9yja
	 i1a9D8bjOOyEozkk6wqgbNd4MeOZGmIvPj1zuAAWDaA+kQaANcHXxPm67+DSbox2Cpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=U5aVwT4v;
	arc=none smtp.remote-ip=209.127.230.113
Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61243606A31C
	for <keyrings@vger.kernel.org>; Mon,  9 Nov 2026 01:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61243606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=U5aVwT4v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794186612; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4jcjX6joc+srS3O97GeT+cQjpLftVRS/tISX9JrbOWQ=;
 b=U5aVwT4viuOZK3fMduHPQW2hkft5VTRH0AjkA1sanzUjVLl48v/nSzLfOYq/GszLU2N+2y
 rg9c9noX4n9lBrmi0ZAVSqgWlGo4TXMdHdo1/SvDncIE76l9FJlpGLL+9Fq1TtrD38RQgF
 xphTzwsO0af7uDICIBvfESAhO3NtuRAqtdlXPABAUDZyRM87BHC3YQ8wuqrGlmvVLQngfU
 thmtsiM/TF19AEmtGAp83bUSrwrkQq6rA6HUrqvUF/78MQHR0TKeSgwycv86HGCVcOEvrf
 4sG0TDcjNGV91AQPIASzzm+aJnH9+djkdgsZAPw6oz9mN/a5l0zF6yvctJ5RzQ==
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108131413.12012-2-weiguixiong@bytedance.com>
	<avDG8G-Jl1YsmfCs@kernel.org>
X-Lms-Return-Path: <lba+16af11d72+f54871+vger.kernel.org+weiguixiong@bytedance.com>
Date: Mon, 09 Nov 2026 09:10:08 +0800
Message-Id: <451788d5e97cba38274e663d2b7952c593e959be.f77cb812.a801.42ef.9775.d2480a239fa8@bytedance.com>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>, 
	"Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, 
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Guixiong Wei" <weiguixiong@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] KEYS: do not let an unmatched key decide the search result
From: "Guixiong Wei" <weiguixiong@bytedance.com>
In-Reply-To: <avDG8G-Jl1YsmfCs@kernel.org>
Content-Type: text/plain; charset=UTF-8


> From: "Jarkko Sakkinen"<jarkko@kernel.org>
> Date:=C2=A0 Mon, Nov 9, 2026, 03:01
> Subject:=C2=A0 Re: [PATCH] KEYS: do not let an unmatched key decide the s=
earch result
> To: "Guixiong Wei"<weiguixiong@bytedance.com>
> Cc: "David Howells"<dhowells@redhat.com>, <keyrings@vger.kernel.org>, "Pa=
ul Moore"<paul@paul-moore.com>, "James Morris"<jmorris@namei.org>, "Serge E=
 . Hallyn"<serge@hallyn.com>, <linux-security-module@vger.kernel.org>, <lin=
ux-kernel@vger.kernel.org>
> On Sun, Nov 08, 2026 at 09:14:12PM +0800, Guixiong Wei wrote:
> > KEYCTL_SEARCH returns -ENOKEY, -EKEYREVOKED, or -EKEYEXPIRED for the ke=
y
> > selected by type and description. =C2=A0keyring_search_iterator() curre=
ntly
> > records revoked or expired state before asking the key type whether the=
 key
> > matches.
>=C2=A0
> I don't understand the "asking the key type or" part here. Please,
> explain what you mean.
>=C2=A0
I meant calling ctx->match_data.cmp() to check whether a candidate key
matches the search request. For dns_resolver, this calls
dns_resolver_cmp() to compare the candidate's description with the
requested name. I'll make that explicit in v2.

> >=C2=A0
> > Direct lookup visits the indexed description, so that ordering normally
>=C2=A0
> "Direct lookup visits the indexed description"
>=C2=A0
> I don't honestly understand this type of jargon, which is all over the
> place.
>=C2=A0
I meant that assoc_array_find() looks up a candidate using the requested
type and description. The dns_resolver search instead walks the keys and
checks their descriptions using dns_resolver_cmp().
I'll rewrite the commit message around your foo/bar example.

> > does not matter. =C2=A0Iterative lookup visits every key of the request=
ed type,
> > however. =C2=A0The in-tree asymmetric id/ex/dn lookups and dns_resolver=
 use this
> > mode. =C2=A0A revoked key with a different description can therefore ma=
ke
> > KEYCTL_SEARCH return -EKEYREVOKED instead of continuing the search. =C2=
=A0It can
> > also prevent request_key_and_link() from issuing an upcall because that
> > path only upcalls after -EAGAIN. =C2=A0An unmatched expired key similar=
ly
> > pollutes searches that do not set KEYRING_SEARCH_SKIP_EXPIRED; the requ=
est
> > path itself sets that flag.
> >=C2=A0
> > Run the type comparator before recording state errors, so only a key th=
at
> > matches the caller's criterion can decide the search result.
>=C2=A0
>=C2=A0
> Can you describe instead describe the what goes wrong with an example,
> which does not require much effort:
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyctl new_session >/dev/null
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 A=3D$(printf '127.0.0.1\0' | keyctl padd dns_=
resolver foo @s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyctl revoke "$A"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyctl search @s dns_resolver bar
>=C2=A0
> Results:
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyctl_search: Key has been revoked
>=C2=A0
Thanks for the reproducer. The expected result is -ENOKEY because "bar"
is absent.

When the search encounters "foo", keyring_search_iterator() sets
ctx->result to -EKEYREVOKED and skips that candidate before calling
dns_resolver_cmp(). It therefore never checks whether "foo" matches
"bar".

The walk continues, but in this example it finishes with ctx->result
still set to -EKEYREVOKED. My wording "instead of continuing the search"
was inaccurate.

The patch moves the match check before the state checks, so "foo" is
skipped without changing ctx->result.

> This example alone is not of course enough because it is lacking
> explanation what goes wrong, which is neither clearly described by
> the commit message but you could add my reported-by because at
> least I constructe a real bug report that justifies this fix.
Thanks, I will add your Reported-by.

>=C2=A0
>=C2=A0
> >=C2=A0
> > Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> > Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> > ---
> > =C2=A0security/keys/keyring.c | 12 ++++++------
> > =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
> >=C2=A0
> > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > index 7143f3079d200..39645b8f9b30c 100644
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -598,6 +598,12 @@ static int keyring_search_iterator(const void *obj=
ect, void *iterator_data)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* A key the caller did not ask for must n=
ot decide the result. */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ctx->match_data.cmp(key, &ctx->match_=
data)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kleave(" =3D 0=
 [!match]");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* skip invalidated, revoked and expi=
red keys */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ctx->flags & KEYRING_SEARCH_DO_ST=
ATE_CHECK) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time64_t =
expiry =3D READ_ONCE(key->expiry);
> > @@ -617,12 +623,6 @@ static int keyring_search_iterator(const void *obj=
ect, void *iterator_data)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0/* keys that don't match */
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ctx->match_data.cmp(key, &ctx->match_=
data)) {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kleave(" =3D 0=
 [!match]");
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > -
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* key must have search permissions *=
/
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(ctx->flags & KEYRING_SEARCH_NO_=
CHECK_PERM) &&
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0key_task_permission(mak=
e_key_ref(key, ctx->possessed),
> > --=C2=A0
> > 2.55.0
>=C2=A0
> Br, Jarkko
>=C2=A0

Thanks,
Guixiong
