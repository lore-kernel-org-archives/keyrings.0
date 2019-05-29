From: James Morris <jmorris@namei.org>
Date: Wed, 29 May 2019 21:49:09 +0000
Subject: Re: [PATCH RESEND] KEYS: remove CONFIG_KEYS_COMPAT
Message-Id: <alpine.LRH.2.21.1905300748560.5445@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180105191947.91775-1-ebiggers3@gmail.com>
In-Reply-To: <20180105191947.91775-1-ebiggers3@gmail.com>
To: keyrings@vger.kernel.org

On Wed, 29 May 2019, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> KEYS_COMPAT now always takes the value of COMPAT && KEYS.  But the
> security/keys/ directory is only compiled if KEYS is enabled, so in
> practice KEYS_COMPAT is the same as COMPAT.  Therefore, remove the
> unnecessary KEYS_COMPAT and just use COMPAT directly.
> 
> (Also remove an outdated comment from compat.c.)
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
