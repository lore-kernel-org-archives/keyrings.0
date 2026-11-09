Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187050;
	b=GlNCic7NejNeVuX+4pgFM0OaK8d6HGsPqxI/r09lCmZILXh+CjFkIwHJY+/Q1Kh5oN2K
	 ziJGhw3G8IiLezqHYLgAO/zEPxQr2H8vKfVU211M+3oYtf5XSHVwxDR6ATm0KC9jk1tP5
	 KBqVQamroJIeFu3Y8ID1avX1dh6Net0NNq+ROMW7PuqOQ0bEJAWc0H47H3RxVphY6yk2s
	 smZkGR2FmWS8ajxic3NSEBVwZOW0CHlQMEs4IblmTmV8rlsYx2ke14AiaqQB5lbwQNH68
	 RX5I2ciqG/07o7PH6BqV4Ajm8p9PAE/629q+lm17IiytBmX58eLhil2ifnw/XvIsSnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187050;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=O7oAuRffl/WcNwbNnWZJ10eTnJo2fYptt4ijPp2gFFU=;
	b=Vf6wDVi95A/8PTuZ79u6lwez1gDJQCNVe+flb97zHNzxrdo4Q9M6URrhuEZr9QseyrNT
	 6vk6Jw8dhfq9QgDk4jyf5CWiGHfEqE9cFLH7ho9rDV00SC4W88RCI6W/5PFlN2eF8GJYh
	 hyjVzKX/XcN4x4DlSOWTkP4xnDNIBhj9oF56JjMIzt53yrjXJS/YwTGG/JAvGGr7fc8DA
	 kVYjIPSbV/Q0hsAPor9Sko5DnS0PAey2U6nuCYpQMAUe6QZp4Aou6EynNdKetMYEE50yB
	 IBsjyH3d6qe+pTeYhEr75PFUYWLh5eRoxxO+iyWYkBP0I0+cwY+gtIbZDP71EQPBi/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZK3LVjbQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EFCE1606A31C;
	Mon,  9 Nov 2026 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZK3LVjbQ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2849B1F008A1;
	Mon,  9 Nov 2026 01:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794187049;
	bh=O7oAuRffl/WcNwbNnWZJ10eTnJo2fYptt4ijPp2gFFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZK3LVjbQ1iAxN5zB5JTzI6WO/gapbU41fiZkfgWbkSFH0DCq63Q4LPscFsxLl1LOH
	 yTVxmLpbYum/PiSqRPwcr+Rm5WpmR/clm7qUQa8bgQ+loMwYVlYJTx0hwZfpUHU6+u
	 TyBQQoY46twxuHcHC8/e8LCaGPBfn5DDmxulT48ujwrmXqMqhaDoS3sQdU92Mo1G8Q
	 YtFc+IM8dGJGivkWfIlhGcgjaWNZk0AiIo5q9D4v5RUKtKxsiOhq71hSkbLWO9vXlc
	 N6NNwEukA5krPkItk26iCau5Eb2wG7TNTaLqwaO7bj6TpSywH63jYkLfMT6Ob9YhE8
	 ITym0pRC7m4pw==
Date: Mon, 9 Nov 2026 03:17:25 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: do not let an unmatched key decide the search
 result
Message-ID: <avEfJT6hg-SCr7SN@kernel.org>
References: <20261108131413.12012-2-weiguixiong@bytedance.com>
 <avDG8G-Jl1YsmfCs@kernel.org>
 <451788d5e97cba38274e663d2b7952c593e959be.f77cb812.a801.42ef.9775.d2480a239fa8@bytedance.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <451788d5e97cba38274e663d2b7952c593e959be.f77cb812.a801.42ef.9775.d2480a239fa8@bytedance.com>

On Mon, Nov 09, 2026 at 09:10:08AM +0800, Guixiong Wei wrote:
> 
> > From: "Jarkko Sakkinen"<jarkko@kernel.org>
> > Date:  Mon, Nov 9, 2026, 03:01
> > Subject:  Re: [PATCH] KEYS: do not let an unmatched key decide the search result
> > To: "Guixiong Wei"<weiguixiong@bytedance.com>
> > Cc: "David Howells"<dhowells@redhat.com>, <keyrings@vger.kernel.org>, "Paul Moore"<paul@paul-moore.com>, "James Morris"<jmorris@namei.org>, "Serge E . Hallyn"<serge@hallyn.com>, <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
> > On Sun, Nov 08, 2026 at 09:14:12PM +0800, Guixiong Wei wrote:
> > > KEYCTL_SEARCH returns -ENOKEY, -EKEYREVOKED, or -EKEYEXPIRED for the key
> > > selected by type and description.  keyring_search_iterator() currently
> > > records revoked or expired state before asking the key type whether the key
> > > matches.
> > 
> > I don't understand the "asking the key type or" part here. Please,
> > explain what you mean.
> > 
> I meant calling ctx->match_data.cmp() to check whether a candidate key
> matches the search request. For dns_resolver, this calls
> dns_resolver_cmp() to compare the candidate's description with the
> requested name. I'll make that explicit in v2.
> 
> > > 
> > > Direct lookup visits the indexed description, so that ordering normally
> > 
> > "Direct lookup visits the indexed description"
> > 
> > I don't honestly understand this type of jargon, which is all over the
> > place.
> > 
> I meant that assoc_array_find() looks up a candidate using the requested
> type and description. The dns_resolver search instead walks the keys and
> checks their descriptions using dns_resolver_cmp().
> I'll rewrite the commit message around your foo/bar example.
> 
> > > does not matter.  Iterative lookup visits every key of the requested type,
> > > however.  The in-tree asymmetric id/ex/dn lookups and dns_resolver use this
> > > mode.  A revoked key with a different description can therefore make
> > > KEYCTL_SEARCH return -EKEYREVOKED instead of continuing the search.  It can
> > > also prevent request_key_and_link() from issuing an upcall because that
> > > path only upcalls after -EAGAIN.  An unmatched expired key similarly
> > > pollutes searches that do not set KEYRING_SEARCH_SKIP_EXPIRED; the request
> > > path itself sets that flag.
> > > 
> > > Run the type comparator before recording state errors, so only a key that
> > > matches the caller's criterion can decide the search result.
> > 
> > 
> > Can you describe instead describe the what goes wrong with an example,
> > which does not require much effort:
> > 
> >         keyctl new_session >/dev/null
> >         A=$(printf '127.0.0.1\0' | keyctl padd dns_resolver foo @s)
> >         keyctl revoke "$A"
> >         keyctl search @s dns_resolver bar
> > 
> > Results:
> > 
> >         keyctl_search: Key has been revoked
> > 
> Thanks for the reproducer. The expected result is -ENOKEY because "bar"
> is absent.
> 
> When the search encounters "foo", keyring_search_iterator() sets
> ctx->result to -EKEYREVOKED and skips that candidate before calling
> dns_resolver_cmp(). It therefore never checks whether "foo" matches
> "bar".
> 
> The walk continues, but in this example it finishes with ctx->result
> still set to -EKEYREVOKED. My wording "instead of continuing the search"
> was inaccurate.
> 
> The patch moves the match check before the state checks, so "foo" is
> skipped without changing ctx->result.
> 
> > This example alone is not of course enough because it is lacking
> > explanation what goes wrong, which is neither clearly described by
> > the commit message but you could add my reported-by because at
> > least I constructe a real bug report that justifies this fix.
> Thanks, I will add your Reported-by.

Yeah, just sorting things out in proper order :-) Do those changes for
v2 and this should be good to go.

Br, Jarkko
