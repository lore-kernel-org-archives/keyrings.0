From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Sun, 03 Sep 2017 01:41:38 +0000
Subject: Re: [RFC PATCH 4/5] keyctl.2: document the ability to provide KDF parameters in KEYCTL_DH_COMPUTE
Message-Id: <CACGkJdtNaU8t1_9nm-MnEq850jV1hHKEwpKY2ud+XNAdG1ejhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20170831155836.GA5257@asgard.redhat.com> <1638688.g8nhH00jlV@tauon.chronox.de>
 <CACGkJdveSTUSYXEWzRCAXPF1nwhbtUeH2LsaoYpDGJ_FfyesTQ@mail.gmail.com>
 <3012446.sSctSvPOAs@tauon.chronox.de> <CACGkJduHdKeJApsmCP-GC0BhvyqHn49EztZZxGY5LOdTwRMYtg@mail.gmail.com>
 <82a9a90c-86b9-9c90-f873-c679b9f77791@gmail.com>
In-Reply-To: <82a9a90c-86b9-9c90-f873-c679b9f77791-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Sep 3, 2017 at 2:43 AM, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 08/31/2017 06:32 PM, Eugene Syromyatnikov wrote:
>> On Thu, Aug 31, 2017 at 4:21 PM, Stephan Mueller <smueller@chronox.de> wrote:
>>> Am Donnerstag, 31. August 2017, 18:17:09 CEST schrieb Eugene Syromyatnikov:
>>>
>>> Hi Eugene,
>>>
>>>> On Thu, Aug 31, 2017 at 6:07 PM, Stephan Mueller <smueller@chronox.de>
>>> wrote:
>>>>> Am Donnerstag, 31. August 2017, 17:58:36 CEST schrieb Eugene
>>>>> Syromyatnikov:
>>>>>
>>>>> Hi Eugene,
>>>>>
>>>>>> +field is a null-terminated string no longer than
>>>>>> +.B CRYPTO_MAX_ALG_NAME
>>>>>> +(128 bytes as of this writing) which specifies hash name
>>>>>
>>>>> Is it necessary to specify that size? Note, up to 4.11 it was 64 bytes.
>>>>> Also, it must be a valid cipher name as mentioned. Thus, I do not think
>>>>> the size is relevant here considering the requirement to use a proper
>>>>> name.
>>>>
>>>> Right, it's probably more important for syscall decoding, but not for
>>>> the documentation. However, my understanding is that cipher template
>>>> can be specified (like "rfc4106(gcm(aes))"), and I'm not sure how deep
>>>> this nesting can be and whether it is possible to reach algorithm name
>>>> limit this way (by employing the usage of driver name instead of
>>>> common name, for example—as I understood, it is also possible). It
>>>> probably makes more sense to just mention this limit in the ERRORS
>>>> section instead.
>>>
>>> CRYPTO_MAX_ALG_NAME is given a size that all allowed cipher names can be
>>> represented.
>>>
>>> Somehow in the 4.12 release cycle, somebody found a very obscure yet valid
>>> name for a symmetric cipher that exceeded the 64 byte limit causing the bump
>>> to 128 bytes.
>>>
>>> Though, that obscure name is no SHASH. All SHASH keyed digest cipher names are
>>> below 64 bytes.
>>
>> I see. Thanks for the clarification!
>
> Hi Eugene,
>
> So, should I expect a new version of this patch?
Well, this change is incorporated in v2—I decided just to mention that
in case syscall failed due to exceed in hashname size, syscall fails
with EINVAL (and no with ENOENT, for example, when no algorithm with
the provided name found):

+.B EINVAL
+.I operation
+was
+.B KEYCTL_DH_COMPUTE
+and the hash name provided in the
+.B hashname
+field of the
+.B struct keyctl_kdf_params
+pointed by
+.I arg5
+argument is too big (the limit is implementation-specific and varies between
+kernel versions, but it is deemed big enough for all valid algorithm names).

-- 
Eugene Syromyatnikov
mailto:evgsyr@gmail.com
xmpp:esyr@jabber.{ru|org}
