Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286283;
	b=HJ+ZINIw2RpMfenLY9WMf5ZjqYeLycB5VRood+Lh0ZPv5e29gExGBlu/JN95IOxvTbxD
	 xj+TnsvtfVKos0VqD4d5CHhdFyC5ndS16io6v6kJw3u4yzwDnkeq8Nx/tqJB0UFnPx/XD
	 fq+qrZaBiV23+QU/D00qeagurH6Z+nBBPCgo+xnnZUiyc4vNoHpEHihXHDsNJTJfd4gE5
	 VbuRQL5NG5eIDR2Im40O5Zr3DaEreVR+8/lzVJuO3+8uL7rydj8qQfnbORIMK4V8hCVTW
	 Cdtx1AasNFJSQ45hUWN30qSxpOo+rbrui2r9rc2CW2hzlMZqaPESRE+H9lxW8wBLLKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286283;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=RuqhMejpCTxUcbY4K+pNGmbpnR6NoV1QS3505981Rmg=;
	b=BZyKwqvSNK4EJ0uI5a12jEaE7wDVsk68+59CNqjRva75Uv6qjkUatI80x/I5ikwteYqO
	 GXqlUr2i1XGUr/Q2P1/tVeozdzuMI+8tYeXTOXobM1e+r/zpwtQKvyUx8eoMTlc1Ef6B0
	 S/RzI/k+L3zUR6K8mlvCxdWvhcFYNJX3rG7QDbhFy68WKlcOMQgcSmf1e7LZ0DfGPIZ6Y
	 U/f42ynCxOJ75g8uLVGf4dpm3BtHHld0rgpcURE6VP24McyyQgKMh7htPvBISjNgPoZOx
	 ClTst4kdc5tR84qtBe3hHGo3Ma2IsxSMPEj7NZHdUhCqZRDA4GytKcg8D8C774E/2bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZB54+TM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A95BF606A31C;
	Thu, 29 Oct 2026 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZB54+TM
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B31E31F01825;
	Thu, 29 Oct 2026 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286282;
	bh=RuqhMejpCTxUcbY4K+pNGmbpnR6NoV1QS3505981Rmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BZB54+TMwWlngBpoZx1TNgTrhLo7EdO6maQVqftGvzh37AhVGicYoOY1qMYa0K0Hq
	 piRJrj3U5/HNoW38ixTvthgDlAsgtkAJNXxqnSmAs75rIGTScV34yNwxPfKzcb8hgg
	 HG7A7UloBKKC5APoixn4EtiWhFGHqgZlS9JpwkgT3/e8czf/bpf09Wrd4ZeVARhUER
	 LLl3XWn44gAjYtAiFo9wWQff/CGSsZ3uBq2zZdQA1Gpzn481IPztpBtSiOSLqyvMCN
	 xXK5jt9+3EuFkxAYPBHb40gyAt57nS/z8UCACOCfJIUc+c88nHMOxv4s8Gkps/GuAF
	 V/D6RF1oi2x4g==
Date: Thu, 29 Oct 2026 17:04:38 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] keys: Protect the update method check against type
 removal
Message-ID: <auNghmbNdKLQ2hmH@kernel.org>
References: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>
 <auNGzJIWFt64IMWY@kernel.org>
 <CAFRLqsXdUfqvNyzNpnz=dvgtHrVyRhYoZqt-CQUo98HW7BtNJA@mail.gmail.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFRLqsXdUfqvNyzNpnz=dvgtHrVyRhYoZqt-CQUo98HW7BtNJA@mail.gmail.com>

On Thu, Oct 29, 2026 at 10:04:13PM +0800, Cen Zhang wrote:
> Hi Jarkko,
> 
> Jarkko Sakkinen <jarkko@kernel.org> 于2026年10月29日周四 21:14写道：
> >
> > On Thu, Oct 29, 2026 at 07:58:06PM +0800, Cen Zhang wrote:
> > > key_update() reads key->type->update, ->def_datalen and ->preparse
> > > before it takes key->sem. A reference on the key does not pin the
> > > module that provides its type, so KEYCTL_UPDATE can race with the
> > > unloading of that module, for example dns_resolver:
> > >
> > >   KEYCTL_UPDATE task                  Module unload and key GC
> > >   ------------------                  ------------------------
> > >   keyctl_update_key()
> > >     key_update()
> > >       key_permission()
> > >       load key->type
> > >                                       exit_dns_resolver()
> > >                                         unregister_key_type()
> > >                                           GC: down_write(&key->sem)
> > >                                           GC: retype to key_type_dead
> > >                                           GC: up_write(&key->sem)
> > >                                         unregister_key_type() returns
> > >                                       free_module()
> > >       read saved type's update member
> > >
> > > The final access reads freed module memory. With the updating task
> > > held after the key->type load, it faults:
> > >
> > >   BUG: unable to handle page fault for address: fffffbfff804107f
> > >   #PF: supervisor read access in kernel mode
> > >   RIP: 0010:key_update+0x12d/0x550
> > >   Call Trace:
> > >    keyctl_update_key+0x6b/0x110
> > >    __do_sys_keyctl+0x21d/0x4f0
> > >
> > > This is the same problem that commit 925c84e3cc21 ("keys: Protect the
> > > read method check against type removal") fixed for KEYCTL_READ.
> >
> > This is useful bit, thanks.
> 
> Thanks for the review.
> 
> >
> > >
> > > The encrypted and trusted types can be built as modules and have an
> > > update method. For them there is a second window: the GC can move the
> >
> > How is the second window related to the fact that encrypted and trusted
> > can be built as LKMs and where is "there"?
> >
> > > key to key_type_dead after the method check and before key_update()
> > > takes key->sem. key_update() then calls the NULL update method of
> > > key_type_dead.
> >
> > I don't understand this paragrap overall. Needs a rewrite.
> 
> Sorry for that. Perhaps this wording would be better:
> 
> For dns_resolver, which has no update method, key_update() returns at
> the check, so doing the check with key->sem held would be enough. A
> key type that is built as a module and has an update method, like
> encrypted or trusted, gets past the check. If its module is unloaded
> after the check and before key_update() takes key->sem, the GC has
> already moved the key to key_type_dead, and key_update() calls the
> update method of key_type_dead, which is NULL. So key->sem has to stay
> held from the check until the update is done.
> 
> > >
> > > Assisted-by: LLM
> >
> > Please run checkpatch.pl --strict for the next version.
> 
> Thanks, I see that the Assisted-by tag has been removed from the
> documentation and checkpatch. I will drop it in v2.

Yeah, overall I think this is improving and that's why I'm nitpicking
stuff. What I would wish that if you could hold with any other fixes up
until we've got the previous fully addressed.

I mean submitting a fix trial that is not correct is not a problem
or wrong for that matter. The problem is that if you put stuff out in
volumes with patches in various phases, the odds that fix will land
to the mainline tree rise.

This is exactly what I got pissed of last time. Just wanted to this
clear this one up. Also, you can use that on-hold time to re-check
your unsubmitted patches one more time i.e., do your job better
;-) At leas for me that is something that I want to continuously
improve.

Br, Jarkko

