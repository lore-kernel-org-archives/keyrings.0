From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 10 Feb 2019 18:21:42 +0000
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
Message-Id: <f34543f5-d0fc-b998-9ce1-c8f3fd36db73@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linuxibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/10/19 10:10 AM, Lukas Bulwahn wrote:
> Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
> further maintainer to the KEYS-TRUSTED section entry. So, we rectify this
> with this commit.
> 
> The issue was detected when writing a script that parses MAINTAINERS.
> 
> Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Mimi, please pick up this patch. Thanks.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf4965d6d5de..31950caabcaf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8405,7 +8405,7 @@ F:	security/keys/encrypted-keys/
>  
>  KEYS-TRUSTED
>  M:	James Bottomley <jejb@linux.ibm.com>
> -M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> +M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>  M:	Mimi Zohar <zohar@linuxibm.com>

Just checking:  is that email address correct (@linuxibm.com)?

Guess I'll see if it bounces.

>  L:	linux-integrity@vger.kernel.org
>  L:	keyrings@vger.kernel.org
> 


-- 
~Randy
