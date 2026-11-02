Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623269;
	b=cqavQHMOAxlvBnCt/TFBWH684rB1FH8hk/Z3VkzxT0LtJU/B1XKeb6RUqH2yI8ORilRp
	 1QZgx8/eR2CYAcn1bo16TUzMtavC3R0S/MyQkqEASG8wdyEKzfDthq9sIz4HGhRivI/mo
	 rP/0gEyCr6osXQ3JD/l/XM7+9IhTYHzdKzPfb2dxzYWu381BS4FrEXQVTCUSK2Yi0n4Hw
	 SnyZdPFi358xfobvMjTrpS3AhcrXU7820GBCNwKDeM8/rGvAJvLYp3Sflric9kDievb44
	 d1qfn2ZVHyj6rstUPjSQzS6zuszmMhGlktecUZv5NdExwszApoK3/ntdR5J7F1xO2nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623269;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PiLUQ0nWHS5zwThndIBCzrGp6LTAmh5lgj9gktWhcBo=;
	b=W9fEAEk8r1DEhFnxsNGJx26/3ieGWs/Ydic8YEotE0duCB133Cdo1z52NxPO70cHGHlV
	 khgaG4FE7hsD4MmuqXeiubUcHgTcgsK8TWFdz21ZaSYyCKF9wBA26Iq+x+68zC1mLKiCE
	 u+N0nC0hTsxSTaTP3EKbN+Zn1wWMqeUxOQsdCiQRKYOluaZysR/WqHd6FSKxs5qF3AvfM
	 pul42z6pQPHV4I1BcXXH08VUOIcfbykAglqWf1titoZgVdiQ4kNYlmi+Ri892pj04dGUr
	 1crLNLiF5NVTWzv6UxNG4k8FXMlpOExM6zhZUwob9NO9AXYWqzEaJxvtge/QoWfL8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lB1ILR4E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E8BD5606A324;
	Mon,  2 Nov 2026 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lB1ILR4E
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 05B051F00A17;
	Mon,  2 Nov 2026 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623268;
	bh=PiLUQ0nWHS5zwThndIBCzrGp6LTAmh5lgj9gktWhcBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lB1ILR4EeVVIEFfE5OhyJ+P6ZBavnJ4AFBJgsBvoMeh7fndAXVVl1Ct58qDJkoTwC
	 DyIOnRiBB5kOwVEK8bsLipfN4BiJSBkcfHZoEFbaWEe59VkV1dejPE0MIxxJ5hQgOW
	 QlDE3SzREZI7HhHpAD/RsmItLcYaSrwAKn2DShmh86PK38mc+dlgyAI6SX//dn9hKO
	 gJ9OuZI0YuL6HhucLKsQ5YTL4fZOHChuPxmcR2d1yU/7R9HS7mx08QolNXexvGCJ4T
	 n/z+miZU7KqwMdbMllTUZfSs6ImA+hDtl6dCxXSbu2ohdG7uRbsi5E4R2Q61Nv8642
	 mpXlWZht9Beiw==
Date: Mon, 2 Nov 2026 14:41:04 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] KEYS: Pin the backing module for struct key_type
Message-ID: <auiE4Iabcbro4LiW@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
 <20261102121518.1197453-3-jarkko@kernel.org>
 <sashiko-outbox-193418@kernel.org>
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
In-Reply-To: <sashiko-outbox-193418@kernel.org>

On Mon, Nov 02, 2026 at 12:32:55PM +0000, sashiko-bot@kernel.org wrote:
> drivers/nvme/common/keyring.c:nvme_keyring_exit() {
> 	unregister_key_type(&nvme_tls_psk_key_type);
> 	key_revoke(nvme_keyring);
> 	key_put(nvme_keyring);
> }
> 
> fs/nfs/nfs4idmap.c:nfs_idmap_quit() {
> 	key_revoke(id_resolver_cache->thread_keyring);
> 	unregister_key_type(&key_type_id_resolver);
> 	unregister_key_type(&key_type_id_resolver_legacy);
> 	put_cred(id_resolver_cache);
> }
> 
> fs/smb/client/cifsacl.c:exit_cifs_idmap() {
> 	key_revoke(root_cred->thread_keyring);
> 	unregister_key_type(&cifs_idmap_key_type);
> 	put_cred(root_cred);
> 	cifs_dbg(FYI, "Unregistered %s key type\n", cifs_idmap_key_type.name);
> }
> 
> net/dns_resolver/dns_key.c:exit_dns_resolver() {
> 	key_revoke(dns_resolver_cache->thread_keyring);
> 	unregister_key_type(&key_type_dns_resolver);
> 	put_cred(dns_resolver_cache);
> }

I did this on purpose to check which sites Sashiko detects so this was
expected outcome.

I'll address all the Sashiko issues and send v2 so that they are out
of the way.

Br, Jarkko
