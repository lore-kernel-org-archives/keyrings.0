Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75B3B14B2
	for <keyrings@vger.kernel.org>; Thu,  8 Oct 2026 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484921; cv=none; b=boMeDjbIDuRJhXjOZg29dDWXgw2LZ+wOj3PSsPMORRm+7pZK28QLd4OlgdXn5ERY1Hwu3gPyx2dxEWQCYTf8WqflvTNv5LjaaPo+wA+yyM06K2lBBJg6g0uGPKn6VCb8QLU5vJMH/RU4DEWmsfM+7693eC92G29ndKddylRfyyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484921; c=relaxed/simple;
	bh=N34rDJw1QcYA/gTRnyVDP3aU3+QlHxNGYqC4oNSCe0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVB2j3VkIi3FplNHfrAKBt9CI+a8DMkczniYIQvKE8sLi09Rn4wlYSpZ+7MErezRBzoXeLkMIs3UeVJ0rykRkGizbVQaTBjimPhDNen6KrZmsCyYNdFgf047ITyuOHwppeOd004ZJIQNNGur1nQWpTqxDeOsJSPFzA0GNjb7qSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=wRRp0ZQb; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="wRRp0ZQb"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c9995ca60so1086084d50.1
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791484918; x=1792089718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ec5a44X3oISFHgbKkTAE4U1i3Gpy1JGFD3SC5oC7PLk=;
        b=wRRp0ZQbN0M+0QSkgxgyBE8IvATPyNQ/Luju0tYT4HS3F1+3XAclSyAkwaYWzvVkj/
         EHYKQvilxNjUEKBJOqwE9zU+b4Ethe5xSQnJsOWnZEiFszQTCyytcSPPE1CxLsKcgGrq
         biIkKkfZwqkH4mHMb3tCX9hTnMAqbinQUDaRT1s3eeAmFZgvJRpmz1iYRkSZFbjF6Rp5
         hqkmlQACjtOXuQUNUEUUwREOIjLz8T7oLSYnKYSYkOuiyOO3S1CcOInbYafKiZD3gXch
         LxE4YSjTGED6SsCq5f3A1l5j2QJiKZJ34JLo+y+gDYFNWqZemROjFzRMjnMYMfz3Yo4E
         X/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791484918; x=1792089718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ec5a44X3oISFHgbKkTAE4U1i3Gpy1JGFD3SC5oC7PLk=;
        b=BP07uIt1UrhkTpKwJv4d8HiuQeRVQl4GhvZD7eA9lfIa6WcYeRHv/rGjQ+gGWXq2QL
         pJqkjytp/a4/QB3EmjYDEX4d2ClZFMp0e0MogGS/p22Br7jNH5Yg1GdSb3ofytRlyPRx
         xuSq9qdllRhRoyx3fj6nUpDzWNVSfNZxYsT9NsGJeIM6CatGUAhwdzECYygnUOSZDv9X
         7Hv31XKSMRWA/YmKnMNnRMA2VARLzutlzxnEiTLsE3x+i2vv4VpUSG0PYMt1pibXOOei
         7zTvGR+2Z/lRBlxBa+VEAj/sA3ooEuB/4r1b/QtPj6h1dcUzmcy2M5t/UQx0/oeQ8/C2
         ZXyg==
X-Forwarded-Encrypted: i=1; AKwUvByLtjuCLjhhCPZ8XI+MdBGHCFrY7nzCJrADzPW+VoVUdn/4aG+38hmJDBX1+eyxLqIVTVJT782Z2g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIjoGWAXx41snZJAvBhr+gwbE9zXtDrGAx/MizGIfL432RIvs4Q
	36484Wgj1eo9iL6ah7ywb01Yzx3oEUlbH1v88jLt4+qpM9qT5kg4hwja542LjoAbUb5A
