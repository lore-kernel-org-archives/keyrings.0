From: James Morris <jmorris@namei.org>
Date: Wed, 03 Oct 2018 19:12:40 +0000
Subject: Re: [PATCH 04/22] KEYS: Make the X.509 and PKCS7 parsers supply the sig encoding type
Message-Id: <alpine.LRH.2.21.1810040511390.16168@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618448451.7946.79126788153992612.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618448451.7946.79126788153992612.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, David Howells wrote:

> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index b6cabac4b62b..991f4d735a4e 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -199,35 +199,32 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
>  
>  	case OID_md4WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "md4";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  
>  	case OID_sha1WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "sha1";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  
>  	case OID_sha256WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "sha256";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  
>  	case OID_sha384WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "sha384";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  
>  	case OID_sha512WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "sha512";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  
>  	case OID_sha224WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "sha224";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  	}
>  
> +rsa_pkcs1:
> +	ctx->cert->sig->pkey_algo = "rsa";
> +	ctx->cert->sig->encoding = "pkcs1";
>  	ctx->algo_oid = ctx->last_oid;
>  	return 0;
>  }

Perhaps I'm missing something here but why do you need the gotos vs. just 
breaking to this code?


-- 
James Morris
<jmorris@namei.org>
