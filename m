From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 28 Nov 2018 23:20:20 +0000
Subject: Re: [PATCH] KEYS: fix parsing invalid pkey info string
Message-Id: <20181128232019.GC131170@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <000000000000c220960579c4936d@google.com>
 <20181103173035.23974-1-ebiggers@kernel.org>
In-Reply-To: <20181103173035.23974-1-ebiggers@kernel.org>
To: keyrings@vger.kernel.org, dhowells@redhat.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

On Sat, Nov 03, 2018 at 10:30:35AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> We need to check the return value of match_token() for Opt_err (-1)
> before doing anything with it.
> 
> Reported-by: syzbot+a22e0dc07567662c50bc@syzkaller.appspotmail.com
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  security/keys/keyctl_pkey.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 783978842f13a..987fac8051d70 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -50,6 +50,8 @@ static int keyctl_pkey_params_parse(struct kernel_pkey_params *params)
>  		if (*p = '\0' || *p = ' ' || *p = '\t')
>  			continue;
>  		token = match_token(p, param_keys, args);
> +		if (token = Opt_err)
> +			return -EINVAL;
>  		if (__test_and_set_bit(token, &token_mask))
>  			return -EINVAL;
>  		q = args[0].from;
> -- 
> 2.19.1

Ping.  David, are you planning to apply this?

- Eric
