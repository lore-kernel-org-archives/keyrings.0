From: Denis Kenzior <denkenz@gmail.com>
Date: Thu, 11 Apr 2019 17:18:36 +0000
Subject: Re: [PATCH v9 05/10] X.509: parse public key parameters from x509 for akcipher
Message-Id: <48828e0e-0aef-dece-e7ad-4c0ea9cefbe7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190411155122.13245-1-vt@altlinux.org>
 <20190411155122.13245-6-vt@altlinux.org>
In-Reply-To: <20190411155122.13245-6-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>, Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Vitaly,

On 04/11/2019 10:51 AM, Vitaly Chikunov wrote:
> Some public key algorithms (like EC-DSA) keep in parameters field
> important data such as digest and curve OIDs (possibly more for
> different EC-DSA variants). Thus, just setting a public key (as
> for RSA) is not enough.
> 
> Append parameters into the key stream for akcipher_set_{pub,priv}_key.
> Appended data is: (u32) algo OID, (u32) parameters length, parameters
> data.
> 
> This does not affect current akcipher API nor RSA ciphers (they could
> ignore it). Idea of appending parameters to the key stream is by Herbert
> Xu.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Denis Kenzior <denkenz@gmail.com>
> Cc: keyrings@vger.kernel.org
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>   crypto/asymmetric_keys/asym_tpm.c         |  9 +++-
>   crypto/asymmetric_keys/public_key.c       | 72 ++++++++++++++++++++++++-------
>   crypto/asymmetric_keys/x509.asn1          |  2 +-
>   crypto/asymmetric_keys/x509_cert_parser.c | 31 +++++++++++++
>   crypto/testmgr.c                          | 24 +++++++++--
>   crypto/testmgr.h                          |  5 +++
>   include/crypto/akcipher.h                 | 18 ++++----
>   include/crypto/public_key.h               |  4 ++
>   8 files changed, 136 insertions(+), 29 deletions(-)
> 

Looks good to me.

Reviewed-by: Denis Kenzior <denkenz@gmail.com>

By the way:

> @@ -400,11 +401,12 @@ static inline int crypto_akcipher_set_pub_key(struct crypto_akcipher *tfm,
>    * crypto_akcipher_set_priv_key() - Invoke set private key operation
>    *
>    * Function invokes the algorithm specific set key function, which knows
> - * how to decode and interpret the encoded key
> + * how to decode and interpret the encoded keya and parameters

Seems to be a stray 'a' after 'key'?

Regards,
-Denis
