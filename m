From: Stephan Mueller <smueller@chronox.de>
Date: Thu, 31 Aug 2017 16:21:37 +0000
Subject: Re: [RFC PATCH 4/5] keyctl.2: document the ability to provide KDF parameters in KEYCTL_DH_COMPUTE
Message-Id: <3012446.sSctSvPOAs@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20170831155836.GA5257@asgard.redhat.com> <1638688.g8nhH00jlV@tauon.chronox.de> <CACGkJdveSTUSYXEWzRCAXPF1nwhbtUeH2LsaoYpDGJ_FfyesTQ@mail.gmail.com>
In-Reply-To: <CACGkJdveSTUSYXEWzRCAXPF1nwhbtUeH2LsaoYpDGJ_FfyesTQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Eugene Syromyatnikov <evgsyr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michael Kerrisk-manpages <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am Donnerstag, 31. August 2017, 18:17:09 CEST schrieb Eugene Syromyatnikov:

Hi Eugene,

> On Thu, Aug 31, 2017 at 6:07 PM, Stephan Mueller <smueller@chronox.de>=20
wrote:
> > Am Donnerstag, 31. August 2017, 17:58:36 CEST schrieb Eugene
> > Syromyatnikov:
> >=20
> > Hi Eugene,
> >=20
> >> +field is a null-terminated string no longer than
> >> +.B CRYPTO_MAX_ALG_NAME
> >> +(128 bytes as of this writing) which specifies hash name
> >=20
> > Is it necessary to specify that size? Note, up to 4.11 it was 64 bytes.
> > Also, it must be a valid cipher name as mentioned. Thus, I do not think
> > the size is relevant here considering the requirement to use a proper
> > name.
>=20
> Right, it's probably more important for syscall decoding, but not for
> the documentation. However, my understanding is that cipher template
> can be specified (like "rfc4106(gcm(aes))"), and I'm not sure how deep
> this nesting can be and whether it is possible to reach algorithm name
> limit this way (by employing the usage of driver name instead of
> common name, for example=E2=80=94as I understood, it is also possible). It
> probably makes more sense to just mention this limit in the ERRORS
> section instead.

CRYPTO_MAX_ALG_NAME is given a size that all allowed cipher names can be=20
represented.

Somehow in the 4.12 release cycle, somebody found a very obscure yet valid =

name for a symmetric cipher that exceeded the 64 byte limit causing the bum=
p=20
to 128 bytes.

Though, that obscure name is no SHASH. All SHASH keyed digest cipher names =
are=20
below 64 bytes.
>=20
> > Otherwise, the KDF documentation looks good.
> >=20
> > Ciao
> > Stephan



Ciao
Stephan
