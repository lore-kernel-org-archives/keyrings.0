From: James Morris <james.l.morris@oracle.com>
Date: Mon, 27 Nov 2017 09:54:52 +0000
Subject: Re: [PATCH] pkcs7: fix check for self-signed certificate
Message-Id: <alpine.LFD.2.20.1711272054440.2808@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171127071942.26214-1-ebiggers3@gmail.com>
In-Reply-To: <20171127071942.26214-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@google.com>

On Sun, 26 Nov 2017, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> pkcs7_validate_trust_one() used 'x509->next = x509' to identify a
> self-signed certificate.  That's wrong; ->next is simply the link in the
> linked list of certificates in the PKCS#7 message.  It should be
> checking ->signer instead.  Fix it.
> 
> Fortunately this didn't actually matter because when we re-visited
> 'x509' on the next iteration via 'x509->signer', it was already seen and
> not verified, so we returned -ENOKEY anyway.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/asymmetric_keys/pkcs7_trust.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
> index f6a009d88a33..1f4e25f10049 100644
> --- a/crypto/asymmetric_keys/pkcs7_trust.c
> +++ b/crypto/asymmetric_keys/pkcs7_trust.c
> @@ -69,7 +69,7 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
>  		 /* Self-signed certificates form roots of their own, and if we
>  		  * don't know them, then we can't accept them.
>  		  */
> -		if (x509->next = x509) {
> +		if (x509->signer = x509) {
>  			kleave(" = -ENOKEY [unknown self-signed]");
>  			return -ENOKEY;
>  		}
> -- 


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

