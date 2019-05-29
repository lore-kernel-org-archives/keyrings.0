From: James Morris <jmorris@namei.org>
Date: Wed, 29 May 2019 21:48:43 +0000
Subject: Re: [PATCH RESEND] KEYS: reuse keyring_index_key::desc_len in lookup_user_key()
Message-Id: <alpine.LRH.2.21.1905300748350.5445@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190529210152.120249-1-ebiggers@kernel.org>
In-Reply-To: <20190529210152.120249-1-ebiggers@kernel.org>
To: keyrings@vger.kernel.org

On Wed, 29 May 2019, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> When lookup_user_key() checks whether the key is possessed, it should
> use the key's existing index_key including the 'desc_len' field, rather
> than recomputing the 'desc_len'.  This doesn't change the behavior; this
> way is just simpler and faster.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>

-- 
James Morris
<jmorris@namei.org>
