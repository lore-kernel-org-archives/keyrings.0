Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE034AB14;
	Mon,  3 Aug 2026 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773195; cv=none; b=aNc/4zyTbiu/A+AT6FSg5qwmx1KSiULGw4nEU9ULe/QRLw5Q1qM5QLp7lqQ1FW15xd/WhTdgXwmqIVRiQjyHRojBZZys8S3FvOXiJJySIiGopiNr9R9r1b/yOyxmJqdxsmPUSmERSmLseOcP6Wd2G0AcxOaIMPaM1EFAzX3Y+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773195; c=relaxed/simple;
	bh=yGX1L2ORh3cX/j6wF1bxBm4uVx13pn7Qm/tRgj4PiNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPfxO5oho/uLam3dKnt6xVgCVBwpsyXMxpWmlvNvS5goDz4z9S2a63zg953wBQ1VJ+2WlwwnzsC0YC8RzT5AyjEqbkt34xFv89mH+9gQKPCMj9lDIVJgsDVqzgJGWvx5Esuc7bleNQ4trvTiXze6EnvOYC2XKpSDTqajjk74HRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSRdCIoq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSRdCIoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308621F000E9;
	Mon,  3 Aug 2026 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773193;
	bh=ve1KJOPR+r25qUM2ukWeqcygSNCUpeyj5F86GUTctLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nSRdCIoqlW/S2x/wv4+uK31nv5rue8u4kJe9Ax8Hj/eHbwpH8gzkLjXEZgqLfIQKE
	 Low/rlzrcEVS7UyLrSPXA6nCdvYMVb/6NXgJ8yGfMSy/oH6JqKRluqVYwJw57q9s4C
	 W8z9mg2cQN2UD4tg4FwtkcbpghQ0GjY2mylnk1kQvZ8qpmEPQ4QMBUwApDG9xYqe79
	 slEiBaMF83M/p3aP5ueClHWzUHPNb7BxtYFhUi6cH9BBWrXaZsLZpf1aJlrlCHwqMt
	 htNmrWdUqb9YjDCtSNYyc4TowN9xCS1FQn/E6lTH13XLM73tM7OUvSU9VlHzOlcJuq
	 TkprMg/bIbuWA==
Date: Mon, 3 Aug 2026 17:06:27 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH net v5 07/10] afs: Create a server appdata key
Message-ID: <20260803160627.GL51943@horms.kernel.org>
References: <20260729160108.2031453-1-dhowells@redhat.com>
 <20260729160108.2031453-8-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729160108.2031453-8-dhowells@redhat.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260729160108.2031453-2-dhowells@redhat.com?part=7
---
--- Patch [7]: [PATCH net v5 07/10] afs: Create a server appdata key ---
commit 46d1f7800458c15b841827dd597a26f2786367f4
Author: David Howells <dhowells@redhat.com>
Subject: afs: Create a server appdata key

This patch introduces an appdata key for each AFS fileserver the client
communicates with using RxGK. It shifts the responsibility of generating
application data from responding to challenges in the OOB queue to creating
it when setting up the server record.

Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com

> diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
> index 103168c70dd4d..7f08ede12206a 100644
> --- a/fs/afs/cm_security.c
> +++ b/fs/afs/cm_security.c
[ ... ]
> @@ -23,6 +25,236 @@ static int afs_create_yfs_cm_token(struct sk_buff *challenge,
[ ... ]
> +	/* Store the appdata before the key pointer */
> +	smp_store_release(&server->yfs_rxgk_appdata, appdata_key);
> +
> +out_aead:
> +	crypto_free_aead(aead);
> +out_token:
> +	kfree(appdata);

Simon says:

Hi David,

I'm wondering if you could take a look into the issue flagged below.

[Severity: Medium]
Could this leave the plaintext cryptographic callback key (K0) in the slab
cache?

When creating an RxGK appdata key, afs_create_yfs_rxgk_cm_appdata()
allocates a temporary appdata buffer, generates a random cryptographic key
into it, encrypts it, and then frees the temporary buffer using kfree().

Can an unprivileged process or remote attacker who exploits an information leak
recover the plaintext key from the heap and forge RxGK callback connections?
Would kfree_sensitive() be more appropriate here to ensure the buffer is
securely zeroed?

> +out:
> +	return ret;
> +}
> +#endif /* CONFIG_RXGK */
[ ... ]

Simon says: But I don't think we need to consider the pre-existing
            issues flagged below in the context of this patch-set.

I noticed a couple of pre-existing issues while reviewing this code:

> fs/afs/cm_security.c:afs_respond_to_challenge()
>
> 			server = (struct afs_server *)peer_data;
> 			if (!server->cm_rxgk_appdata.data) {

[Severity: Critical]
This is a pre-existing issue, but is it safe to cast and dereference peer_data
here?

When a network CHALLENGE packet arrives and is processed in the OOB queue in
afs_respond_to_challenge(), it reads peer_data and casts it to an afs_server
pointer.

Since the code dereferences this pointer without holding rcu_read_lock() or
taking a reference on the server object, what happens if the server is
concurrently destroyed or updated?

If peer_data is set to 0, this causes a direct NULL dereference. If the
server memory is freed, could this result in a use-after-free triggered by a
remote attacker?


> fs/afs/server.c:afs_lookup_server()
>
> out:
> 	afs_put_addrlist(alist, afs_alist_trace_put_server_create);
> 	if (candidate) {
> 		kfree(rcu_access_pointer(server->endpoint_state));
> 		kfree(candidate);
> 		afs_dec_servers_outstanding(cell->net);
> 	}

[Severity: High]
This isn't a bug introduced by this patch, but could this cleanup path free
the active server's endpoint state?

When two threads concurrently execute afs_lookup_server() for a new server,
one thread installs its candidate and the other receives the installed server.
On the exit path (out:), if candidate is non-null, the second thread
erroneously calls kfree(rcu_access_pointer(server->endpoint_state)) instead
of freeing the candidate's state.

Also, if the first thread fails server creation, it sets server = NULL.
Would accessing server->endpoint_state here then trigger a direct NULL
pointer dereference?
