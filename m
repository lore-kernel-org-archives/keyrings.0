Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684566;
	b=0Z5QhMV/rYhvj0LN3lolkHlhpwfJfxmQI5bHSLBRU+gDNbFWI48LiksFH+mHvQ209poK
	 hDxsumY3uTiebHSASFRdEs/jIdbf/s24by9/grlYOrqBozHnPdZpPv2ZrpLIWUvqWKi7C
	 8AChDWbHEb4hLM8n5t/gN/ORXda8u7yQkZYT3MXXQigTjNwGPu+kKxfphfq47kRLrZWNW
	 FZBVWOA9B9px/fJI2/cKmmpkbeeaLaZOSwyDxOoDkQTP+QFqBPNeWyQIeuObhGxObi8Qi
	 31KqoEiMJ1sG6RpQoHifahak7s0S26ZwEsvq+ZFY2/zQj31oDNkVFLkXCgyjBNuytfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684566;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LGNVxa0iMY4NIDYebtKpss6fmDs9OiWR3Z/gVaJGgUc=;
	b=HgrXROzcEnimwbFaxptuJxAYcCg4u170DQPWoj5ZX+M9NVHMljnZGRmSF4lbOPy5ihfj
	 cWMFkddP2avNQnd2jAshm7RrmW8u/T0TrKVerLzk4Mi3kvGyvI1NkBo4Xj6d7q7w6lDZH
	 ydUj7IWmML8hnZdhejjJqtCv+mqLSziR857piORCbzFq6cqKXL9sSnbc1Olh1XxvLaTob
	 C5DRF0UZ7OJxzBg3QcWYBrrddmfwO4I9HMGZRiZGR/rOBFvqudR6MMER2PkuxhURKfB4V
	 j/NMbGBSoHzZF4Yl9AzHYK9gdGmWskjaR9m+LkOqWE+L0p9zrqA+sO/eHVQALLdYjDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oy6MvN1V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 763AC606A319;
	Thu, 22 Oct 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oy6MvN1V
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9029C1F01825;
	Thu, 22 Oct 2026 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792684566;
	bh=LGNVxa0iMY4NIDYebtKpss6fmDs9OiWR3Z/gVaJGgUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Oy6MvN1V5V6TVPj4tLNG0neXTXGnMeeNT6gvEXu1sjkBFkdtEQQ7XxSNZScZ83YCX
	 jvGOKP+A82bB5gziA4V+aO0xqNJKiUoNjJQQNl1Z2UFAOkOvsm3xPatvvNwb89Iw70
	 OHkiCT8a8lFkwlrIqKVsj4I0nU7PsqWJn1QKPQUZe2h0BnPIdxo4e7EJ9FiebT93rc
	 OB9qfYsNloeD863tmL8sEKjHvQQMmgyNyRzybXev92to9M581pfzeO0Cz7l4lOY+mG
	 H0oPlikkqQaqjfpwAOf5fvGyk9nuQFnTd958Yxdcs0RiWYWOus6Hr5oLNai4uKaDdd
	 o/7Pnkf3Z5W8w==
Date: Thu, 22 Oct 2026 18:56:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] KEYS: Replace assoc_array with struct
 keyring_index
Message-ID: <atoyEpMNHvTU1utp@kernel.org>
References: <20261016215326.4110064-6-jarkko@kernel.org>
 <20261016215326.4110064-1-jarkko@kernel.org>
 <2608630.1792422168@warthog.procyon.org.uk>
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
In-Reply-To: <2608630.1792422168@warthog.procyon.org.uk>

On Mon, Oct 19, 2026 at 04:02:48PM +0100, David Howells wrote:
> Please don't put this in keyring_link.  It's only needed by __key_link() and
> friends and could be passed around in a context struct as the edit script is
> done now:
> 
> 	struct keyring_link_context {
> 		struct keyring_link *spare;	/* Spare link block */
> 		struct keyring_link *replace;	/* Link being replaced */
> 	};
> 
> then:
> 
> 	 int __key_link_begin(struct key *keyring,
> 			     const struct keyring_index_key *index_key,
> 	-		     struct assoc_array_edit **_edit)
> 	+		     struct keyring_link_context **_edit)

Hmm... I think it would be more transparent to pass two element array
than declare a struct here. It does not do a lot and makes the code
just require more cross-referencing.

I'm not fighting over this detail but even when I look at the patch
the struct makes it more confusing to proof-read.

Br, Jarkko
