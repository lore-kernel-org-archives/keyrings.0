Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7084489895;
	Thu, 20 Aug 2026 21:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787263034; cv=none; b=NrbyuKZjAVPphr8PnjJOvXDBzTJmQTm6cdcOqQKC6IYrXG7qAO5UFYwfi9ECvhMdBlIs3QRfqaCI2kNOjh29B6woVNKeTq7cv8yT1788Q0+pW4AofE6wANM9v01U9KzHT1bbyVpC/Kl5tpgqDSB7OvzbHplylN/D0hcFrYP8qG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787263034; c=relaxed/simple;
	bh=23F7YyS67Gse7RijoUKNenkrDC/HIc2d3A5u7esZF64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAFqTQSlN2YdUPY/vRLuV5Xs8WDD0HEnuvqLL9LTS2FVHE6j5uqqPSAkeEx487OulJJ7G33GpX4keq5GQko9noRNcFosuzhGjxRU+9uQixZEkx80S+ouNxG9HjWvGItfqugGLKVhUN8jPe1OoEjJzJB4mYYVl3mcfiLj8getsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBje6V+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBje6V+c"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DAFCF1F00A3D;
	Thu, 20 Aug 2026 21:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787263032;
	bh=h4A8FG4f2obHCLZmZqNiWnmX7Ou5w37qneUyR7iFCE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NBje6V+cJQyjfLujFH+7r4kk1aa5v9+RUOYEab5hjDP5NDYDCBaQjt9zCOPip1rVU
	 I9eoqaJZQ1BfRuuxQLHX5xVIk6TN8kkX0ZPviu6gmdAtbqoJ7zdmyN6Rx1sDr+YUbg
	 yg0Cz+BvTdeqjW1iyzfpVJeFLb2ZIUb+5wa+2GudhK3f/5KArqsDr5wCftLCyT8byu
	 ebrQoBPBiOE8pZyLaT9EqX1K45sGRT+3cQJ944JN3iT3U28N4r0kNekK63tcygaHkd
	 rwmRYkDa2OvPmLniA1H1/G/EpIppecJAIW0mhRXJe3XrsCeqcVgU5BueQOg5TXp/UE
	 CAeLEYWJWhUPw==
Date: Fri, 21 Aug 2026 00:57:08 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: keys: request_key_auth shows a global pid in /proc/keys across
 pid namespaces
Message-ID: <aod4NDZ2k6L83ecB@kernel.org>
References: <20260809110202.2180410-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809110202.2180410-1-maoyixie.tju@gmail.com>

On Sun, Aug 09, 2026 at 07:02:02PM +0800, Maoyi Xie wrote:
> Hi all,
> 
> I think request_key_auth leaks a global pid into /proc/keys. I would
> appreciate it if you could take a look.
> 
> request_key_auth_describe() prints the requestor's pid:
> 
> 	if (key_is_positive(key))
> 		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka->callout_len);
> 
> rka->pid is current->pid, captured in request_key_auth_new() when the
 auth key is made. It is a raw pid_t in the init pid namespace. But
> /proc/keys is read by whoever opens it, and their pid namespace can
> differ. The uid and gid on that line already go through seq_user_ns(m).
> The pid does not. So a reader in another pid namespace gets a number
> that means nothing there, or worse lands on a different task.
> 
> Not everyone can read the line. The owner uid must map into the reader's
> user namespace, and the reader needs VIEW on the key. The auth key gives
> VIEW to the requestor's own uid and to a possessor. So the reader has to
> be the requestor's uid, in a different pid namespace. That fits a
> sandbox at the same uid, made with unshare, systemd-nspawn or
> bubblewrap. A default Docker container does not hit it, since it hides
> /proc/keys.
> 
> I found this with a static check for ids that reach userspace with no
> namespace translation. I reproduced it in a qemu VM on 7.1-rc1 as a
> normal user, no hardware or kernel changes needed. The reproducer calls
> request_key, then reads /proc/keys from a sibling pid namespace. Before
> the patch it reads the requestor's global pid, which does not exist in
> that namespace. After the patch it reads pid 0, since the requestor has
> no pid there. There is no keyrings selftest in the tree, so this is the
> only test.
> 
> I am happy to send a patch. The raw pid_t cannot be translated later. So
> I stored a struct pid and print it with pid_nr_ns, the way the uid is
> already scoped.
> 
> Thanks,
> Maoyi
> https://maoyixie.com/
> 
> ---
> 
> diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
> index 01e42ee5f4099..464636278c4f8 100644
> --- a/include/keys/request_key_auth-type.h
> +++ b/include/keys/request_key_auth-type.h
> @@ -22,7 +22,7 @@ struct request_key_auth {
>  	const struct cred	*cred;
>  	void			*callout_info;
>  	size_t			callout_len;
> -	pid_t			pid;
> +	struct pid		*pid;
>  	char			op[8];
>  } __randomize_layout;
>  
> diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
> index 282e09d8fa46c..e8d1037526b19 100644
> --- a/security/keys/request_key_auth.c
> +++ b/security/keys/request_key_auth.c
> @@ -13,6 +13,8 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include "internal.h"
> +#include <linux/pid_namespace.h>

#include <linux/pid.h>

> +#include <linux/proc_fs.h>
>  #include <keys/request_key_auth-type.h>
>  
>  static int request_key_auth_preparse(struct key_preparsed_payload *);
> @@ -73,7 +75,10 @@ static void request_key_auth_describe(const struct key *key,
>  	seq_puts(m, "key:");
>  	seq_puts(m, key->description);
>  	if (key_is_positive(key))
> -		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka->callout_len);
> +		seq_printf(m, " pid:%d ci:%zu",
> +			   pid_nr_ns(rka->pid,
> +				     proc_pid_ns(file_inode(m->file)->i_sb)),
> +			   rka->callout_len);
>  }
>  
>  /*
> @@ -113,6 +118,7 @@ static void free_request_key_auth(struct request_key_auth *rka)
>  	if (rka->cred)
>  		put_cred(rka->cred);
>  	kfree(rka->callout_info);
> +	put_pid(rka->pid);
>  	kfree(rka);
>  }
>  
> @@ -226,14 +232,14 @@ struct key *request_key_auth_new(struct key *target, const char *op,
>  
>  		irka = cred->request_key_auth->payload.data[0];
>  		rka->cred = get_cred(irka->cred);
> -		rka->pid = irka->pid;
> +		rka->pid = get_pid(irka->pid);
>  
>  		up_read(&cred->request_key_auth->sem);
>  	}
>  	else {
>  		/* it isn't - use this process as the context */
>  		rka->cred = get_cred(cred);
> -		rka->pid = current->pid;
> +		rka->pid = get_pid(task_pid(current));
>  	}
>  
>  	rka->target_key = key_get(target);

Now I had time to read this with thought.

Please send a path with:

Fixes: 78b7280cce23 ("KEYS: Improve /proc/keys")
Cc: stable@vger.kernel.org # v5.10+

This definitely deserves a formal review process.

BR, Jarkko
