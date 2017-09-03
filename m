From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Sun, 03 Sep 2017 00:43:57 +0000
Subject: Re: [RFC PATCH 4/5] keyctl.2: document the ability to provide KDF parameters in KEYCTL_DH_COMPUTE
Message-Id: <82a9a90c-86b9-9c90-f873-c679b9f77791@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20170831155836.GA5257@asgard.redhat.com>
 <1638688.g8nhH00jlV@tauon.chronox.de>
 <CACGkJdveSTUSYXEWzRCAXPF1nwhbtUeH2LsaoYpDGJ_FfyesTQ@mail.gmail.com>
 <3012446.sSctSvPOAs@tauon.chronox.de>
 <CACGkJduHdKeJApsmCP-GC0BhvyqHn49EztZZxGY5LOdTwRMYtg@mail.gmail.com>
In-Reply-To: <CACGkJduHdKeJApsmCP-GC0BhvyqHn49EztZZxGY5LOdTwRMYtg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Eugene Syromyatnikov <evgsyr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/31/2017 06:32 PM, Eugene Syromyatnikov wrote:
> On Thu, Aug 31, 2017 at 4:21 PM, Stephan Mueller <smueller@chronox.de> wr=
ote:
>> Am Donnerstag, 31. August 2017, 18:17:09 CEST schrieb Eugene Syromyatnik=
ov:
>>
>> Hi Eugene,
>>
>>> On Thu, Aug 31, 2017 at 6:07 PM, Stephan Mueller <smueller@chronox.de>
>> wrote:
>>>> Am Donnerstag, 31. August 2017, 17:58:36 CEST schrieb Eugene
>>>> Syromyatnikov:
>>>>
>>>> Hi Eugene,
>>>>
>>>>> +field is a null-terminated string no longer than
>>>>> +.B CRYPTO_MAX_ALG_NAME
>>>>> +(128 bytes as of this writing) which specifies hash name
>>>>
>>>> Is it necessary to specify that size? Note, up to 4.11 it was 64 bytes.
>>>> Also, it must be a valid cipher name as mentioned. Thus, I do not think
>>>> the size is relevant here considering the requirement to use a proper
>>>> name.
>>>
>>> Right, it's probably more important for syscall decoding, but not for
>>> the documentation. However, my understanding is that cipher template
>>> can be specified (like "rfc4106(gcm(aes))"), and I'm not sure how deep
>>> this nesting can be and whether it is possible to reach algorithm name
>>> limit this way (by employing the usage of driver name instead of
>>> common name, for example=E2=80=94as I understood, it is also possible).=
 It
>>> probably makes more sense to just mention this limit in the ERRORS
>>> section instead.
>>
>> CRYPTO_MAX_ALG_NAME is given a size that all allowed cipher names can be
>> represented.
>>
>> Somehow in the 4.12 release cycle, somebody found a very obscure yet val=
id
>> name for a symmetric cipher that exceeded the 64 byte limit causing the =
bump
>> to 128 bytes.
>>
>> Though, that obscure name is no SHASH. All SHASH keyed digest cipher nam=
es are
>> below 64 bytes.
>=20
> I see. Thanks for the clarification!

Hi Eugene,

So, should I expect a new version of this patch?

Cheers,

Michael



--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
