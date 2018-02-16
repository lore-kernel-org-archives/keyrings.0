From: Eric Biggers <ebiggers3@gmail.com>
Date: Fri, 16 Feb 2018 01:56:29 +0000
Subject: Re: [RFC PATCH] KEYS: Use individual pages in big_key for crypto buffers [ver #2]
Message-Id: <20180216015629.GA136603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <151873522941.16065.2576464502758911341.stgit@warthog.procyon.org.uk>
In-Reply-To: <151873522941.16065.2576464502758911341.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Jason@zx2c4.com, herbert@gondor.apana.org.au, k.marinushkin@gmail.com, linux-crypto@vger.kernel.org

Hi David,

On Thu, Feb 15, 2018 at 10:53:49PM +0000, David Howells wrote:
>  /*
> + * Free up the buffer.
> + */
> +static void big_key_free_buffer(struct big_key_buf *buf)
> +{
> +	unsigned int i;
> +
> +	vunmap(buf->virt);
> +	for (i = 0; i < buf->nr_pages; i++)
> +		if (buf->pages[i])
> +			__free_page(buf->pages[i]);
> +
> +	memset(buf->virt, 0, buf->nr_pages * PAGE_SIZE);
> +	kfree(buf);
> +}

memset() after vunmap(), and also when buf->virt can be NULL?  I had suggested:

        if (buf->virt) {
                memset(buf->virt, 0, buf->nr_pages * PAGE_SIZE);
                vunmap(buf->virt);
        }

- Eric
