Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422280;
	b=2xylC4Vz3SXQG9gtoz1X6+PZbXzx7OZTGxd1/EgTuvTsDN7PE1gU1HXsVL+wMgPFxCmr
	 5Zs5WmuKi6wCwJonxPvVCvMJQoWbGJ73NOn24bvyzGJwdn2e2vIo3qxLwwLq8Nz9LJo8H
	 wB4P5GwwxrNmkvYXgmkqWRrV4gEORj83YHEa3vlMbiY2VxAylaksPAb4TqdJhPiFmBq0/
	 lXNa1bPdiHKeBSj1D5u259NJ43VzpRO7zRD0qa82U4wurSFFlowbkFPK5jKp0qq3FvtR7
	 1aIzK9cBFJ7ykq7TF2ihwZTQXdlHlv0zZ6jae1fYvTFGfVArS4cQ3LUL2v8vx9X74JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422280;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=zNvJXzYLug2XZA/bqHgSbxm9D3Vv00AlwD0l7n/RWi4=;
	b=4BHbZG+ZijFKXyEzxO1O/Wi3Yj8fUfPrTJX/S+WCXCPfYXiTLv2tQSDhbsIAJWYYuT3o
	 wO7Avo5TRQzQvuD4FGOu5XaSMxnChI4h3LWKEv51aHomDiucgf5CLTLqTk1cGtwO4DzBe
	 mUQ5Pa8Hux2aB315N85m/X1fdOFJij5QG8Z9uEZ0nzNz68Bd5/m7u5V+Fz7SOfk0BGNjd
	 wkG+NNZaaoVuhYCvP9CV2Zid71B3Sza9yM6xS8kFCQOxW9AEYyVYsjKsLKRvYvg/X8laK
	 I6FvsXOpOdfSPP5Ekjue/b4+sd5mkJfUek12t9xyGNvh/LWyi4J3qZgWMVfZtsrrwTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvgzHUBl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AB88F607F49D;
	Mon, 19 Oct 2026 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvgzHUBl
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CCF921F000C5;
	Mon, 19 Oct 2026 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422279;
	bh=zNvJXzYLug2XZA/bqHgSbxm9D3Vv00AlwD0l7n/RWi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hvgzHUBlbu3YWgsiSHdZK2ril1an75VP36T//MLVgAqaN+nVoGSOaayDXxKwt6xHG
	 yGtBi0O019/laoQkVGPVPQjdjXvxaBPB1B9P1obom79KVXcsFgbySGVNT4oSSdM1z1
	 fWNs2Lt+RNGWj7BTi8hcKJuD2PnnUeB06xI+pXbCF+Y4vYE98uJNx/H0+M7UJgJitH
	 OXZMyJP+myazMzin1TM6Yl5zs0ziE+SrN7fzOgqqkrg2IzGqKuuj4DmBc1Aiu/u/RZ
	 yad/S469zk5K1HT6WX4h1ZB0gX0mwErkH521Ke6a+6n4s8870i2eqv6B/Fskw42AO4
	 qR1Y8yzjq4M0w==
Date: Mon, 19 Oct 2026 18:04:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] keys: Protect the read method check against type removal
Message-ID: <atYxg1rEa5dYM4R5@kernel.org>
References: <pm-key-management-objects-candidate-0010-v5-c6b7ca2813c6913e500a@gmail.com>
 <atQoKlA_JfF6JBmc@kernel.org>
 <atQr3xpmgJc5q_t4@kernel.org>
 <CAFRLqsX70QUKo5mmp-m3BdSr3q1YaqDw98VLQM=Eo72tditWmw@mail.gmail.com>
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
In-Reply-To: <CAFRLqsX70QUKo5mmp-m3BdSr3q1YaqDw98VLQM=Eo72tditWmw@mail.gmail.com>

