Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E937F002
	for <keyrings@vger.kernel.org>; Fri, 28 Aug 2026 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934207; cv=none; b=CumWhF5WxYJ4rup4pf2EpfKp1CI97HADxfLMvG88/JRrAaG9vfg1dj60gbJCXgQOtd/1ib97UVhKpIcJ8SkY+3KwZcqFAxp5+IWE6OXKSFIjLboHYQrSFcd+3DkLErfreBsdfzdk4lBKqmlEc7lubx5aLS+p0X4SADhF5ih3Kw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934207; c=relaxed/simple;
	bh=EXrA4Rz+Z1SUvLdlK6q1IWLQcN1MltuhMgX8g/P/Pek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH9xDOA2G9bIqCTXu8WA0ebn0p4REFGzihhXHNEDWXETInXovnwojcdy0IQuehfk8UISa2B0rrYkakMaVagyIBM9BL3Uv4tOlCbmK/CI41QmRosrHhx1NiokXiDRF6mvTUpqlQfA8dK/3SJ83XVUxCVXmGki6Y/eBQr7FQOXxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AOTqd3JI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AOTqd3JI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso10372085e9.1
        for <keyrings@vger.kernel.org>; Fri, 28 Aug 2026 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787934204; x=1788539004; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tOG+EsEc4JsO7LPts5VvW3Bv9S3ckFQ6qY35PjmYmcM=;
        b=AOTqd3JI/KyEnUFNpkBIfhzHPcUQS7vXdlHS16jaMf23nl28/q83kR8ueN2FdrgtqE
         bTUQND9vaXLxJWi/QE8FxNqhK35nf+xUEe9M7b26QNolMosWPYLJznGu+AVD46cJ6LHt
         Ypp6V7HFniI3FaDjcOhAyP06u3NxQBkaeXAv0TgwLLpziL03nAy1q93LE+NWFjEDbfPZ
         Q4IoKlz9QIGedqgBUhdErJb3YakO1YOmTxVERFkdWfjyjoajwYnhCK/dEUoiZCmOitfl
         nBbAcNCyOvEZjzpCePDjSi/NG0v7n3EdXNXRhwL8dcNJMmxCuHWnPqfou6FnXeQuG2WA
         nMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787934204; x=1788539004;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tOG+EsEc4JsO7LPts5VvW3Bv9S3ckFQ6qY35PjmYmcM=;
        b=JrlF6rsuyFtmtYhTtYstSqqWjnBwr2EnyNWyap+07O2PavKLTAMoU6tOaXQ6a5nJ4w
         KS7FXCVLiIws6uvzx0TR8tQnPfhiN+9GhST/TcO2o273dhLXaIOJ6YlZkmD3dKkG2wiE
         OLqR/l2lDc4yY0BKiEmHJBBZdcvAq0+20xjioLrDgecsjYEU2etWiJ1d8E9rtQR5CFgM
         AcCNyywWsV1zxGmVJO9X340nteuStkvRM/kWWh4q1buF6TAasXG7iJ4l42RgKWpeKwP8
         JoqpyK5EKY1bBG5sLx0SAgiGCOgFpyJsVjdv9D01B6hYjvlzROjN7hFG9xXp4NYhXMRU
         uvww==
X-Gm-Message-State: AFuF++mHfYLLsaZscsZV/5zWlpuIVD9SIkLQS7TfxQrzTILtFUN265oo
	faI3wns2m7dX8p9AFoA8lFdr3rldnfdeEYNTBeBbatfCX+/sNM4SOq1oMmAOlKkLnlA=
X-Gm-Gg: AR+sD11NPTugYi0jiOWwiLPMG3XA9+vLxfBW2WuVfj8Ao0IiuuVg5R5aX5wcsrYyDLE
	9nUv3D0g+k83tZQQe7ufm/vXtWKkYYPfOjFUV3Maq3t+kKTwrkY5SDgA/LmDu6yR0Rc+OYKf271
	8I48THB1dtLZTSxWg6SWxRiugE3wE79Um5W8fpIuEawbrLIZP7wUJdx4VxY81v9QmO+8ZdgTLD6
	VxEzCoLSvW0042e2YjO2ORdj0VX8vonxFmpJ8vVbQ1LcEAbtyXZtE8bFIHpoJqGnOmkTE5i4JS2
	1mCGAarZF6PpIN/aEF0XaqJc2amILXydglPhIfmaB0GK0qH3T9V0vh+OHvKzj+p4zUE/4ZHbZXi
	RoqhlfPwEkZ5suB0+1EaOaDJX51f6iH61Clqq5KKYkVr+2JhjSKodLeatVU/1euow4r64W3vfi7
	hatdxdvH5F8c1xy0FCQToVtnqFl2cWgc6udhsxnQqXOZealUJipA==
X-Received: by 2002:a05:600c:1c0d:b0:499:a5fc:207e with SMTP id 5b1f17b1804b1-49b91c338dcmr144866675e9.8.1787934203825;
        Fri, 28 Aug 2026 09:23:23 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d38207sm7074939c88.5.2026.08.28.09.23.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2026 09:23:22 -0700 (PDT)
