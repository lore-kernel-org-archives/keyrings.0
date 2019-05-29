From: James Morris <jmorris@namei.org>
Date: Wed, 29 May 2019 21:48:23 +0000
Subject: Re: [PATCH RESEND] KEYS: asymmetric: return ENOMEM if akcipher_request_alloc() fails
Message-Id: <alpine.LRH.2.21.1905300748140.5445@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190529210132.120114-1-ebiggers@kernel.org>
In-Reply-To: <20190529210132.120114-1-ebiggers@kernel.org>
To: keyrings@vger.kernel.org

On Wed, 29 May 2019, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> No error code was being set on this error path.
> 
> Fixes: ad4b1eb5fb33 ("KEYS: asym_tpm: Implement encryption operation [ver #2]")
> Fixes: c08fed737126 ("KEYS: Implement encrypt, decrypt and sign for software asymmetric key [ver #2]")
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
