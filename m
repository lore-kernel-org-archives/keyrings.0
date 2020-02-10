From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 10 Feb 2020 06:10:47 +0000
Subject: Re: [PATCH 02/11] docs: crypto: convert asymmetric-keys.txt to ReST
Message-Id: <20200210071047.0db3f3a6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <cover.1581001737.git.mchehab+huawei@kernel.org>
        <1b6cd1da02dda27a725a6c4214019a1e306a7927.1581001737.git.mchehab+huawei@kernel.org>
        <20200206200911.GA2830394@erythro.kitware.com>
In-Reply-To: <20200206200911.GA2830394@erythro.kitware.com>
To: Ben Boeckel <mathstuf@gmail.com>
Cc: list.lkml.keyrings@me.benboeckel.net, Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, keyrings@vger.kernel.org

Em Thu, 6 Feb 2020 15:09:11 -0500
Ben Boeckel <mathstuf@gmail.com> escreveu:

> On Thu, Feb 06, 2020 at 16:11:21 +0100, Mauro Carvalho Chehab wrote:
> > - (1) If the criterion string is of the form "id:<hexdigits>" then the =
match
> > +  1) If the criterion string is of the form "id:<hexdigits>" then the =
match =20
>=20
> This update was followed in all the enumeration changes except=E2=80=A6
>=20
> > - (2) If the criterion string is of the form "<subtype>:<hexdigits>" th=
en the
> > + 2) If the criterion string is of the form "<subtype>:<hexdigits>" the=
n the =20
>=20
> The whitespace here doesn't match up. Which is preferred?

That was a mistake.

>=20
> > - (1) Signature verification.
> > +1) Signature verification. =20
>=20
> Here, the indentation was lost too. Is this intentional?

Both ways would work. I'll keep the original indentation for the next
version. Thanks for pointing it.

Cheers,
Mauro