Date: Sat, 29 Aug 2026 00:23:16 +0800
From: joeyli <jlee@suse.com>
To: Shaomin Chen <eeesssooo020@gmail.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, jlee@suse.com
Subject: Re: [PATCH] keys: Pin request_key_auth payload in instantiate paths
Message-ID: <20260828162316.GO6169@linux-l9pv.suse>
References: <20260526024838.3368409-1-eeesssooo020@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526024838.3368409-1-eeesssooo020@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Shaomin, 

On Tue, May 26, 2026 at 10:48:38AM +0800, Shaomin Chen wrote:
> keyctl_instantiate_key_common() reads request_key_auth from the assumed
> auth key before copying an instantiation payload from userspace.  The copy
> can fault and sleep.  If the request completes and revokes the auth key in
> that window, the auth payload can be detached and freed before the
> instantiate path uses it again.
> 
> A request-key helper reproducer can trigger this race.  One helper child
> blocks in KEYCTL_INSTANTIATE_IOV while the original helper instantiates the
> requested key and returns.  KASAN then reports a use-after-free from the
> stale request_key_auth payload in keyctl_instantiate_key_common().
> 
> Give request_key_auth payloads a refcount.  Take a payload reference while
> authkey->sem stabilizes the payload and revocation state.  Hold that
> reference across the instantiate and reject paths.  Drop the auth key
> owning reference from revoke and destroy.
> 
> Reported-by: Shaomin Chen <eeesssooo020@gmail.com>
> Closes: https://lore.kernel.org/r/20260519144403.436694-1-eeesssooo020@gmail.com
> Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
> ---
>  include/keys/request_key_auth-type.h |  2 ++
>  security/keys/internal.h             |  2 ++
>  security/keys/keyctl.c               | 24 +++++++++++++++-----
>  security/keys/request_key_auth.c     | 33 ++++++++++++++++++++++++++--
>  4 files changed, 53 insertions(+), 8 deletions(-)
> 
> diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
> index 36b89a933310..01e42ee5f409 100644
> --- a/include/keys/request_key_auth-type.h
> +++ b/include/keys/request_key_auth-type.h
> @@ -9,12 +9,14 @@
>  #define _KEYS_REQUEST_KEY_AUTH_TYPE_H
>  
>  #include <linux/key.h>
> +#include <linux/refcount.h>
>  
>  /*
>   * Authorisation record for request_key().
>   */
>  struct request_key_auth {
>  	struct rcu_head		rcu;
> +	refcount_t		usage;
>  	struct key		*target_key;
>  	struct key		*dest_keyring;
>  	const struct cred	*cred;
[...snip]
> diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
> index a7d7538c1f70..282e09d8fa46 100644
> --- a/security/keys/request_key_auth.c
> +++ b/security/keys/request_key_auth.c
> @@ -23,6 +23,7 @@ static void request_key_auth_describe(const struct key *, struct seq_file *);
>  static void request_key_auth_revoke(struct key *);
>  static void request_key_auth_destroy(struct key *);
>  static long request_key_auth_read(const struct key *, char *, size_t);
> +static void request_key_auth_rcu_disposal(struct rcu_head *);
[...snip]
> +
> +void request_key_auth_put(struct request_key_auth *rka)
> +{
> +	if (rka && refcount_dec_and_test(&rka->usage))
> +		call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
> +}
> +
[...snip]
>  
>  /*
> @@ -150,7 +178,7 @@ static void request_key_auth_destroy(struct key *key)
>  	kenter("{%d}", key->serial);
>  	if (rka) {
>  		rcu_assign_keypointer(key, NULL);
> -		call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
> +		request_key_auth_put(rka);
>  	}
>  }
>  
> @@ -174,6 +202,7 @@ struct key *request_key_auth_new(struct key *target, const char *op,
>  	rka = kzalloc_obj(*rka);
>  	if (!rka)
>  		goto error;
> +	refcount_set(&rka->usage, 1);
>  	rka->callout_info = kmemdup(callout_info, callout_len, GFP_KERNEL);
>  	if (!rka->callout_info)
>  		goto error_free_rka;I have a question when looking at the request_key_auth_new() in v7.2 kernel.

I have a question when looking at the error handling path in the
request_key_auth_new() code in v7.2 kernel:

struct key *request_key_auth_new(struct key *target, const char *op,
                                 const void *callout_info, size_t callout_len,
                                 struct key *dest_keyring)
{
        struct request_key_auth *rka, *irka;
[...snip]
        refcount_set(&rka->usage, 1);		// here set refcount to 1
[...snip]
        /* construct the auth key */
        ret = key_instantiate_and_link(authkey, rka, 0, NULL, NULL);
        if (ret < 0)
                goto error_put_authkey;

        kleave(" = {%d,%d}", authkey->serial, refcount_read(&authkey->usage));
        return authkey;

error_put_authkey:
        key_put(authkey);	// here the key_gc_work will call request_key_auth_destroy()
error_free_rka:
        free_request_key_auth(rka);	// Why is not `request_key_auth_put()` being used here?
error:
        kleave("= %d", ret);
        return ERR_PTR(ret);
}

The request_key_auth_destroy() also calls free_request_key_auth() finally:

request_key_auth_destroy() -> request_key_auth_put() ->
    request_key_auth_rcu_disposal() -> free_request_key_auth()

Direct use free_request_key_auth() in the error_free_rka path may cause
double free? Or I missed any information?

Thanks a lot!
Joey Lee
