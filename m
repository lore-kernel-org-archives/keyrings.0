From: "Serge E. Hallyn" <serge@hallyn.com>
Date: Fri, 01 Mar 2019 22:28:53 +0000
Subject: Re: [PATCH] keys: fix missing __user in KEYCTL_PKEY_QUERY
Message-Id: <20190301222853.GA17210@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com, linux-kernel@lists.codethink.co.uk

On Fri, Mar 01, 2019 at 11:30:26AM +0000, Ben Dooks wrote:
> The arg5 of KEYCTL_PKEY_QUERY should have a __user pointer tag on
> it as it is a user pointer. This clears the following sparse warning
> for this:
> 
> security/keys/keyctl.c:1755:43: warning: incorrect type in argument 3 (different address spaces)
> security/keys/keyctl.c:1755:43:    expected struct keyctl_pkey_query [noderef] <asn:1>*<noident>
> security/keys/keyctl.c:1755:43:    got struct keyctl_pkey_query *<noident>
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/keys/keyctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 7bbe03593e58..3e4053a217c3 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1752,7 +1752,7 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		return keyctl_pkey_query((key_serial_t)arg2,
>  					 (const char __user *)arg4,
> -					 (struct keyctl_pkey_query *)arg5);
> +					 (struct keyctl_pkey_query __user *)arg5);
>  
>  	case KEYCTL_PKEY_ENCRYPT:
>  	case KEYCTL_PKEY_DECRYPT:
> -- 
> 2.20.1
