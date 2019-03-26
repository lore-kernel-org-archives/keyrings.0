From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 26 Mar 2019 16:14:37 +0000
Subject: Re: [PATCH v8 05/10] X.509: parse public key parameters from x509 for akcipher
Message-Id: <e302ad90-98c7-1e82-4d49-8ad214fd6ee7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190326125842.24110-1-vt@altlinux.org>
 <20190326125842.24110-6-vt@altlinux.org>
In-Reply-To: <20190326125842.24110-6-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>, Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Vitaly,

On 03/26/2019 07:58 AM, Vitaly Chikunov wrote:
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
> Cc: keyrings@vger.kernel.org
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>   crypto/asymmetric_keys/asym_tpm.c         | 43 ++++++++++++++++--
>   crypto/asymmetric_keys/public_key.c       | 72 ++++++++++++++++++++++++-------
>   crypto/asymmetric_keys/x509.asn1          |  2 +-
>   crypto/asymmetric_keys/x509_cert_parser.c | 31 +++++++++++++
>   crypto/testmgr.c                          | 24 +++++++++--
>   crypto/testmgr.h                          |  5 +++
>   include/crypto/akcipher.h                 | 18 ++++----
>   include/crypto/public_key.h               |  4 ++
>   8 files changed, 168 insertions(+), 31 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
> index 402fc34ca044..d95d7ec50e5a 100644
> --- a/crypto/asymmetric_keys/asym_tpm.c
> +++ b/crypto/asymmetric_keys/asym_tpm.c
> @@ -395,6 +395,12 @@ static int determine_akcipher(const char *encoding, const char *hash_algo,
>   	return -ENOPKG;
>   }
>   
> +static u8 *tpm_pack_u32(u8 *dst, u32 val)
> +{
> +	memcpy(dst, &val, sizeof(val));
> +	return dst + sizeof(val);
> +}
> +
>   /*
>    * Query information about a key.
>    */
> @@ -407,6 +413,7 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
>   	struct crypto_akcipher *tfm;
>   	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
>   	uint32_t der_pub_key_len;
> +	u8 *pkey, *ptr;
>   	int len;
>   
>   	/* TPM only works on private keys, public keys still done in software */
> @@ -421,7 +428,16 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
>   	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
>   					 der_pub_key);
>   
> -	ret = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
> +	pkey = kmalloc(der_pub_key_len + sizeof(u32) * 2, GFP_KERNEL);
> +	if (!pkey)
> +		goto error_free_tfm;
> +	memcpy(pkey, der_pub_key, der_pub_key_len);
> +	ptr = pkey + der_pub_key_len;
> +	/* Set dummy parameters to satisfy set_pub_key ABI. */
> +	ptr = tpm_pack_u32(ptr, 0); /* algo */
> +	ptr = tpm_pack_u32(ptr, 0); /* parameter length */
> +

Why not do all of this inside derive_pub_key?  The only reason for that 
function is to take a TPM-blob formatted public key and convert it to 
ASN.1 format understood by crypto_akcipher_set_pub_key.  So if you're 
changing the format, might as well update that function.

> +	ret = crypto_akcipher_set_pub_key(tfm, pkey, der_pub_key_len);
>   	if (ret < 0)
>   		goto error_free_tfm;
>   
> @@ -440,6 +456,7 @@ static int tpm_key_query(const struct kernel_pkey_params *params,
>   
>   	ret = 0;
>   error_free_tfm:
> +	kfree(pkey);
>   	crypto_free_akcipher(tfm);
>   	pr_devel("<=%s() = %d\n", __func__, ret);
>   	return ret;
> @@ -460,6 +477,7 @@ static int tpm_key_encrypt(struct tpm_key *tk,
>   	struct scatterlist in_sg, out_sg;
>   	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
>   	uint32_t der_pub_key_len;
> +	u8 *pkey, *ptr;
>   	int ret;
>   
>   	pr_devel("=>%s()\n", __func__);
> @@ -475,7 +493,15 @@ static int tpm_key_encrypt(struct tpm_key *tk,
>   	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
>   					 der_pub_key);
>   
> -	ret = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
> +	pkey = kmalloc(der_pub_key_len + sizeof(u32) * 2, GFP_KERNEL);
> +	if (!pkey)
> +		goto error_free_tfm;
> +	memcpy(pkey, der_pub_key, der_pub_key_len);
> +	ptr = pkey + der_pub_key_len;
> +	ptr = tpm_pack_u32(ptr, 0); /* algo */
> +	ptr = tpm_pack_u32(ptr, 0); /* parameter length */
> +

Same comment as above

> +	ret = crypto_akcipher_set_pub_key(tfm, pkey, der_pub_key_len);
>   	if (ret < 0)
>   		goto error_free_tfm;
>   
> @@ -500,6 +526,7 @@ static int tpm_key_encrypt(struct tpm_key *tk,
>   
>   	akcipher_request_free(req);
>   error_free_tfm:
> +	kfree(pkey);
>   	crypto_free_akcipher(tfm);
>   	pr_devel("<=%s() = %d\n", __func__, ret);
>   	return ret;
> @@ -748,6 +775,7 @@ static int tpm_key_verify_signature(const struct key *key,
>   	char alg_name[CRYPTO_MAX_ALG_NAME];
>   	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
>   	uint32_t der_pub_key_len;
> +	u8 *pkey, *ptr;
>   	int ret;
>   
>   	pr_devel("=>%s()\n", __func__);
> @@ -770,7 +798,15 @@ static int tpm_key_verify_signature(const struct key *key,
>   	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
>   					 der_pub_key);
>   
> -	ret = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
> +	pkey = kmalloc(der_pub_key_len + sizeof(u32) * 2, GFP_KERNEL);
> +	if (!pkey)
> +		goto error_free_tfm;
> +	memcpy(pkey, der_pub_key, der_pub_key_len);
> +	ptr = pkey + der_pub_key_len;
> +	ptr = tpm_pack_u32(ptr, 0); /* algo */
> +	ptr = tpm_pack_u32(ptr, 0); /* parameter length */
> +

And here

> +	ret = crypto_akcipher_set_pub_key(tfm, pkey, der_pub_key_len);
>   	if (ret < 0)
>   		goto error_free_tfm;
>   
> @@ -792,6 +828,7 @@ static int tpm_key_verify_signature(const struct key *key,
>   
>   	akcipher_request_free(req);
>   error_free_tfm:
> +	kfree(pkey);
>   	crypto_free_akcipher(tfm);
>   	pr_devel("<=%s() = %d\n", __func__, ret);
>   	if (WARN_ON_ONCE(ret > 0))

Regards,
-Denis
