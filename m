From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Sun, 03 Sep 2017 11:17:25 +0000
Subject: Re: [RFC PATCH 4/5] keyctl.2: document the ability to provide KDF parameters in KEYCTL_DH_COMPUTE
Message-Id: <CAKgNAkhaBpcuws+EHzZT6R+PZ1xC8Vp4vxKPCWXE6TsMiq-bRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20170831155836.GA5257@asgard.redhat.com> <1638688.g8nhH00jlV@tauon.chronox.de>
 <CACGkJdveSTUSYXEWzRCAXPF1nwhbtUeH2LsaoYpDGJ_FfyesTQ@mail.gmail.com>
 <3012446.sSctSvPOAs@tauon.chronox.de> <CACGkJduHdKeJApsmCP-GC0BhvyqHn49EztZZxGY5LOdTwRMYtg@mail.gmail.com>
 <82a9a90c-86b9-9c90-f873-c679b9f77791@gmail.com> <CACGkJdtNaU8t1_9nm-MnEq850jV1hHKEwpKY2ud+XNAdG1ejhQ@mail.gmail.com>
In-Reply-To: <CACGkJdtNaU8t1_9nm-MnEq850jV1hHKEwpKY2ud+XNAdG1ejhQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Eugene Syromyatnikov <evgsyr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Eugene,

On 3 September 2017 at 03:41, Eugene Syromyatnikov <evgsyr@gmail.com> wrote:
> On Sun, Sep 3, 2017 at 2:43 AM, Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:

[...]

>> So, should I expect a new version of this patch?
> Well, this change is incorporated in v2—I decided just to mention that
> in case syscall failed due to exceed in hashname size, syscall fails
> with EINVAL (and no with ENOENT, for example, when no algorithm with
> the provided name found):

Ahhh -- yes, sorry. I confused the patch series.

Cheers,

Michael
