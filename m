From: James Morris <jmorris@namei.org>
Date: Wed, 03 Oct 2018 19:24:07 +0000
Subject: Re: [PATCH 05/22] KEYS: Provide software public key query function
Message-Id: <alpine.LRH.2.21.1810040520570.16168@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618449119.7946.11025480207548147086.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618449119.7946.11025480207548147086.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, David Howells wrote:

> +	if (strcmp(encoding, "raw") = 0) {
> +		strcpy(alg_name, pkey->pkey_algo);
> +		return 0;
> +	}

Can encoding here also be NULL to indicate raw? per patch 01:

> +struct kernel_pkey_params {
> +       struct key      *key;
> +       const char      *encoding;      /* Encoding (eg. "oaep" or NULL for raw) */


-- 
James Morris
<jmorris@namei.org>