X-Gm-Gg: AYBFou0cwFfv6LFH7Y9dfIMJnaYxeiELoZSuoHmUA8j19U5eHCGBQ9WME0C0Kkv3b75
	2uYrkZQPdeuY92fsQ4qQCM4994hvuk0NbLjGl0TSpMS3DmSCIeZpYwBnuyf+unZHZS1JilSM2co
	NZXO85Sy04XTUuAgrqKeDE06IvWp9+4QMhaaaQA7H0p8H7+pbv5N5AyNHTtnnl4Lpgew32dHo0B
	lU8zdlxj55amuB9bhoFUEIkn9+m5CdJKwjdrHaeS13hcHbcVxinb0YjIwnHRkc1G+uP7dvB376G
	o8F1jdnvpOIyutHjKh76rBArSgQktn1eWQble0jnEOfL5R1vhC6bXSBV8Cg39p39TJ1ryEeiGqZ
	MsPzDj6Fgz03HVjR2g/fb7YeAAuGMSQwNfilJiKxb1TB6LdTOgyU2eQ6TvaWhLe+AVd3PGT0zPL
	lhZtAbHUWV/Z4Mhdm1wjKlvdWpBjzEUnz2vlsdQiTfNcGKSneVbwfh3KC5TfxuSE1/w7zS4gWO4
	pYWCvWd1/fnJT6LA3qvfRXZ2u75WXgd8eHVXlSqHb4=
X-Received: by 2002:a05:690e:c4b:b0:677:b347:9b4e with SMTP id 956f58d0204a3-67922f30f9cmr1364658d50.11.1791484918171;
        Thu, 08 Oct 2026 11:41:58 -0700 (PDT)
Received: from toolbx (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67934e2c25fsm17489d50.19.2026.10.08.11.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:41:57 -0700 (PDT)
Date: Thu, 8 Oct 2026 13:41:55 -0500
From: Andrew Halaney <andrew@amutable.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 1/3] keys: add KEY_SPEC_DM_VERITY_KEYRING
Message-ID: <asfhi1DSO_mhqxWZ@toolbx>
References: <aqyiCavj3xeNqyAo@kernel.org>
 <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
 <20260914-ajhalaney-dmverity-key-identifier-v1-1-01922dc1366a@amutable.com>
 <715249.1789718726@warthog.procyon.org.uk>
 <aq2VxlttdlTNlHo6@toolbx>
 <arYzQN1ViuiCBemo@kernel.org>
 <asZlNEFdvidvMdJ5@toolbx>
 <asfT-SLkty5DC_Rx@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asfT-SLkty5DC_Rx@kernel.org>

