From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Date: Sun, 10 Feb 2019 20:32:35 +0000
Subject: Re: [PATCH] MAINTAINERS: rectify two issues in KEYS-TRUSTED entry
Message-Id: <20190210203235.GN4240@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190210190009.9995-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20190210190009.9995-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 08:00:09PM +0100, Lukas Bulwahn wrote:
> Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
> further maintainer to the KEYS-TRUSTED section entry. Paul McKenney also
> introduced a typo in Mimi Zohar's email address in the KEYS-TRUSTED section
> entry.
> 
> The two issues were detected when writing a script that parses MAINTAINERS.
> 
> Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
> Fixes: 1dfddcdb95c4 ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Good catch!

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
> Mimi, please pick up this patch instead of
>   "[PATCH] MAINTAINERS: use tab instead of spaces". Thanks.
> 
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf4965d6d5de..b4b62ea78eeb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8405,8 +8405,8 @@ F:	security/keys/encrypted-keys/
> 
>  KEYS-TRUSTED
>  M:	James Bottomley <jejb@linux.ibm.com>
> -M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> -M:	Mimi Zohar <zohar@linuxibm.com>
> +M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> +M:	Mimi Zohar <zohar@linux.ibm.com>
>  L:	linux-integrity@vger.kernel.org
>  L:	keyrings@vger.kernel.org
>  S:	Supported
> -- 
> 2.17.1
> 
