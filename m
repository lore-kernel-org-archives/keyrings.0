From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 06 Jun 2017 17:40:25 +0000
Subject: Re: [PATCH] security/keys: rewrite all of big_key crypto
Message-Id: <CAHmME9ozuWXrZfSo3WQ7d7kwB3EKsP=obTkP9DFYoK33-0nSuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170606173900.29279-1-Jason@zx2c4.com>
In-Reply-To: <20170606173900.29279-1-Jason@zx2c4.com>
To: keyrings@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers3@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Kirill Marinushkin <k.marinushkin@gmail.com>, security@kernel.org, stable@vger.kernel.org

This patch has been split out of the wait_for_random_bytes patchset,
but the two are dependent on each other.
