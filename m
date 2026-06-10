Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EFC1A23A6;
	Wed, 10 Jun 2026 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096480; cv=none; b=CslYzI5WS9GQh1hfE/qsrgxQ3u9LxgLJOl28O/xL4/9bF+J5yg16TGzv2IlIieboZkLGG1I6byX2ZcrSlVsTPC9RIFhh5bgBVWPbMY6fdfGmHAUOCeXi9K6nGnSMOtyNuIbSUVXZnL87AarkRyYAC/2dRh+/410IjRWpL+Jq82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096480; c=relaxed/simple;
	bh=kYUKzXe7qwxFBNr8JYlq1YIOlwZxPajr30dIEbh0KoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAQeBJo5jEMzgRS2m7hkAX0yQNVCP0Og+CvmjZRpSTUeCx7F/9usuNyKqiV6kGU9oeozBuF1/4fK89s/dUX4BCS+H7xewkzaZNpHDMn+OChqg1zDqG3kp+8ias3ib9d/dcH9RbRIXOasS8DH1ZYv2jVAV/l3/6ecO89ilm4Lqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHooxqk1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHooxqk1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4E3381F00893;
	Wed, 10 Jun 2026 13:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781096478;
	bh=RCk+9r2qOucC1OKq56v/0o+i36T4Dq3cgxhmWOdEEmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SHooxqk1kBJs4DgGx6CTJZiWK1mVdSOCRj66EUoC+AmwTcoFKEmGCOS4WNvBU/cuQ
	 PwmUXrKmfairD/ezsukuwTT0iY9KuvpTwjCH4XyDs7F8pLbMRLwXUNIFnhH8pimvhw
	 q0MfDhoHMVz3sxyUfPNiVnyE+UWJ9CdWWd+LA90e+x79tMi8fs/GTiq0PWyX7nYyHw
	 41PUzPOoVgzXrQ6BE8IqclWs2g2EWfH1c0tTEvdaMGSyd1GK+QOe8KE4oYqre74+Vd
	 KC1ufjKjMjHS63ohrP1Qqn4MqJ35g7zGpVoMtt/PkzGcvl0wtI0njRCAQTdJ+BBJ8d
	 wsEh/ljrg2aKA==
Date: Wed, 10 Jun 2026 16:01:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: allow request-key path to be configured via Kconfig
Message-ID: <ailgG5JF6Qu_6v0P@kernel.org>
References: <20260607134928.2832202-1-gary@kernel.org>
 <aiZJ94eugtNHcILD@kernel.org>
 <aiZMT5UYhVDlLVHq@kernel.org>
 <DJ3LJFFPMAOW.QA3EZSAB2S5A@garyguo.net>
 <ailfPUbn8gbUqB1D@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ailfPUbn8gbUqB1D@kernel.org>

On Wed, Jun 10, 2026 at 03:57:37PM +0300, Jarkko Sakkinen wrote:
> On Mon, Jun 08, 2026 at 11:30:06AM +0100, Gary Guo wrote:
> > On Mon Jun 8, 2026 at 5:59 AM BST, Jarkko Sakkinen wrote:
> > > On Mon, Jun 08, 2026 at 07:50:03AM +0300, Jarkko Sakkinen wrote:
> > >> On Sun, Jun 07, 2026 at 02:49:27PM +0100, Gary Guo wrote:
> > >> > From: Gary Guo <gary@garyguo.net>
> > >> > 
> > >> > Some Linux distributions (e.g. NixOS) does not have /sbin present, and they
> > >> > currently carry patches to replace /sbin/request-key to some other path.
> > >> 
> > >> Sorry but no configuration for introducing API divergence.
> > 
> > What is the API divergence here? Distros can already patch the kernel or place a
> > different binary there, so I don't see what's being gained on not allowing to
> > change this with Kconfig.
> 
> There's lot of out-of-tree drivers too that distributions. I'm not
> finding anything usefel in this argument.
> 
> > 
> > Also to note, the actual binary being called can already be swapped out by
> > CONFIG_STATIC_USERMODEHELPER_PATH, although for the NixOS this is not the proper
> > mechanism as it affects coredump too which isn't a fixed path binary in /sbin.
> 
> I have not seen actual uses of CONFIG_STATIC_USERMODEHELPER_PATH. You
> could probably use it with busybox?
> 
> > 
> > This is really just for distros to be able to configure where /sbin is located.
> > Given usr merge and (some distros) bin/sbin merge, the canonical path of
> > request-key binary is very likely not /sbin/request-key anymore, so it seems to
> > make sense to me to allow this to be changed rather than always go through
> > compatibility symlinks.
> 
> I doubt there's a huge demand other than NixOS. Just basing this on that
> no other noise have been made so far.
> 
> > 
> > How about a something like CONFIG_DEFAULT_USERMODEHELPER_PATH which defaults to
> > /sbin, and then request-key uses that concatenated with "/request-key"?
> > 
> > >
> > > Not sure right now but one option might kernel command-line. Then it is
> > > known at run-time, can be signed etc. Compiled value has no identity in
> > > the same way.
> > >
> > > And I don't care if NixOS has such a problem as I've not have any stake
> > > making of those decisions.
> > >
> > > You really should explain why it makes sense to have such feature i.e.,
> > > why is it useful. And if NixOS considered, why is it useful for NixOS.
> > >
> > > This all should be in  the commit message.
> > 
> > Sure, if you need some more detailed explaination on how NixOS works.
> > 
> > NixOS intentionally not use FHS directory paths, so packages refers to their
> > dependencies via cryptographical hashes in rather than fixed paths for build-time
> > known dependencies, and themselves also live in a path with hashes in them (so
> > two different versions of the same package are in different paths). E.g.
> > /nix/store/wjzk0s5dwk0i7swh3rmh1pl10k6v1w6d-keyutils-1.6.3/bin/request-key
> > 
> > The full system is also built as a package with all installed binaries in
> > $pkg/sw/bin, configuration in $pkg/etc, etc.. The current system is symlinked to
> > /run/current-system, and when a new system is activated this symlink is swapped
> > out and therefore all paths are updated atomically. For request-key, this is
> > symlinked to
> > /run/current-system/sw/bin/request-key
> > 
> > NixOS carries a patch which uses this path instead of /sbin (which does not
> > exist on NixOS at all).
> > 
> > The motivation is really "be able to switch /sbin". I feel that all the above are
> > secondary motivations and is too verbose to include in the commit message.
> > 
> > I am not a maintainer for NixOS's kernel; I use NixOS and just want to develop
> > kernel and test out kernel on my machines without having to patch them.
> 
> I don't frankly care how NixOS works per se in details. Scope this into
> message to problem that it addresses.

Not 100% NAK but this does not have "universal logic" embedded into it"

"Distro's use it" is popularity opinion, which has no place over here.
Mastodon, Threads etc. work for that so much better.

Perhaps if the motivation-stimuli-solution type of logics gets carved
crystal clear we can move forward. I.e. you need to work on this. I've
given my feedback for this version, and it is not good enough, sorry.

BR, Jarkko
