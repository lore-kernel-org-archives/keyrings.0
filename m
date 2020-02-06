From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 06 Feb 2020 20:09:11 +0000
Subject: Re: [PATCH 02/11] docs: crypto: convert asymmetric-keys.txt to ReST
Message-Id: <20200206200911.GA2830394@erythro.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <cover.1581001737.git.mchehab+huawei@kernel.org>
 <1b6cd1da02dda27a725a6c4214019a1e306a7927.1581001737.git.mchehab+huawei@kernel.org>
In-Reply-To: <1b6cd1da02dda27a725a6c4214019a1e306a7927.1581001737.git.mchehab+huawei@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, keyrings@vger.kernel.org

On Thu, Feb 06, 2020 at 16:11:21 +0100, Mauro Carvalho Chehab wrote:
> - (1) If the criterion string is of the form "id:<hexdigits>" then the ma=
tch
> +  1) If the criterion string is of the form "id:<hexdigits>" then the ma=
tch

This update was followed in all the enumeration changes except=E2=80=A6

> - (2) If the criterion string is of the form "<subtype>:<hexdigits>" then=
 the
> + 2) If the criterion string is of the form "<subtype>:<hexdigits>" then =
the

The whitespace here doesn't match up. Which is preferred?

> - (1) Signature verification.
> +1) Signature verification.

Here, the indentation was lost too. Is this intentional?

--Ben
