From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 06 Jun 2017 18:25:47 +0000
Subject: Re: [PATCH] security/keys: rewrite all of big_key crypto
Message-Id: <CAHmME9q35r302wJm_Y+UD1nT-fXcs9VGaDrZ5xWOm4jzDgyFwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170606173900.29279-1-Jason@zx2c4.com> <14825.1496771896@warthog.procyon.org.uk>
In-Reply-To: <14825.1496771896@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Kirill Marinushkin <k.marinushkin@gmail.com>, security@kernel.org, stable@vger.kernel.org

On Tue, Jun 6, 2017 at 7:58 PM, David Howells <dhowells@redhat.com> wrote:
> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
>> This commit has been compile-tested only, so I'd appreciate it if
>> somebody else who actually uses this would test it for functionality, or
>> if somebody into the kernel's crypto API would check that it's been done
>> correctly.
>
> You need to test it.  You can do this with:
>
>         dd ... | keyctl padd big_key fred @s
>
> This will print a key ID.  Then you can retrieve the contents with:
>
>         keyctl pipe <key-id> | ...

Thank you! Perfect instructions, I'll play around with this and make
sure it works.

Jason
