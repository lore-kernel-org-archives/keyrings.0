From: Vitaly Chikunov <vt@altlinux.org>
Date: Sat, 12 Sep 2020 08:36:52 +0000
Subject: Re: [PATCH v6 8/8] integrity: Asymmetric digsig supports SM2-with-SM3 algorithm
Message-Id: <20200912083652.dxosjsartbvnxq2r@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200903131242.128665-1-tianjia.zhang@linux.alibaba.com>
 <20200903131242.128665-9-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200903131242.128665-9-tianjia.zhang@linux.alibaba.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Stephan Mueller <smueller@chronox.de>, Brendan Higgins <brendanhiggins@google.com>, Jia Zhang <zhang.jia@linux.alibaba.com>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Herbert Xu <herbert@gondor.apana.org.au>, Masahiro Yamada <masahiroy@kernel.org>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, Waiman Long <longman@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Alexandre Torgue <alexandre.torgue@st.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-arm-kernel@lists.infradead.org, Pascal van Leeuwen <pvanleeuwen@rambus.com>, linux-kernel@vger.kernel.org, Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>, linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Sep 03, 2020 at 09:12:42PM +0800, Tianjia Zhang wrote:
> Asymmetric digsig supports SM2-with-SM3 algorithm combination,
> so that IMA can also verify SM2's signature data.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Tested-by: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com> (coding, not crypto

It looks not breaking ecrdsa/streebog handling and accords to rfc draft:

  https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02

  5.1.4.2.  Hash Functions
    The sm2 digital signature algorithm requires the hash functions
    approved by Chinese Commercial Cryptography Administration Office,
    such as sm3.

Reviewed-by: Vitaly Chikunov <vt@altlinux.org>

Thanks,

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
