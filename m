Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE03A05F5;
	Thu, 21 May 2026 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407536; cv=none; b=t2RhPII0pAl0/GLgOV3nmdeu/bZJkzn8gTONe5e2IzrVhSXXT21sfYL9G05aCajr+BwQ6ozeOxifrT9Mf4LjjASJAHGCOmjpyOwQlzcU7eEcn8EI1dDsfJVNGvzYr5lRZF6fHcCOAs9n9B/GBvrnStt+KI+vgrPf4teusDb3IcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407536; c=relaxed/simple;
	bh=tz3ezQBVDltP1kB3kwmcDAkU1eDO8kgyzTCLUyyi9c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPFhGmpYoqMbcgM7oq0ZYL4WMXYPUNKNjyap2c1ORSjK484AHppUMBL6It7cyQ6xGLINT1UlziO1ZFmGX9UyR+oy0z8YnPaaqcG4mP5Jjq4GJ7S7vH2CUevIwHfhM2kQLpPkGYyxh3fFGGDO5aTphJD7KDY42tQMSOZ644wpcIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjUP4IWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjUP4IWN"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0A4E21F000E9;
	Thu, 21 May 2026 23:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779407527;
	bh=OjHPZWUTTpJlkidgtJaarjkG4HDrR93m+TvK13ZJYK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GjUP4IWNakKuqZS7d+dA+z8T73VsVl4Ozs13Z9aedz0XHp1k47ATPWsEkdI2btEed
	 ERfYKSpl/SC7g43BJM1zurLObDTvIPDKzG3vnBfXHjPgiSWNeTXAuvwkph7/XRbi2e
	 0aalYtcRoKeIKhKLYpmhQ9XPpz+S+6OtIq1IXUNHoYpRvK3LYKw+qDP4J2UOyvzSZa
	 3r/AGHVTn4cKh6+AcStMkPGAR/QrnLdR2cyLf2kud8FITjCxi4g/FMqZjs7AxDOmct
	 sZeAxkYM1EJ+uGx+fRi+nm3myIK+sJ4T39utJ38sHjPW5r+7kzCoUsjA35NyTmnxDn
	 MYF6gUWYaKD0w==
Date: Fri, 22 May 2026 02:52:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shaomin Chen <eeesssooo020@gmail.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [bug report] keys: request_key_auth payload use-after-free in
 keyctl_instantiate_key_common()
Message-ID: <ag-ao2V-mcUqjx53@kernel.org>
References: <20260519144403.436694-1-eeesssooo020@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519144403.436694-1-eeesssooo020@gmail.com>

On Tue, May 19, 2026 at 10:44:03PM +0800, Shaomin Chen wrote:
> Hi,
> 
> keyctl_instantiate_key_common() can use a stale request_key_auth payload after
> the current request-key authorisation key has been revoked.
> 
> The relevant code pattern is:
> 
> 	rka = instkey->payload.data[0];
> 	...
> 	copy_from_iter_full(payload, plen, from);   /* can fault and sleep */
> 	...
> 	get_instantiation_keyring(ringid, rka, &dest_keyring);
> 	key_instantiate_and_link(rka->target_key, payload, plen,
> 				 dest_keyring, instkey);
> 
> keyctl_instantiate_key_common() does not hold authkey->sem, an RCU read-side
> critical section, or a reference to the request_key_auth payload across the
> sleeping copy and later rka dereferences.
> 
> One race sequence is:
> 
> 	Task A: request-key helper child        Task B: original request_key path
> 	-------------------------------        ---------------------------------
> 	assume request-key authority
> 	enter KEYCTL_INSTANTIATE_IOV
> 	rka = instkey->payload.data[0]
> 	block in copy_from_iter_full()
> 	                                      helper parent instantiates target key
> 	                                      helper returns to kernel
> 	                                      complete_request_key(authkey, 0)
> 	                                      key_revoke(authkey)
> 	                                      request_key_auth_revoke(authkey)
> 	                                      rcu_assign_keypointer(authkey, NULL)
> 	                                      call_rcu(&rka->rcu, ...)
> 	                                      request_key_auth_rcu_disposal()
> 	                                      free_request_key_auth(rka)
> 	resume from copy_from_iter_full()
> 	get_instantiation_keyring(..., rka, ...)
> 	key_instantiate_and_link(rka->target_key, ...)
> 
> I reproduced this on a current upstream v7.1-rc3 based tree,
> HEAD ab5fce87a778c, with KASAN enabled:
> 
> 	BUG: KASAN: slab-use-after-free in keyctl_instantiate_key_common+0x1dc/0x2a0
> 	Read of size 8
> 	Allocated by task:
> 	  request_key_auth_new+0xe0/0x4d0
> 	Freed by task:
> 	  key_revoke+0x62/0xc0
> 	  call_sbin_request_key+0x6cb/0x740
> 
> The reproducer uses a request-key helper that forks a second process with the
> request-key authority.  The second process enters KEYCTL_INSTANTIATE_IOV and
> blocks in copy_from_iter_full() on a user fault after rka has been loaded.  The
> original helper then instantiates the target key and returns, which revokes the
> auth key and queues the request_key_auth payload for RCU freeing.  When the
> blocked instantiate path resumes, it dereferences the stale rka pointer.
> 
> I can provide the reproducer and a candidate patch.
> 
> Regards,
> Shaomin Chen

Please, just send them and we go from there. On surface looks legit.

BR, Jarkko
