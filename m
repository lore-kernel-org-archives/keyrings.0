From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 26 Mar 2019 16:00:40 +0000
Subject: Re: [PATCH v8 03/10] crypto: akcipher - new verify API for public key algorithms
Message-Id: <ed78154e-2491-8e3e-3362-e45df4fda011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190326125842.24110-1-vt@altlinux.org>
 <20190326125842.24110-4-vt@altlinux.org>
In-Reply-To: <20190326125842.24110-4-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>, Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Vitaly,

On 03/26/2019 07:58 AM, Vitaly Chikunov wrote:
> Previous akcipher .verify() just `decrypts' (using RSA encrypt which is
> using public key) signature to uncover message hash, which was then
> compared in upper level public_key_verify_signature() with the expected
> hash value, which itself was never passed into verify().
> 
> This approach was incompatible with EC-DSA family of algorithms,
> because, to verify a signature EC-DSA algorithm also needs a hash value
> as input; then it's used (together with a signature divided into halves
> `r||s') to produce a witness value, which is then compared with `r' to
> determine if the signature is correct. Thus, for EC-DSA, nor
> requirements of .verify() itself, nor its output expectations in
> public_key_verify_signature() wasn't sufficient.
> 
> Make improved .verify() call which gets hash value as input and produce
> complete signature check without any output besides status.
> 
> Now for the top level verification only crypto_akcipher_verify() needs
> to be called and its return value inspected.
> 
> Make sure that `digest' is in kmalloc'd memory (in place of `output`) in
> {public,tpm}_key_verify_signature() as insisted by Herbert Xu, and will
> be changed in the following commit.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: keyrings@vger.kernel.org
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>   crypto/asymmetric_keys/asym_tpm.c   | 34 ++++++++-----------------
>   crypto/asymmetric_keys/public_key.c | 34 ++++++++-----------------
>   crypto/rsa-pkcs1pad.c               | 29 +++++++++++++--------
>   crypto/testmgr.c                    | 50 ++++++++++++++++++++++---------------
>   include/crypto/akcipher.h           | 36 ++++++++++++++++----------
>   5 files changed, 92 insertions(+), 91 deletions(-)

The TPM bits, public_key and akcipher changes look good to me.  Didn't 
look into testmgr.

Feel free to add
Reviewed-by: Denis Kenzior <denkenz@gmail.com>

to this and patch 4.

Regards,
-Denis
