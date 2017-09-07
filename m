From: Joe Perches <joe@perches.com>
Date: Thu, 07 Sep 2017 05:54:57 +0000
Subject: Re: [PATCH] security/keys: Adding newline after declaration
Message-Id: <1504763697.7546.9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1504762905-2424-1-git-send-email-pushkar.iit@gmail.com>
In-Reply-To: <1504762905-2424-1-git-send-email-pushkar.iit@gmail.com>
To: linux-security-module@vger.kernel.org

On Thu, 2017-09-07 at 11:11 +0530, Pushkar Jambhlekar wrote:
> Fixing checkpatch warning to add newline after declaration
[]
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
[]
> @@ -93,6 +93,7 @@ static int big_key_crypt(enum big_key_op op, u8 *data, size_t datalen, u8 *key)
>  {
>  	int ret = -EINVAL;
>  	struct scatterlist sgio;
> +
>  	SKCIPHER_REQUEST_ON_STACK(req, big_key_skcipher);

checkpatch doesn't know that SKCIPHER_REQUEST_ON_STACK
is actually 2 declarations.

