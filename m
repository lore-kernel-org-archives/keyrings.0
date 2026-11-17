Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918697;
	b=pCgY9WoHp5fLxWkWOdLmw4PfsCIxr68Nn6snnL6eFWbFlPDttlw+1WTkiMnK+0HtLnYQ
	 hw8MsETnwR5jPX2szQqhge0IRYaOgv3UiVkgbBunbOfj8eKVfLJnov8/BlS9KKC3gBS8a
	 /gHzyxn8Lmc8W2lb2HZArG2E+4M+xDk9MPCThRcLrWdyJZGCk6nnATwKFj0VeWSWKlCz9
	 wThDNSkhpN8AP9L7n3sD8UNCAxa0D01eUOIThunn/ILm0ageXKuf3KMJZm21AiIiCsuNs
	 9pkIyNo+H1D1uI7rqdad6rXchcABVQkFYU15LpIW+MSjsWIklc3gZWYYDCb3K5WBEug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918697;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=l0r+PNrqFBNtuM7tcgiDOPoaHoxY6H4NbwLfENsaXyc=;
	b=0zGp9nc8UXatgwn1BaNHwDtYaIA65+SjeOUiQpm52Yvxz8ReTnHph5BsAC+ooQIPQnhp
	 TZr8VFxi/RKWEFdX8HDeMSeXuFSJLOjH54NqIaGpkM5AGnI2tQb1iNME8ALbzd2eXMtHn
	 5MT//G7PL9IoFg6dL6NaaQvyeAzvV33Uw6ZhZgRq/0s+BbxyOAcsYJ81q6qu01ABHSlIN
	 zIaZ/YwrruFs5PxTU/uiABRQsLDVY3nyzc/3nHQb+Gjjaabj+zSxt5wPYCGBiXE8NbJTV
	 2WwQYujyrxx9H475lix7EFbHGs26cL4mcyAc7nScJoBQQXuUZpxRhLnb6GEqbV0mrhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=GgI3DPnu;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAC9606A329
	for <keyrings@vger.kernel.org>; Tue, 17 Nov 2026 12:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BAC9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=GgI3DPnu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1794918694; x=1795177894;
	bh=l0r+PNrqFBNtuM7tcgiDOPoaHoxY6H4NbwLfENsaXyc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GgI3DPnu3/lS00sVNW9WIiLjM5kP93ZlxXOSeF3NFV5d15rWtjYbI9BGuq+PZ+iHh
	 K52gHANR9Oj0cK3Oi3iMoxi2RwM7T5RZ8iMxHMT1GxzlaZSo6TaRrpug0+rdPpebYu
	 AvUEdVhqrFIge0aQ+O8XQAiFvMfXxc54XHPWGI3Qmv8Hk/Wq+G2gSY74gWpp34zUdx
	 S+P0SzyrhWFIO/CA7GLyApNy/rj3bEpT6uJw6w0Mrrl/GhK2uKt6zipE4mw9faDKJL
	 VXLboNhTbT7tkJP3IwrGDwT1n1IJkyR0u4ODjKPcZG/uMMi0jHYkE1t58T8HE9K9w+
	 nLl2a8zq1l1yg==
Date: Tue, 17 Nov 2026 12:31:30 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
From: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] keys: serialise instantiation against keyctl_chown_key
Message-ID: <20261117123056.1797-1-enscrpt@pm.me>
In-Reply-To: <avmoe41hNwe5GryN@kernel.org>
References: <20261115121722.206-1-enscrpt@pm.me> <avml2-lpRCJYlHOp@kernel.org> <avmmnHsz2vDUk8HO@kernel.org> <avmnRbuvbSg2fCVg@kernel.org> <avmoe41hNwe5GryN@kernel.org>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: f3dc833893944b86caf72da5a4897f1391cf4944
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Sorry for the sloppy v1 patch and for over-relying on an LLM to write
the commit message. That will not happen again. I have removed the
inline comments and rewritten the commit message in my own words.
Please let me know if any part of it is unclear, as I have tried to
describe it as clearly as I can.

The race happens because keyctl_chown_key() looks up the target key by
calling lookup_user_key() with KEY_LOOKUP_PARTIAL. That flag lets a
caller with CAP_SYS_ADMIN change the UID of an uninstantiated key during
construction. When the UID changes, keyctl_chown_key() swaps key->user
under key->sem and drops the old reference with key_user_put().
__key_instantiate_and_link() and key_reject_and_link() only hold
key_construction_mutex when they increment key->user->nikeys during
construction. __key_instantiate_and_link() also calls the key type
instantiate callback without holding key->sem on the key.

In key_payload_reserve(), when the key is in quota and its size changes,
key->user is read without key->sem. It reads key->user once for
spin_lock_irqsave(&key->user->lock, flags) and reads it again for
spin_unlock_irqrestore(&key->user->lock, flags). If keyctl_chown_key()
replaces key->user between those two reads, key_payload_reserve()
unlocks the new spinlock and leaves the old spinlock held.

As the Sashiko review noted on v1, taking down_write_nested(&key->sem,
1) also causes a lockdep cycle against __key_move_lock(). A lockdep test
on v1 triggered that warning on the first KEYCTL_MOVE call against the
keyring instantiation order. __key_move_lock() takes subclass 1 before
keyring_serialise_link_lock, while __key_link_lock() takes
keyring_serialise_link_lock before __key_instantiate_and_link() takes
key_construction_mutex. In v2 I switched down_write_nested() to subclass
2, which is an unused subclass taken only inside key_construction_mutex.
That change ran clean under lockdep on both 7.4-rc2 and your
for-next-keys branch across our test workloads.

I will send the v2 patch out to the list right after this message.

Thanks,
Sinan