On Mon, Oct 19, 2026 at 10:50:12PM +0800, Cen Zhang wrote:
> Hi Jarkko,
> 
> Jarkko Sakkinen <jarkko@kernel.org> 于2026年10月18日周日 10:16写道：
> 
> >
> > On Sun, Oct 18, 2026 at 05:00:14AM +0300, Jarkko Sakkinen wrote:
> > > On Sat, Oct 17, 2026 at 03:30:56PM +0800, Cen Zhang wrote:
> > > > The key type must remain alive while its read method is checked.
> > > > keyctl_read_key() holds a reference to the key, but checks
> > > > key->type->read without holding key->sem. The reference keeps the key
> > > > alive, but does not pin the module containing its type.
> > > >
> > > > With AF_RXRPC built as a module, a positive RxRPC key can pass
> > > > key_read_state() and the Read permission or possession checks while
> > > > another task unloads the module. Unload is possible once the module
> > > > refcount reaches zero, e.g. when no RxRPC socket remains open. The
> > > > reader can be delayed between loading key->type and reading its read
> > > > member, allowing this order:
> > > >
> > > >   KEYCTL_READ task                  Module unload and key GC
> > > >   lookup_user_key()
> > > >   key_read_state()
> > > >   key_permission() / is_key_possessed()
> > > >   load key->type
> > > >                                     af_rxrpc_exit()
> > > >                                     unregister_key_type()
> > > >                                     key_gc_keytype() schedules the GC
> > > >                                       pass and waits for it
> > > >                                     GC takes key->sem for writing
> > > >                                     GC retypes key to key_type_dead
> > > >                                     GC releases key->sem
> > > >                                     unregister_key_type() returns
> > > >                                     free_module() frees type storage
> > > >   read saved type's read member
> > > >
> > > > The last access reads freed module storage and can fault in
> > > > keyctl_read_key(). The later read invocation is already protected by
> > > > key->sem and key_validate() in __keyctl_read_key(), but neither covers
> > > > this earlier check.
> > > >
> > > > Take key->sem for reading around the read-method check. The garbage
> > > > collector retypes the key under a write hold on key->sem, so it must
> > > > wait for the check to finish; key_gc_keytype() in turn waits for that
> > > > GC pass before unregister_key_type() returns, so the module text cannot
> > > > be freed until the check has completed. If retyping happens first, the
> > > > check sees key_type_dead, which has no read method. Release the
> > > > semaphore before returning -EOPNOTSUPP or proceeding to buffer
> > > > allocation, preserving the early unsupported-operation result and
> > > > keeping user copies outside the semaphore.
> > > >
> > > > Oops report as below:
> > > >
> > > >     BUG: unable to handle page fault for address: fffffbfff8048bc5
> > > >     #PF: supervisor read access in kernel mode
> > > >     #PF: error_code(0x0000) - not-present page
> > > >     RIP: 0010:keyctl_read_key+0x1aa/0x600
> > > >     Call Trace:
> > > >      __do_sys_keyctl+0x2a7/0x4f0
> > > >
> > > > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > > > Assisted-by: LLM
> > >
> > > Would be better to finish off the work unfinished and fix the patches
> > > under circulation instead of spamming new ones while at it. I.e. fix
> > > them first and don't starvate us with unfinished patches.
> > >
> > > If this was merge ready this would be acceptable, but in this even the
> > > tags above are in the wrong order. This is not a lottery machine where
> > > you dump whatever LLM gives you without your attention, so please don't
> > > do that.
> > >
> > > >
> > > > ---
> > > > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > > > index 5a5efa26ed0e..756368422b7c 100644
> > > > --- a/security/keys/keyctl.c
> > > > +++ b/security/keys/keyctl.c
> > > > @@ -863,10 +863,13 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
> > > >
> > > >     /* the key is probably readable - now try to read it */
> > > >  can_read_key:
> > > > -   if (!key->type->read) {
> > > > -           ret = -EOPNOTSUPP;
> > > > +   down_read(&key->sem);
> > > > +   ret = -EOPNOTSUPP;
> > > > +   if (key->type->read)
> > > > +           ret = 0;
> > > > +   up_read(&key->sem);
> > > > +   if (ret)
> > > >             goto key_put_out;
> > > > -   }
> > > >
> > > >     if (!buffer || !buflen) {
> > > >             /* Get the key length from the read method */
> > >
> > > Why did you chose this over embedding the check inside __keyctl_read_key()?
> > >
> > > I'm assuming you have considered both options.
> >
> > I.e. to reformalize: how does that change guarantee key->type->read
> > validity for the __keyctl_read_key() that follow?
> >
> > My first idea would be put the check inside __keyctl_read_key()
> > while key->sem is taken.
> >
> > Please explain because I'm not fully following with that change.
> > I could get something wrong but it is against the assumed most
> > common sense fix imaginable.
> >
> > Br, Jarkko
> 
> Sadly, I focused too narrowly on protecting the early dereference
> and overlooked the approach you suggested. It does make more
> sense.
> 
> I've removed the outer check in v2 and moved it into __keyctl_read_key(),
> after key_validate() succeeds and while key->sem remains held. The check
> and call now run under the same read hold on key->sem, so GC cannot
> replace key->type between them.
> 
> I've also corrected the trailer order.

Please don't frame ignorance as a problem with focus because this is
ignorance. And there is no "more" here as your fix was plain dead
wrong. You cannot compare a working fix and a code change that
does nothing useful. For me this appears as proxying LLM output
more than anything else. If doing right thing right is a problem
for you, stop sending kernel patches.

I hope this changes the course.

Add my suggested-by tag.

> 
> Best regards,
> Cen Zhang

Br, Jarkko

Br, Jarkko
