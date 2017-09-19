From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 19 Sep 2017 19:17:54 +0000
Subject: Re: [kernel-hardening] Re: [PATCH v4] security/keys: rewrite all of big_key crypto
Message-Id: <CAHmME9oQx=bcvcgzS8kmpuE1MHLzOjkFcCdJrFvnufo5zery0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170916130034.17706-1-Jason@zx2c4.com> <2681038.03lnYPhpsa@tauon.chronox.de>
 <CAHmME9p6uq0ELtgxB94bc4bUppa7UogWSEgj_9o8p2xXQfrz5A@mail.gmail.com>
 <20170919133959.5fgtioyonlsdyjf5@thunk.org> <CACXcFmmBzHu-9sCs+gJDbjeR4MTdOfMtUaBr+YjkwyfFquQMBA@mail.gmail.com>
In-Reply-To: <CACXcFmmBzHu-9sCs+gJDbjeR4MTdOfMtUaBr+YjkwyfFquQMBA@mail.gmail.com>
To: Sandy Harris <sandyinchina@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Stephan Mueller <smueller@chronox.de>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, kernel-hardening@lists.openwall.com, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers3@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Kirill Marinushkin <k.marinushkin@gmail.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ilhan Gurel <ilhan.gurel@gmail.com>, security@kernel.org, stable@vger.kernel.org

On Tue, Sep 19, 2017 at 9:04 PM, Sandy Harris <sandyinchina@gmail.com> wrote:
> On the other hand, I do not see why the driver should not

From my perspective, this discussion is over. I'll be carrying out
David's requested patchset changes and submitting it. If you'd like
different cryptography, you'll have to find somebody else to do that
work for you.
