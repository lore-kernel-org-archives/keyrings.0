Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90ED26B756;
	Wed, 20 May 2026 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292958; cv=none; b=O/rmhA40cpqFh7fFiYr1a2hon8hpqjfh8IT+k2ZgtjQOwVz/kzY7tZt6+KTSV5DNY3UINtszFKa7lU0KrvbdcZl82NWOk9x3ZcdqV4uWpqqCzqfAHxJtSwcAmo2ODU3OBejT+S1+qkBX9jX6WtEGbZBZi9TnWLzLQgCBMDyhw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292958; c=relaxed/simple;
	bh=AtY0GJJwVfndUQFWPnJqYcZDVgByNpAotUryadSop/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eh1wI6O79p+YC1xQySCzg1sSjDXPYYF/eOLr3+GdY9MS1QWXSANbZ8VXF7ep/4qLjAt9/DpZodVJVrMU21+Q14h1cdsjST9PSFvcoN2/Z/UnIUQmaXuYoZjAQWABTN+VBelsCytqiJmBOgDhHlAAwRm4zjYvLAFe1ovRgm1jErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lCrLgjNF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lCrLgjNF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1953D2936;
	Wed, 20 May 2026 09:02:31 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 033F93F632;
	Wed, 20 May 2026 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779292956; bh=AtY0GJJwVfndUQFWPnJqYcZDVgByNpAotUryadSop/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCrLgjNFsVIs1fRYCpAUnl8XxeNQXzyc8rnLssz6yIk4U30W1ro3/TuHxyy3oJMtB
	 tTRkTAOvYpza3I4+1XUpjWsYCGQ7h+lO79ul/gUGF7w6rBUMtwkggJQ5qSBLAyH7Mi
	 4B4R28hvGS9n686RbfBauLTcpEo6otUkNWlbPRe4=
Date: Wed, 20 May 2026 17:02:31 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, ardb@kernel.org,
	jarkko@kernel.org, dhowells@redhat.com, dwmw2@infradead.org,
	serge@hallyn.com, jmorris@namei.org, paul@paul-moore.com,
	sami.mujawar@arm.com, pierre.gondois@arm.com
Subject: Re: [QUESTION] move load_uefi_certs() and keyring initcall to
 earlier initcall
Message-ID: <ag3bF9HbBTVQD/oy@e129823.arm.com>
References: <agXP3ZyE18pAiy77@e129823.arm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agXP3ZyE18pAiy77@e129823.arm.com>

> Hi all,
> 
> Recently, I've found possible module load failure via
> request_module() in device_initcall() for absent of certificate loaded by
> load_uefi_certs() in below exemplary case:
> 
>   - MokListTrustedRT is created.
>   - one module is signed with trust-chain with one cert of MokListRT and
>     contained in initramfs.
>   - loading the above module in device_initcall() get failure since
>     relavent certs didn't loaded yet -- load_uefi_certs() is called at 
>     late_inicall()
> 
> I don't think calling request_module() in the initcall is not a problem
> if it's after root_initcall (from device_initcall) where initrd
> population is requested when I see the commit e7cb072eb988
> ("init/initramfs.c: do unpacking asynchronously").
> 
> IOW, to address this -- signature verification failure for late loading
> of certificates, It seems to movce load_uefi_certs() or other relevant
> init functions requires to move to "rootfs_initcall()".
> 
> Unfortunately, Moving the load_uefi_certs() doesn't seems easy because
> keyring infrastructure is initailised at device_initcall() via
> relevant init functions.
> 
> So, I would like to introduce two initcalls macro which using pre-exist
> initcall macro to address above situation --
> 
>   - keyring_initcall() (which is wrapper of subsys_initcall()).
>   - cert_initcall() (which is wrapper of rootfs_initcall()).
> 
> so that for init functions which initalise keyring infrastructure,
> for example, the function where calls keyring_alloc() like:
>    - system_trusted_keyring_init()
>    - blacklist_init()
>    - machine_keyring_init()
>    - platform_keyring_init()
>    - ima_mok_init()
> 
> to be replaced from device_initcall() to subsys_initcall() with keyring_initcall()
> 
> and for functions which load certificates or late init relevant keyring
> like:
>    - load_system_certificate_list()
>    - load_uefi_certs()
>    - load_powerpc_certs()
>    - load_ipl_certs()
>    - big_key_init()
>    - init_root_keyring()
>    - init_trusted()
>    - init_encrypted()
> 
> to be called from late_initcall() to rootfs_initcall() with cert_initcall().
> 
> Am I missing something, or is there perhaps a better idea?
>

I'd appreciate it if someone could let me know whether I might be
missing something.

Thanks!

-- 
Sincerely,
Yeoreum Yun
