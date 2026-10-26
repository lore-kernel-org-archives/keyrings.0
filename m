Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035142;
	b=tRKmYWYtbTp4qLoj0UkPNQ1WD/O/Q/HfDPF6gocmKtHOvKTLUxQ7xYokHDxCtUY/wtsM
	 otJ3DYl3/gLno3HkVnuQVnriJiQDeh9j6RGfuWZ+THRwy5mKRes1nApEmOS7of7NJQcTI
	 FNHWZkGZM25UIgTYKOTFkF3/wDaQHz8++gEIOGbowVpVyw4/oG0VPuE5gP5FwmBHV5D70
	 sCLK1l6MmnT/U917bFC/1fN+k6Qp/HPdpICwmxNYn/87q7uaOPG7AwxNnDbRHTPQFcW+Z
	 j7xhLAhNJ78MS2ib/zJqtN/xznQd78plwJAhBJmyOybMDjUF2F2R6QSqC/pqbqgyvtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035142;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l8bMEcNPhvjptcKgN8vLR2xlKFHLsClSVva+y/l5Pw4=;
	b=xxi+Imyeqr6dngCAFwpygpPlUb0z9eWJl4gVXyJsCzG7quuZ+yaHT3MB1n7FtEWHpVRM
	 SAtpYju3mOBmKLK0tG9BtNh6fhXuUmVfWPh2OFCzITfQqmRCJaoyuAyYiiGa48jssYyro
	 I7UlB18UNSZ9VKCle0Nxj41GFUb3zXYGVJvXtlh3BHjNLS0Y2nVu3zepktawviy7NgDdn
	 cToNOh1JNdDzF9Ce9nNtuGWI9YvObOheelyXb0JzMG/5A3rTDNd9L9jXTQR6uWBlFvpcQ
	 v803jXfgjGdP0s44mqwOtWDqS1kCy2Ij+ZHrVP9NKslGrFOsN2s6u3TTMKtMhBe7H5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9GItIEy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A8FEC606A31A;
	Mon, 26 Oct 2026 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9GItIEy
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A0D1E1F01825;
	Mon, 26 Oct 2026 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793035141;
	bh=l8bMEcNPhvjptcKgN8vLR2xlKFHLsClSVva+y/l5Pw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A9GItIEy+vkwrpu8zgGoEVxbVX+ohYNusbxLszCMhcJ2AgEEM5rPgPqv0qpZ6X/tE
	 hWJ+gM5VcrVsZ1DhRyz1Uv5avLIKBdN3wf3YyME4Qw7MDhZ0FSnwEFo+6X3Nzd+hk5
	 VMVEmgFRrs0TzHs7jRiIEIbN3k0WigbweLd8xDF3QXHm79oJMdIguGctA2PU5Sip4K
	 7QoiIMMC2GqwsR2cfF2gvBDQ9q33TOG8SOlqUPWb4OtxN4ZNSNY4xoC4TxpSAOyMqB
	 it8mF1NhNlMKTVxk1HefEnQuyNP26Z4SQ3CKXJwEc9q01TUFqUplqJp6aXXHq5urtV
	 D8+T5ztipa5DA==
Date: Mon, 26 Oct 2026 19:18:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] KEYS: dispatch key_gc_work to system_wq.
Message-ID: <at-LgXM3BjyfF21u@kernel.org>
References: <20261026031219.2627968-1-jarkko@kernel.org>
 <20261026095609.1220-1-hdanton@sina.com>
 <at-Gbux2IWwF8aqp@kernel.org>
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
In-Reply-To: <at-Gbux2IWwF8aqp@kernel.org>

On Mon, Oct 26, 2026 at 06:57:22PM +0200, Jarkko Sakkinen wrote:
> > --- x/security/keys/gc.c
> > +++ y/security/keys/gc.c
> > @@ -270,9 +270,8 @@ contended:
> >  
> >  maybe_resched:
> >  	if (cursor) {
> > -		cond_resched();
> > -		spin_lock(&key_serial_lock);
> > -		goto continue_scanning;
> > +		schedule_work(&key_gc_work);
> > +		return;
> >  	}

I guess I'll to elaborate my fix and this proposal as you gave feedback
of neither.

What you wanted to respond to my patch other than nitpicking is probably
this sequence:

  key_garbage_collector()
    synchronize_rcu()
      synchronize_rcu_normal()
        wait_for_completion()
          schedule_timeout()
            schedule()

I should have put this to the commit message, and missed also this
detail.

So the way I saw this, which could be wrong, is that the workqueue
lockup would could happen less often as also other threads are scheduled
preemptively in unbounded queue outside critical sections.

What you are doing with early return is at least not right as it 
corrupts the state. So you should supplement that with something
that carries it.

Br, Jarkko
