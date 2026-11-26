Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720039;
	b=dtSx3CXDiwui/6+ntlR63e+WLXX6h1xjzvLJtF1rtLUWgZfnOaDjuJ6DGGgk1Jo69Wu6
	 DkzlPGiKqx4M4I46WjHiIdTuZUx3pHyOIRtrfAHKSmgnvRCIDs83rQ+qHKhGqrls98aBA
	 a1LzuOYUadHTYOsWIWDQF09ZAe4THGPFEt4UXd0DwviG8VBv7Om3QOf0nhtMWSpKWgAZs
	 KAXkCyg64lK4bxCOH37ivKObAnicR8H4Y21KbGLSuWYCZUvINiHbfT75dJcb5fStiPePF
	 G62lNEe8LGAwfmSOwmaZZ3At6svwgrxHTjgKiXrPOPbgUZvrLSBQfRhEvM7OsuWNGOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720039;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gXeHFtoydO5kiKH4Q56bSoQUO9PGk5t1t8y/vw5PBLY=;
	b=rnu7uHI2f+tOFD4wNd6X8Ghhr0YuBgKaaaOfT0ocR7RmpP5OZhcVRHLWOOz29YJohuTY
	 PSv+nQs1fw53iiNCqNQ6PfVAsCGfBD6prhMLASY5dbRnSEBhkP0wIuiqHoZt1Dbpcb32Y
	 tYYIRF7jkbSTbr6Mz55ntNFyXIhXbi2jg9KnWfw01XrZAhF1JndfF1Ax5Sr/jtUm8YWK+
	 c7WeIntK0TutK0B3c01Ux3E5GdkiAv/1aPQM/Ikt15rgljK5Dze7uQPY2Hh4grNINz6Ty
	 6cRCLBJxbC9/Y401hMD/k0u9bMWN5SkyQ55qVjdW5G+JWuc2JbrzJ8jfhBnqC/I04UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a5PW/+S8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id CCE97606A31C;
	Thu, 26 Nov 2026 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5PW/+S8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7003D1F000CA;
	Thu, 26 Nov 2026 19:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795720039;
	bh=gXeHFtoydO5kiKH4Q56bSoQUO9PGk5t1t8y/vw5PBLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a5PW/+S8Kb2RKqpTLSsTp+8iuZwaDBsBJ9sN66XZHE5TIsJC+F8gsf/cd2kVwWKNs
	 qGTz5UlDaFAd8rfqOBjyIta19gvetvUYFYtjXv8APWIiZ5OduN6P7hbXDA/7kA2dzi
	 jT46mioMYv3hCq7D5sJtGTGrSZLoxY3c91sT5QZb7P/ewY1UxPs5m+o5gDOgAPdc9L
	 IUP0Y+BP7XZI3I9iKjQoiUX6o7i6cKsNJG6fE8Y6H2gtJgH542Z5mHFHyyRZnZcJ5y
	 6Ft+BEawL0VyByMNkRadVChzMyqEbOePzlSOnPHIKXBEepK7oKsqtRVg9mmqZ5mzjA
	 wVhAQxV812H6A==
Date: Thu, 26 Nov 2026 21:07:15 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Zhenwen Liang <zhenwenliang@google.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: KEYS: encrypted: encrypted_rcu_free() callbacks can outlive the
 module
Message-ID: <awiDY0d9pRUzkV4Z@kernel.org>
References: <20261126023538.4160950-1-zhenwenliang@google.com>
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
In-Reply-To: <20261126023538.4160950-1-zhenwenliang@google.com>

On Thu, Nov 26, 2026 at 02:35:38AM +0000, Zhenwen Liang wrote:
> Hi,
> 
> encrypted_update() replaces the payload and frees the old one with
> 
>     rcu_assign_keypointer(key, new_epayload);
>     call_rcu(&epayload->rcu, encrypted_rcu_free);
> 
> (security/keys/encrypted-keys/encrypted.c:898-899 on mainline
> ebb7a8dc1e74), but the module exit path does not wait for those
> callbacks:
> 
>     static void __exit cleanup_encrypted(void)
>     {
>             unregister_key_type(&key_type_encrypted);
>     }
> 
> When ENCRYPTED_KEYS=m, an encrypted_rcu_free() callback queued by a
> recent KEYCTL_UPDATE can therefore still be pending when
> encrypted-keys.ko is unloaded. The RCU core later calls a function in
> freed module text. unregister_key_type() garbage-collects the keys of
> the type but, as far as I can see, nothing on that path waits for
> already-queued call_rcu() callbacks (synchronize_rcu() is not enough for
> that).

This will be ultimately addressed by:

https://lore.kernel.org/keyrings/20261112040242.247168-1-jarkko@kernel.org/

As then operations will be always drained.

It's actually somewhat tedious to address this particular issue without
this type of architectural change but I'm open for fixes.

Just giving that as a point of reflection.

> 
> Sequence:
>   1. a user who owns an encrypted key runs KEYCTL_UPDATE
>      ("update <new master>"), which queues encrypted_rcu_free();
>   2. before a grace period ends and the callback runs, root removes the
>      module (no dependent module loaded);
>   3. the callback runs from freed module memory.
> 
> The usual fix for this pattern is an rcu_barrier() in
> cleanup_encrypted() after unregister_key_type(). trusted_core.c uses the
> same call_rcu() pattern in trusted_update(); I have not checked its exit
> path in detail.
> 
> Affected: the call_rcu() in encrypted_update() has been there since the
> encrypted-keys code was moved to its own directory (61cf45d01990, 2011);
> the code is unchanged in mainline ebb7a8dc1e74 and next-20261125.
> Trigger: needs root to unload the module; queueing the callback needs
> only a key owner. Impact: use-after-free of module text, i.e. a crash or
> execution of reused memory, in a narrow window after the unload.
> 
> Found by a formal analysis tool we are developing that uses AI
> assistance; I have reviewed the analysis and this report. The tool runs
> verbatim copies of the kernel functions with stubs for the rest of the
> kernel; it found the interleaving above, and the interleaving was
> replayed natively on that harness under the tool's schedule. Functions
> involved: encrypted_update(), encrypted_rcu_free(), cleanup_encrypted()
> (RCU core and module unloading stubbed). It has not been reproduced on a
> booted kernel.
> 
> Thanks,
> Zhenwen Liang

I think the issue is legit.

Br, Jarkko