On Thu, Oct 08, 2026 at 08:33:45PM +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 07, 2026 at 10:30:14AM -0500, Andrew Halaney wrote:
> > On Fri, Sep 25, 2026 at 11:39:28AM +0300, Jarkko Sakkinen wrote:
> > > On Fri, Sep 18, 2026 at 02:59:49PM -0500, Andrew Halaney wrote:
> > > > On Fri, Sep 18, 2026 at 09:05:26AM +0100, David Howells wrote:
> > > > > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > 
> > > > > > This is great for discussion but what we want for the commit message
> > > > > > is just motivation and resolution.
> > > > > 
> > > > > Actually, I think it's useful that Andrew wrote up the issues in the commit
> > > > > message - and I think it shows part of the motivation.  The 'writing a fake
> > > > > /proc/keys line in the description' is something I hadn't considered.
> > > > 
> > > > I'll defer to what you all want in the message here, I found it valuable
> > > > but I trend on the side of overly verbose admittedly!
> > > > 
> > > > > 
> > > > > > I don't think we need all this just to say that /proc/keys in a racy
> > > > > > query mechanism for production, which is an issue for dm-verity, given
> > > > > > that nothing else is available.
> > > > > 
> > > > > I think at some point, we will need a system call to search all for all
> > > > > accessible keys matching certain criteria by actually walking the key
> > > > > database.  The problem there is that there may be multiple hits, so we may
> > > > > need something like:
> > > > > 
> > > > > 	int count = find_key(key_serial_t start_id,
> > > > > 			     const char *type, const char *desc_prefix,
> > > > > 			     key_serial_t *results, size_t results_size,
> > > > > 			     unsigned int flags);
> > > > > 
> > > > > Allowing you to do:
> > > > > 
> > > > > 	key_serial_t dm_key;
> > > > > 	int n = find_key(0, "keyring", ".dm_verity", &dm_key, 1,
> > > > > 			 FIND_KEY_EXACT_DESC);
> > > > > 
> > > > > This wouldn't be as fast as a direct lookup since it would have to walk the
> > > > > key tree, doing name comparisons and perm checks on each key of the type.
> > > > > 
> > > > > > And secondly special keys are meant for implicit keyrings so isn't
> > > > > > that all there's to it?
> > > > > 
> > > > > I have no particular objection to setting aside a block of negative key IDs
> > > > > for special keyrings that need to be accessed a lot - though I would make
> > > > > common reg/unreg functions that take the ID to be registered and, say, set the
> > > > > block at -257..-512.  Moving the BFP keyring to -257 and DM to -258.
> > > > 
> > > > To be clear are you suggesting I do that for v2 here? Happy to make the
> > > > change and add some reuse to the registration functions, etc. I'm
> > > > guessing its fine to change the bpf id since its still only in -next?
> > > > 
> > > > The only awkward bit with making that more generic is that dm-verity
> > > > isn't __ro_after_init since its coming from a module possibly, and
> > > > because of the module usage I also protected it with a spinlock in case
> > > > someone's accessing it while you unload the module. Could just use one
> > > > spinlock for the whole generic array, and drop the __ro_after_init I
> > > > suppose.
> > > > 
> > > > Let me know if I'm not following properly!
> > > 
> > > I just read David's response and I think he made fair arguments,
> > > and patches look fine to me.
> > > 
> > > David, did you have anything? I could pick these.
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > 
> > Gentle ping :)
> 
> Understandable :-)
> 
> > 
> > Are we happy with these to get picked up?
> 
> Can you just do a resend that applies on top of latest mainline
> or my tree? I.e. b4 shazam was not happy about this.
> 
> Full log:
> 
> $ b4 shazam https://lore.kernel.org/keyrings/20260914-ajhalaney-dmverity-key-identifier-v1-2-01922dc1366a@amutable.com/
> Grabbing thread from lore.kernel.org/all/20260914-ajhalaney-dmverity-key-identifier-v1-2-01922dc1366a@amutable.com/t.mbox.gz
> 
> Breaking thread to remove parents of 20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 10 messages in the thread
> Analyzing 0 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>   ✗ [PATCH 1/3] keys: add KEY_SPEC_DM_VERITY_KEYRING
>     + Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org> (✓ DKIM/kernel.org)
>     + Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org> (✓ DKIM/kernel.org)
>   ✗ [PATCH 2/3] keys: add KEY_SPEC_FS_VERITY_KEYRING
>     + Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org> (✓ DKIM/kernel.org)
>   ✗ [PATCH 3/3] Documentation: keys: document IDs added since KEY_SPEC_REQKEY_AUTH_KEY
>     + Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org> (✓ DKIM/kernel.org)
>   ---
>   ✗ BADSIG: DKIM/amutable-com.20251104.gappssmtp.com
> ---
> Total patches: 3
> ---
>  Base: base-commit 1a1de54f7369cd2b5bac0f265910e60ad3a6b4c3 not known, ignoring
> Applying: keys: add KEY_SPEC_DM_VERITY_KEYRING
> Patch failed at 0001 keys: add KEY_SPEC_DM_VERITY_KEYRING
> error: patch failed: include/linux/key.h:441
> error: include/linux/key.h: patch does not apply
> error: patch failed: include/uapi/linux/keyctl.h:25
> error: include/uapi/linux/keyctl.h: patch does not apply
> error: patch failed: security/keys/process_keys.c:25
> error: security/keys/process_keys.c: patch does not apply
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"

Egh, sorry I was on linux-next. I'm also realizing that the
KEY_SPEC_BPF_KEYRING bit this sort of depends on is only in bpf-next
(i.e. 264d8fd2794f ("bpf, keys: Add a bpf keyring for program signature validation")).
Otherwise as is this conflicts on mainline and we'd just have to skip
the -9 the bpf keyring is using at the moment.

Should I just base on bpf-next that and send thru there instead? I can't recall
how kernel maintainers typically handle this other than cutting a stable
branch that both subsystems pull from, etc.

Thanks,
Andrew
