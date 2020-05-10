From: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 10 May 2020 21:17:38 +0000
Subject: Re: [PATCH v2] security/keys: rewrite big_key crypto to use Zinc
Message-Id: <20200510211738.GA52708@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHmME9rvp4JrER0RPp=VgYwYL87jntwW8vWNANzubH3Ah_8Oow@mail.gmail.com>
 <20200502001942.626523-1-Jason@zx2c4.com>
In-Reply-To: <20200502001942.626523-1-Jason@zx2c4.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, kernel-hardening@lists.openwall.com

On Fri, May 01, 2020 at 06:19:42PM -0600, Jason A. Donenfeld wrote:
> A while back, I noticed that the crypto and crypto API usage in big_keys
> were entirely broken in multiple ways, so I rewrote it. Now, I'm
> rewriting it again, but this time using Zinc's ChaCha20Poly1305
> function. This makes the file considerably more simple; the diffstat
> alone should justify this commit. It also should be faster, since it no
> longer requires a mutex around the "aead api object" (nor allocations),
> allowing us to encrypt multiple items in parallel. We also benefit from
> being able to pass any type of pointer, so we can get rid of the
> ridiculously complex custom page allocator that big_key really doesn't
> need.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: kernel-hardening@lists.openwall.com
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

You can add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

But, a couple minor suggestions:

The commit message should say "lib/crypto", not Zinc.  Nothing in the source
tree actually says Zinc, so it will confuse people who haven't read all the
previous discussions.

>  		/* read file to kernel and decrypt */
> -		ret = kernel_read(file, buf->virt, enclen, &pos);
> +		ret = kernel_read(file, buf, enclen, &pos);
>  		if (ret >= 0 && ret != enclen) {
>  			ret = -EIO;
>  			goto err_fput;
> +		} else if (ret < 0) {
> +			goto err_fput;
>  		}

It would make sense to write this as the following, to make it consistent with
how the return value of kernel_write() is checked in big_key_preparse():

		ret = kernel_read(file, buf, enclen, &pos);
		if (ret != enclen) {
			if (ret >= 0)
				ret = -ENOMEM;
			goto err_fput;
		}

- Eric
