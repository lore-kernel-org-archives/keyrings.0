From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Date: Tue, 21 May 2019 19:15:29 +0000
Subject: Re: [PATCH] crypto: af_alg - implement keyring support
Message-Id: <8758550.T3OrFO1o5E@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190521100034.9651-1-omosnace@redhat.com>
In-Reply-To: <20190521100034.9651-1-omosnace@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Milan Broz <gmazyland@gmail.com>, Ondrej Kozina <okozina@redhat.com>, Daniel Zatovic <dzatovic@redhat.com>

Am Dienstag, 21. Mai 2019, 12:00:34 CEST schrieb Ondrej Mosnacek:

Hi Ondrej,

> This patch adds new socket options to AF_ALG that allow setting key from
> kernel keyring. For simplicity, each keyring key type (logon, user,
> trusted, encrypted) has its own socket option name and the value is just
> the key description string that identifies the key to be used. The key
> description doesn't need to be NULL-terminated, but bytes after the
> first zero byte are ignored.
>=20
> Note that this patch also adds three socket option names that are
> already defined and used in libkcapi [1], but have never been added to
> the kernel...
>=20
> Tested via libkcapi with keyring patches [2] applied (user and logon key
> types only).
>=20
> [1] https://github.com/smuellerDD/libkcapi
> [2] https://github.com/WOnder93/libkcapi/compare/f283458...1fb501c
>=20
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Thank you!

Reviewed-by: Stephan M=FCller <smueller@chronox.de>

If the patch goes in, I will merge the libkcapi patch set and create a new =

release.

Ciao
Stephan
