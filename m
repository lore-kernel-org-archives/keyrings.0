From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Mon, 04 Sep 2017 12:49:52 +0000
Subject: Re: [PATCH v2 0/6] keyctl.2 updates
Message-Id: <CACGkJdsBekouwv=cziN4awsuqZuATZpBgEymg141KVCx4Ljwdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170902043958.GA27412@asgard.redhat.com> <4e885d00-bc47-5be2-f206-1de2947875b7@gmail.com>
In-Reply-To: <4e885d00-bc47-5be2-f206-1de2947875b7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Sep 3, 2017 at 1:31 PM, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> Hi Eugene,
>
> On 09/02/2017 06:39 AM, Eugene Syromyatnikov wrote:
>> Hello.
>>
>> While trying to add support for the new keyctl features (ability to
>> provide KDF and ability to restrict addition to the keyring) decoding
>> to strace, I've noticed that these are not documented, so here is
>> my initial attempt to document these things. Unfortunately, keys/crypto
>> infrastructure is quite foreign to me, so these patches definitely need
>> some improvement.
>
> I've applied the all patches. If someone has further improvements,
> hopefully they send comments/fixes.
>
>> For the one part is definitely omitted yet is the documentation for the
>> "asymmetric" key type, which should be a part of keyrings.7, I think.
>
> That makes sense. Might you prepare a patch for that?

Yes, I'm working on it, but it's not ready yet.

>> Thanks for all the feedback regarding the original version, I've tried to
>> incorporate it in this version of the patchset.
>>
>> Changes since v1:
>>  * Added additional information about causes of EAGAIN, ENOENT, and
>>    ETIMEDOUT for the KEYCTL_DH_COMPUTE operation.
>>  * Information about internal limit on hashname moved to the description
>>    of yet another cause of EINVAL for the KEYCTL_DH_COMPUTE.
>>  * The description of possible restriction specification for asymmetric
>>    key type has been corrected.
>>  * Added information about causes of ENOENT and EOPNOTSUPP for the
>>    KEYCTL_RESTRICT_KEYRING operation.
>>  * Added wildcard mention of the ENOMEM error code.
>>
>> Eugene Syromyatnikov (6):
>>   keyctl.2: change "is" to "was" in error descriptions
>>   keyctl.2: update kernel documentation path reference
>>   keyrings.7: add pointers to kernel's documentation
>>   keyctl.2: document the ability to provide KDF parameters in
>>     KEYCTL_DH_COMPUTE
>>   keyctl.2: document KEYCTL_RESTRICT_KEYRING operation
>>   keyctl.2: mention ENOMEM in ERRORS
>>
>>  man2/keyctl.2   | 289 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>  man7/keyrings.7 |   5 +
>>  2 files changed, 282 insertions(+), 12 deletions(-)
>
> So, I think everything that you sent has now been applied. Let me know if
> I mussed anything.

Everything looks fine, thanks.

-- 
Eugene Syromyatnikov
mailto:evgsyr@gmail.com
xmpp:esyr@jabber.{ru|org}
