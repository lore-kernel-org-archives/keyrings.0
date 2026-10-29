Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279697;
	b=1GhHjc4D3FtXoURXU09Q5nZxdwJxEuhTIcMD8MuxqUQpKZf3eqOaYPQuNqOEZlA2RyXf
	 56IKUs1Yc1xu/ZurKcBcoalMbqGBz2KXf9h0NL6q/JZ79eRFWTIzu3MtzA+S2xEvMwF1z
	 YkmhQrj3pujH7e60+C3z6Uu8FHB2nJcNlUFoPug7BKIbCJvAKH7puHckTWZQk8v2iokVP
	 JiunsZhImG8Nku8reMjZuTnPnrkmJ2V7U2ILVhz+oxU16ng1DS2ruyx1r/w9BRKTbdDhv
	 omLXgIVOnBm7stEBUFNt3VAGCKv0/klSVA6Pz2JiiGMTo3Y2e6viofn6h17lGQf98Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279697;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IlrVOpwJaTGTlDuUwqeTHk9QESdPLeKpM6jhbtM0OEU=;
	b=S5Xn1+2+PAsNCE9JUMOa+w3XDsxSVHsxxkXWxI1JEtbkp6d1CsyC64pyP+nQ9T/2yJH0
	 PLaPOESwoM7CRzmdpjSszdFy2DsXwvUtxve88MoomAJUneVxTW3ra6JG7oeDziiFb3EGZ
	 awQ96al7EQp+semYEdCcj0/D+Qhq0VV4m3m7ImXAQgNqfjba4/t8Z7pjdAN4YUqjyZIlF
	 RkfGRZEyqjzs58Ao0pAyom7fBz1tiyTDHx3a2olq9o1YSqAl9oH2IIcxiSEwaI28nGqs2
	 2/tTPvqSbQWiFlzBPX0z9z3AcGkFoVA4EQ+h3nVL3wc8Ix78bjhf2x5p0GsKPNxgJ/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAUe5cvo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 27AC1606A31A;
	Thu, 29 Oct 2026 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAUe5cvo
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 45FFE1F01825;
	Thu, 29 Oct 2026 13:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279696;
	bh=IlrVOpwJaTGTlDuUwqeTHk9QESdPLeKpM6jhbtM0OEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QAUe5cvo/sqCthYn89K+3BawyDIxpvUAgSF4n1z3ZNl7uihHE9jIERbAohHkgBBCB
	 dDEbRei14KAICkqciQ6QqxZ2+s/6On3euJjrTYjmmz4yEMFx49aP5oBzvqxibO99pB
	 VZcOewrZXsUUF7oA8rVgDT9Sam6R59+g5an++6UeTQOM8XnOULPfbjSAdN76s7RJ5f
	 9GIISGQmG2E0XBK2OjUnFO68O3qXiDAUpNJP7hhZtHUOCIklkhqcN6NiDlED+LMBUa
	 Corl1br2jmylRpXp/Yk+HXiMahi4bEDqa7CnxSUXOunxE4tN+YI5F3Ybm/ihi0CB0h
	 nwCRhznpfhogA==
Date: Thu, 29 Oct 2026 15:14:52 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] keys: Protect the update method check against type
 removal
Message-ID: <auNGzJIWFt64IMWY@kernel.org>
References: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>
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
In-Reply-To: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>

On Thu, Oct 29, 2026 at 07:58:06PM +0800, Cen Zhang wrote:
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

This is useful bit, thanks.

> 
> The encrypted and trusted types can be built as modules and have an
> update method. For them there is a second window: the GC can move the

How is the second window related to the fact that encrypted and trusted
can be built as LKMs and where is "there"?

> key to key_type_dead after the method check and before key_update()
> takes key->sem. key_update() then calls the NULL update method of
> key_type_dead.

I don't understand this paragrap overall. Needs a rewrite.

> 
> Take key->sem before the first access to key->type and hold it until
> the preparsed payload has been freed. Once a key exists, only the GC
> changes key->type, and it does so with key->sem held for writing.

+1

> unregister_key_type() does not return before the GC has done that for
> every key of the type that is still in use, so the type stays valid
> for the whole update. If the GC has already moved the key to
> key_type_dead when key_update() gets key->sem, there is no update
> method and key_update() returns -EOPNOTSUPP.

I don't understand this but the difference to the previous case is that
it would be better to be just deleted.

> 
> Assisted-by: LLM

Please run checkpatch.pl --strict for the next version.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  security/keys/key.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index e88548f1a704..bac2333089fc 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -1101,9 +1101,13 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* the GC cannot change the key's type while we hold the semaphore */

I don't understand this.

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
> @@ -1116,8 +1120,6 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
>  			goto error;
>  	}
>  
> -	down_write(&key->sem);
> -
>  	ret = key->type->update(key, &prep);
>  	if (ret == 0) {
>  		/* Updating a negative key positively instantiates it */
> @@ -1125,11 +1127,11 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
>  		notify_key(key, NOTIFY_KEY_UPDATED, 0);
>  	}
>  
> -	up_write(&key->sem);
> -
>  error:
>  	if (key->type->preparse)
>  		key->type->free_preparse(&prep);
> +out:
> +	up_write(&key->sem);
>  	return ret;
>  }
>  EXPORT_SYMBOL(key_update);
> 
> base-commit: 9a2a4c51dccc3168c3dc949fcbaa360a478fa228
> -- 
> 2.43.0
> 

Br, Jarkko
