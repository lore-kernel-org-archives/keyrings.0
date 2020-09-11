From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 11 Sep 2020 19:22:50 +0000
Subject: Re: [PATCH v6 8/8] integrity: Asymmetric digsig supports SM2-with-SM3 algorithm
Message-Id: <46c6f4c1ccab14d914837aa1e4b4ab5674ecc93c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200903131242.128665-1-tianjia.zhang@linux.alibaba.com>
 <20200903131242.128665-9-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200903131242.128665-9-tianjia.zhang@linux.alibaba.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephan Mueller <smueller@chronox.de>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>, Brendan Higgins <brendanhiggins@google.com>, Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <longman@redhat.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Colin Ian King <colin.king@canonical.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Vitaly Chikunov <vt@altlinux.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Pascal van Leeuwen <pvanleeuwen@rambus.com>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-security-module@vger.kernel.org
Cc: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>, Jia Zhang <zhang.jia@linux.alibaba.com>

On Thu, 2020-09-03 at 21:12 +0800, Tianjia Zhang wrote:
> Asymmetric digsig supports SM2-with-SM3 algorithm combination,
> so that IMA can also verify SM2's signature data.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Tested-by: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com> (coding, not crypto
perspective)
> ---
>  security/integrity/digsig_asymmetric.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
> index cfa4127d0518..b86a4a8f61ab 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -99,14 +99,22 @@ int asymmetric_verify(struct key *keyring, const char *sig,
>  	memset(&pks, 0, sizeof(pks));
>  
>  	pks.hash_algo = hash_algo_name[hdr->hash_algo];
> -	if (hdr->hash_algo = HASH_ALGO_STREEBOG_256 ||
> -	    hdr->hash_algo = HASH_ALGO_STREEBOG_512) {
> +	switch (hdr->hash_algo) {
> +	case HASH_ALGO_STREEBOG_256:
> +	case HASH_ALGO_STREEBOG_512:
>  		/* EC-RDSA and Streebog should go together. */
>  		pks.pkey_algo = "ecrdsa";
>  		pks.encoding = "raw";
> -	} else {
> +		break;
> +	case HASH_ALGO_SM3_256:
> +		/* SM2 and SM3 should go together. */
> +		pks.pkey_algo = "sm2";
> +		pks.encoding = "raw";
> +		break;
> +	default:
>  		pks.pkey_algo = "rsa";
>  		pks.encoding = "pkcs1";
> +		break;
>  	}
>  	pks.digest = (u8 *)data;
>  	pks.digest_size = datalen;
