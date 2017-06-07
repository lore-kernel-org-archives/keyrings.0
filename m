From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Date: Wed, 07 Jun 2017 05:14:20 +0000
Subject: Re: [PATCH] security/keys: rewrite all of big_key crypto
Message-Id: <4079216.Z1x2SUeU2i@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170606173900.29279-1-Jason@zx2c4.com>
In-Reply-To: <20170606173900.29279-1-Jason@zx2c4.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers3@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Kirill Marinushkin <k.marinushkin@gmail.com>, security@kernel.org, stable@vger.kernel.org

Am Dienstag, 6. Juni 2017, 19:39:00 CEST schrieb Jason A. Donenfeld:

Hi Jason,

> This started out as just replacing the use of crypto/rng with

I have some concerns on this part. The use of crypto/rng is to help all users, 
including those who like FIPS and Co. The crypto/rng code per default uses the 
DRBG which is mandatory for several people.

I wish it would not be needed such that the get_random_bytes provides the 
possibility to use a DRBG ... .

As the DRBG has considerations around early boot entropy, I would think that 
the entropy discussion is not applicable here.

Thanks
Stephan
