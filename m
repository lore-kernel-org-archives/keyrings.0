From: Eric Biggers <ebiggers@kernel.org>
Date: Sat, 02 May 2020 00:14:09 +0000
Subject: Re: [PATCH] security/keys: rewrite big_key crypto to use Zinc
Message-Id: <20200502001409.GD915@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200501222357.543312-1-Jason@zx2c4.com>
 <20200501230913.GB915@sol.localdomain>
 <CAHmME9rpZGiwrK93=+6z8qBdDVs273MaR_boDd1xjjZRwbqpKQ@mail.gmail.com>
In-Reply-To: <CAHmME9rpZGiwrK93=+6z8qBdDVs273MaR_boDd1xjjZRwbqpKQ@mail.gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, kernel-hardening@lists.openwall.com

On Fri, May 01, 2020 at 06:06:17PM -0600, Jason A. Donenfeld wrote:
> Hey Eric,
> 
> Thanks for the review.
> 
> I'll add `select CONFIG` as you suggested. I agree about trying to
> move as much as possible out of crypto and into lib/crypto. Breaking
> those dependency cycles won't be easy but perhaps it'll be possible to
> chip away at that gradually. (I'd also lib a
> lib/crypto/arch/{arch}/..., but I guess that's a separate discussion.)
> 
> I'll also change -EINVAL to -EBADMSG. Nice catch.
> 
> Regarding the buffer zeroing... are you sure? These buffers are
> already being copied into filesystem caches and all sorts of places
> over which we have zero control. At that point, does it matter? Or do
> you argue that because it's still technically key material, we should
> zero out both the plaintext and ciphertext everywhere we can, and
> hopefully at some point the places where we can't will go away? IOW,
> I'm fine doing that, but would like to learn your explicit reasoning
> before.

It's true that the buffer zeroing doesn't matter in big_key_preparse() because
the buffer only holds the encrypted key (which is what the shmem file will
contain).  But in big_key_read(), the buffer holds the decrypted key.  So it's
at least needed there.  Having it in both places for consistency might be a good
idea.

- Eric
