From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 31 Aug 2017 16:17:09 +0000
Subject: Re: [RFC PATCH 4/5] keyctl.2: document the ability to provide KDF parameters in KEYCTL_DH_COMPUTE
Message-Id: <CACGkJdveSTUSYXEWzRCAXPF1nwhbtUeH2LsaoYpDGJ_FfyesTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20170831155836.GA5257@asgard.redhat.com> <1638688.g8nhH00jlV@tauon.chronox.de>
In-Reply-To: <1638688.g8nhH00jlV-b2PLbiJbNv8ftSvlWXw0+g@public.gmane.org>
To: Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>
Cc: Michael Kerrisk-manpages <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Aug 31, 2017 at 6:07 PM, Stephan Mueller <smueller@chronox.de> wrot=
e:
> Am Donnerstag, 31. August 2017, 17:58:36 CEST schrieb Eugene Syromyatniko=
v:
>
> Hi Eugene,
>
>> +field is a null-terminated string no longer than
>> +.B CRYPTO_MAX_ALG_NAME
>> +(128 bytes as of this writing) which specifies hash name
>
> Is it necessary to specify that size? Note, up to 4.11 it was 64 bytes. A=
lso,
> it must be a valid cipher name as mentioned. Thus, I do not think the siz=
e is
> relevant here considering the requirement to use a proper name.

Right, it's probably more important for syscall decoding, but not for
the documentation. However, my understanding is that cipher template
can be specified (like "rfc4106(gcm(aes))"), and I'm not sure how deep
this nesting can be and whether it is possible to reach algorithm name
limit this way (by employing the usage of driver name instead of
common name, for example=E2=80=94as I understood, it is also possible). It
probably makes more sense to just mention this limit in the ERRORS
section instead.

> Otherwise, the KDF documentation looks good.
>
> Ciao
> Stephan



--=20
Eugene Syromyatnikov
mailto:evgsyr@gmail.com
xmpp:esyr@jabber.{ru|org}
