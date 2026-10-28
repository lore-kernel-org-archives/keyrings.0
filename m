Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793160236;
	b=WEOmtssAC56F3/yhV/1tVj+scBjwClR1blNe5vnWbfWhsWa01rDHSaJgCPEjIJsSR4a5
	 sFNR3bVSesDYepChuB2FhSVcwk8H+oxx9/UtILHqlrS+nvGTFT4RfvwAtw4HEPgVOY7zK
	 t8w7izVL76wuzyL0IEBtyyvITL8jJD49qS9L6CclMUw/w1S5kXblG2HzlwykuqJ1rdfe/
	 zgVXruUL+K9ZbmH8/zjCGs1JQlHlUP/iiTIHNNHujKVui73OO20rJZ4YpeIJ3wtjkHkM/
	 UtYOw9hi6bjjnGIutqlhACyyCS1Ym9EEtXpkmwsblJdy0KIhN/JyVt6G0+EfqdkunSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793160236;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u0sTh+6h3mu4QOUF72ooz3nZuozs9o3nOF4le7VCAn4=;
	b=hKAw100erLjuuy++Wc0O3uynghwEI8ZSx0axfxfGH8wKYWl+wz2ahxo8+iCh6il2lwiJ
	 zEhSHYgiP2ZcLA5acpx0M5kcdQK3tOHfwcda3IMv7Kbk1IqSERAW9rwGIFKs1mbx/mplI
	 kC54/JV2kwlvF5yHIwTNPUDBJusSjhfbH1tdLk0+Jy0X0osgyGYICh/Vv+JktHqsFYLf9
	 612XbLWDk7DVpFnLKoDC/75rszYp1NooaDd7+eA5qWzzdiQyXvtj583u0SIibb6NyqDjV
	 kcWEJbJhzwCtce7Ou3Ni9mpO9Ea3cNQEAjCutTzmdwdZXkSLTGZp4gfqWI8DhGnKXPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkP2q8Vn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D89C4606A31A;
	Wed, 28 Oct 2026 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkP2q8Vn
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D52621F01825;
	Wed, 28 Oct 2026 04:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793160235;
	bh=u0sTh+6h3mu4QOUF72ooz3nZuozs9o3nOF4le7VCAn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nkP2q8VnDU2IxFkZvC9gzMTyjiqWUw1eim6JYoAbKafWzHM68Na8YNQPu+sOZ+3td
	 w3LsyJ1KR2jnx1hQ+27lqqWE3RyUTlghhOgOfH/oA952kI8RAKXHoN60wXXn/nYDeR
	 mzfGCRDJu06Rb0w/9K43WTBC6aVLVnYKXrhMi2OXsglljJo86yAJamvoBNHOKPijMC
	 iT5lUu9gTIcrkqdlWUr1SlOJDVuECbAhfhNvcIPapZt7QlfkS8xb5M9YVweMS3ZNg4
	 WRs7eB3SF4BDgXwci8z27l5+fRCxARjZMsG2SV5BgJxB6h64o9FdreS/enbXVnrwtz
	 qo0XmEs4WjRSA==
Date: Wed, 28 Oct 2026 06:03:51 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auF0J8KHQQd9bOrz@kernel.org>
References: <20261028025306.2063007-1-jarkko@kernel.org>
 <auFo3KrYXWq3UKmi@kernel.org>
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
In-Reply-To: <auFo3KrYXWq3UKmi@kernel.org>

On Wed, Oct 28, 2026 at 05:15:44AM +0200, Jarkko Sakkinen wrote:
> On Wed, Oct 28, 2026 at 04:53:04AM +0200, Jarkko Sakkinen wrote:
> > key_garbage_collector() has a design that is not resistant enough for
> > workqueue lockups. The duration scales up relative to the number of items
> > in the serial tree, which causes a reoccuring theme of being guilty of
> > causing workqueue lockups.
> > 
> > Resolve the problem by processing in chunks:
> > 
> > 1. Declare a static variable key_gc_work, which owns the garbage collection
> >    in-flight state, and key_schedule_gc_work() for re-scheduling the work.
> > 2. Define KEY_GC_CHUNK_SIZE, set to 1024 keys, as the bound for the number
> >    of items scanned and destroyed.
> > 3. Define KEY_GC_DESTROYING to mark resume to destruction without repeating
> >    the RCU grace period. Drain the graveyard before advancing key-type
> >    reaping.
> > 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
> >    the continuations.
> > 
> > The following test was performed:
> > 
> > 1. Add 499995 "unused" keys.
> > 2. Add 499994 "expiring" keys i.e., keys with expiration times.
> > 3. Clear the first keyring.
> > 4. Wait for the timeouts expire from the second.
> > 
> > When tested with QEMU using x86-64 and aarch64 (emulated) architectures the
> > elapsed the results were the following:
> > 
> > - x86-64: chunk max: 125 ms, total time increase: 5%
> > - aarch64: chunk max: 235 ms, total time increase: 6%
> > 
> > Tests were performed using a laptop with AMD 4650U (Zen 2 uarch) CPU.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> The big picture here is that e.g., [1] might be a good idea (or might
> not) but it would be a mistake to apply the patch before the data flow
> overall has some sanity in it.
> 
> And with, I think, somewhat pretty modest changes the state has been
> put in a nice box :-) Much better shovelling position I'd say.
> 
> [1] https://lore.kernel.org/keyrings/20261026031219.2627968-1-jarkko@kernel.org/

I'm rewriting the benchmark in C using eBPF probe and make it available
later on. Probably metrics change a bit (i.e., become more accurate) as
it was previously written with bash and perf.

Br, Jarkko
