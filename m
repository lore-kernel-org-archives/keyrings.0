From: David Howells <dhowells@redhat.com>
Date: Tue, 06 Jun 2017 18:45:56 +0000
Subject: Re: [PATCH] security/keys: rewrite all of big_key crypto
Message-Id: <15666.1496774756@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHmME9q35r302wJm_Y+UD1nT-fXcs9VGaDrZ5xWOm4jzDgyFwQ@mail.gmail.com> <20170606173900.29279-1-Jason@zx2c4.com> <14825.1496771896@warthog.procyon.org.uk>
In-Reply-To: <CAHmME9q35r302wJm_Y+UD1nT-fXcs9VGaDrZ5xWOm4jzDgyFwQ@mail.gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Kirill Marinushkin <k.marinushkin@gmail.com>, security@kernel.org, stable@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> Thank you! Perfect instructions, I'll play around with this and make
> sure it works.

Don't forget that it's bimodal.  You need to give it sufficient data to
trigger storage in swappable space.

David
