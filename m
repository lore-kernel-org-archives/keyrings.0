From: David Howells <dhowells@redhat.com>
Date: Tue, 06 Jun 2017 17:58:16 +0000
Subject: Re: [PATCH] security/keys: rewrite all of big_key crypto
Message-Id: <14825.1496771896@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170606173900.29279-1-Jason@zx2c4.com>
In-Reply-To: <20170606173900.29279-1-Jason@zx2c4.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Kirill Marinushkin <k.marinushkin@gmail.com>, security@kernel.org, stable@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> This commit has been compile-tested only, so I'd appreciate it if
> somebody else who actually uses this would test it for functionality, or
> if somebody into the kernel's crypto API would check that it's been done
> correctly.

You need to test it.  You can do this with:

	dd ... | keyctl padd big_key fred @s

This will print a key ID.  Then you can retrieve the contents with:

	keyctl pipe <key-id> | ...

David
