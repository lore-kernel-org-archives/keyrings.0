Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319451;
	b=aSJdU9NiOMTmto0usitssQYkdYb/EcDB5rrdbaMnobPSj4o1Hg+V2OG3ARf/G4qdlUnu
	 kY9PSHIq3gmQoZP1bZ4xLDSWsVlErKiIvLMyS7qoSmNbELFVIT9qtyMLg6nuWOMbAi4nh
	 Nw9ZoVZso3hvkCbMI7B3fJuZ/Avj1by0mFDGuKUvOcR65cMqUzI7skZ5Kuu/hLHL6p0fB
	 VC24vZy0tBc226p7ozAq0+v1va46bLoxzNyqtjKWimoFqRM7LmLcolKCIHyT9O1qxkImc
	 yWv5toaP52EmkTUEeZSOJANNzE+qTmH1Wo+8tFgafqZs8xeDPWWDNH0m8p9+YKhLPBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319451;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+8iCaKhWLvjZlGA+HEOn2F+CivOanAUsvMSszQ0gY2Y=;
	b=Ztq5OWpRQ2tmFong+y2tgptj0JaVtq+pnY9WgIGaNtfhg0HHuRIW1kt88o6cUXAtNHEN
	 JFHHyGIJV526TKygRU7eSiPSOuAUbi3/gERMRk/6Olr41q42n6Zt/4E5FB205OK6wYJ9X
	 afKk88c0Ru1o1gwnGhYal2upUrYZ33iT4EYbALz3Gut9lrVwALEbx9Xt0QFXMXc3F7DQK
	 56QwAavvhxrXAh/0wCE6tBl8aIH8DcPh+zAOrFQ/eIzTW9S8I/osmlorF1hUZ6SBOk31u
	 Fzlc/SpNrxQW8d1N49nkwcF5IcAFgvCe1fW0dAJueht5zY075y1lnze9uqnMWDr9Ofg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsJ3xU6+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5C8AD606A31A;
	Fri, 30 Oct 2026 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsJ3xU6+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7C0C01F000C1;
	Fri, 30 Oct 2026 00:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793319451;
	bh=+8iCaKhWLvjZlGA+HEOn2F+CivOanAUsvMSszQ0gY2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LsJ3xU6+WLpIWSkuT3r//ZddfKenrCxbB1QJgl7FoNPwpl8JIFav+RGLBkMiWO7Zd
	 uaTlb0/yeobU2omj5xrc1DCE1QPp8zQO9i0io9w/hwOvEOcKb0O7VBbW7OwKgiTxj6
	 3L5HzJ9Mf7yXcYGWjyNy8PrKajSt5+b/lwyHueI0fUn5H7KN00VHy6HjrP4nSMFDH6
	 RSrUQvjldgtQHkD65Iwj17o8TdSrpi7i4NlTQv9h2AhGGsl3TaPwSFYCKYK2tdaICg
	 6vs+6hKf6OKCowEFIhmPub6PyzO6YYIkFSj+8lNdVznT2PMlVWlOu94DhYhp15kFZY
	 WwJQVs+BPxWiQ==
Date: Fri, 30 Oct 2026 02:17:27 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: Re: [PATCH v5] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auPiF49J5QkIlnP1@kernel.org>
References: <20261029172918.2118600-1-jarkko@kernel.org>
 <20261029234149.218-1-hdanton@sina.com>
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
In-Reply-To: <20261029234149.218-1-hdanton@sina.com>

On Fri, Oct 30, 2026 at 07:41:48AM +0800, Hillf Danton wrote:
> On Thu, 29 Oct 2026 19:29:17 +0200 Jarkko Sakkinen wrote:
> > key_garbage_collector() has a design that is not resistant enough for
> > workqueue lockups. The duration scales up relative to the number of items
> > in the serial tree, which causes a reoccuring theme of being guilty of
> > causing workqueue lockups.
> >
> Given cond_resched() the gc work is not a cpu hog, and given concurrency
> workqueue can get individual cpu highly overloaded in short time, so what
> you delivered is a half backed croissant, HBC, as you failed to make it
> clear why lockup occurs when the number of gc items rockets up.

Please, read:

1. Documentation/process/code-of-conduct-interpretation.rst
2. Documentation/process/code-of-conduct.rst

Br, Jarkko
