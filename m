From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 22 Nov 2019 17:02:01 +0000
Subject: Re: [PATCH] Documentation: security: core.rst: fix warnings
Message-Id: <20191122100201.30b1e71f@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191122041806.68650-1-dwlsalmeida@gmail.com>
In-Reply-To: <20191122041806.68650-1-dwlsalmeida@gmail.com>
To: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc: dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org

On Fri, 22 Nov 2019 01:18:06 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Fix warnings due to missing markup, no change in content otherwise.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  Documentation/security/keys/core.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
> index d6d8b0b756b6..d9b0b859018b 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -1102,7 +1102,7 @@ payload contents" for more information.
>      See also Documentation/security/keys/request-key.rst.
>  
>  
> - *  To search for a key in a specific domain, call:
> + *  To search for a key in a specific domain, call::
>  
>  	struct key *request_key_tag(const struct key_type *type,
>  				    const char *description,

Applied, thanks.

jon
