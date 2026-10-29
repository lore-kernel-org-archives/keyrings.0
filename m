Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305241;
	b=AmXu+HcUZkCIuybKyl5XNFFACVPkgqUT2JxTIkIi/Euj8fPdr2JY/ZjGAeMxdqAB6qzq
	 VtnNwQG26qzV1e1md31BM4XKejEgekURAVldryfQQFv+44mCt6XjHcW7lPqgMTBc6LS2H
	 02QvUwvUm0Ajro/IAVLWV4gMVTlw3+QpcMHy94M6sJrXBxxiRfg7vRtAR3xuEsKoR9WNd
	 FDHbjBR1EC2q2u3MrgT+3CgdBkWsKgLR02KZGGqW6oI0CJr826iBNXe62af5QrCJlN/nO
	 VkgSh/wRvZFAsdK9/yqyZsz2Q4DXSUaaTg1CXRu4EammTwlFsmUgByun3I8ZW+unkXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305241;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U/imhgL3s0YOuwcaEGKlLp6a6VfkOf+aLy6OJcSOwz4=;
	b=SdeWYf1aZ3mYllUZZXil3ZUEgpbZpT17uSVuBmzO/87rkGpDCSkW0GjuN4gPzx/c/BsK
	 aduGIEkzBrVxtP6SKg0FFUGmw4kPKwus7Om4t5HF7wxhYdmox1Jn73wcWPSAi3Kff/wOB
	 q4EProiIbD4P/vRyGWp3/wfdqPH82ctWcy0jp3/3jLVHzmmAbgeSoa+nz1ebsbVP/oFuZ
	 cNjIorpE20EGiC/wcN++h2om9TfX9tcEh28DLrCm1wKnC6ziMl13PIVQ69PVy0HNTX9xX
	 8lq2dLvQlxGn8WhSkzdJQB0m2ZhgWF42ulJXBMDivHOfG/8iTLz79yEcnt9yDaKMJrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZScD7Fl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D8B4F606A31A;
	Thu, 29 Oct 2026 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZScD7Fl
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D58D31F01816;
	Thu, 29 Oct 2026 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793305240;
	bh=U/imhgL3s0YOuwcaEGKlLp6a6VfkOf+aLy6OJcSOwz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XZScD7FlUENX1XQWfKoSFCL6iN9YexYS+7MID07kZ0qR3SFyHsFcr73J1xH8yZY78
	 aRD+8wcuikPolXZkquGl3uCRW2VZsYWWWI7dNv+aFW5ng7ghIwm8zVyz46E1hKch0e
	 MR/UsheIz8jK9pzbOQ1/OcUeD3kbZO9Ffncam7ftTM9ZZ0EjMhtIs67ts+kLKmOVae
	 yMEa0kuGNxVS21VeA89Y5aYto5rZbiT07upUzfIfz2QSczm5chyvep6r5WHG7THomM
	 GxcehHuccwij7FxQBTi06AzCWLiQBVy0dZiyhEJQuPtc5D/P5+nQ/WGB9hHHWhD9cy
	 dWRI0/BTa9uyA==
Date: Thu, 29 Oct 2026 22:20:36 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH v2] keys: Protect the update method check against type
 removal
Message-ID: <auOqlAt45H-tHL1m@kernel.org>
References: <pm-keys-update-type-removal-20261029-v7-e79d113bcff91e140d04@gmail.com>
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
In-Reply-To: <pm-keys-update-type-removal-20261029-v7-e79d113bcff91e140d04@gmail.com>

On Fri, Oct 30, 2026 at 12:07:08AM +0800, Cen Zhang wrote:
> key_update() reads key->type->update, ->def_datalen and ->preparse
> before it takes key->sem. A reference on the key does not pin the
> module that provides its type, so KEYCTL_UPDATE can race with the
> unloading of that module, for example dns_resolver:
> 
>   KEYCTL_UPDATE task                  Module unload and key GC
>   ------------------                  ------------------------
>   keyctl_update_key()
>     key_update()
>       key_permission()
>       load key->type
>                                       exit_dns_resolver()
>                                         unregister_key_type()
>                                           GC: down_write(&key->sem)
>                                           GC: retype to key_type_dead
>                                           GC: up_write(&key->sem)
>                                         unregister_key_type() returns
>                                       free_module()
>       read saved type's update member
> 
> The final access reads freed module memory. With the updating task
> held after the key->type load, it faults:
> 
>   BUG: unable to handle page fault for address: fffffbfff804107f
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:key_update+0x12d/0x550
>   Call Trace:
>    keyctl_update_key+0x6b/0x110
>    __do_sys_keyctl+0x21d/0x4f0
> 
> This is the same problem that commit 925c84e3cc21 ("keys: Protect the
> read method check against type removal") fixed for KEYCTL_READ.
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
> Take key->sem before the first access to key->type and hold it until
> the preparsed payload has been freed. Once a key exists, only the GC
> changes key->type, and it does so with key->sem held for writing.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> Changes in v2:
> - Refine the commit message.
> - Remove the code comment in key_update().
> - Drop the Assisted-by tag.
> 
> Link to v1: https://lore.kernel.org/r/pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com
> 
>  security/keys/key.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index e88548f1a704..994a34a80c29 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -1101,9 +1101,12 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
>  	if (ret < 0)
>  		return ret;
>  
> +	down_write(&key->sem);
> +
>  	/* attempt to update it if supported */
> +	ret = -EOPNOTSUPP;
>  	if (!key->type->update)
> -		return -EOPNOTSUPP;
> +		goto out;
>  
>  	memset(&prep, 0, sizeof(prep));
>  	prep.data = payload;
> @@ -1116,8 +1119,6 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
>  			goto error;
>  	}
>  
> -	down_write(&key->sem);
> -
>  	ret = key->type->update(key, &prep);
>  	if (ret == 0) {
>  		/* Updating a negative key positively instantiates it */
> @@ -1125,11 +1126,11 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
>  		notify_key(key, NOTIFY_KEY_UPDATED, 0);
>  	}
>  
> -	up_write(&key->sem);
> -
>  error:
>  	if (key->type->preparse)
>  		key->type->free_preparse(&prep);

Hmm.. a nitpick but here should be empty line, or at is least common
to have that before the next label.

> +out:
> +	up_write(&key->sem);

And also these labels don't have coherency in naming. Not claiming
there is overall but it would be good to start improving the
situation.

So I think this would add more clarity:

out_free_preparse:
        if (key->type->preparse)
                key->type->free_preparse(&prep);

out:
        up_write(&key->sem);
        return ret;
}
EXPORT_SYMBOL(key_update);

And is more aligned with our defacto conventions.

>  	return ret;
>  }
>  EXPORT_SYMBOL(key_update);
> 
> base-commit: 9a2a4c51dccc3168c3dc949fcbaa360a478fa228
> -- 
> 2.43.0
> 
Br, Jarkko
