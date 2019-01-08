From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 08 Jan 2019 21:41:48 +0000
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate snapshot image
Message-Id: <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190103143227.9138-1-jlee@suse.com> <20190106181026.GA15256@amd> <20190107173743.GC4210@linux-l9pv.suse>
In-Reply-To: <20190107173743.GC4210@linux-l9pv.suse>
To: joeyli <jlee@suse.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>

> On Jan 7, 2019, at 9:37 AM, joeyli <jlee@suse.com> wrote:
>
> Hi Pavel,
>
> Thanks for your review!
>
>> On Sun, Jan 06, 2019 at 07:10:27PM +0100, Pavel Machek wrote:
>> Hi!
>>
>>> This patchset is the implementation of encryption and authentication
>>> for hibernate snapshot image. The image will be encrypted by AES and
>>> authenticated by HMAC.
>>
>> Ok, so you encrypt.
>
> Yes, encryption and authentication.
>
>>> The hibernate function can be used to snapshot memory pages to an image,
>>> then kernel restores the image to memory space in a appropriate time.
>>> There have secrets in snapshot image and cracker may modifies it for
>>> hacking system. Encryption and authentication of snapshot image can protect
>>> the system.
>>>
>>> Hibernate function requests the master key through key retention service.
>>> The snapshot master key can be a trusted key or a user defined key. The
>>> name of snapshot master key is fixed to "swsusp-kmk". User should loads
>>> swsusp-kmk to kernel by keyctl tool before the hibernation resume.
>>> e.g. The swsusp-kmk must be loaded before systemd-hibernate-resume
>>
>> But if userspace has a key, encryption is useless against root.
>
> Yes, but this concern is not only for hibernation encryption. This patch
> set does not provide solution against this concern.
>
> The purpose of this patch set is to encrypt and authenticate hibernate
> snapshot image in kernel space. It also requests key through keyring
> mechanism. Which means that we can easy to adapt to new key type from
> keyring in the future.
>
> Currently TPM trusted key or user defined key types are not against
> root. Even using the TPM trusted key, it still can be unsealed by root
> before the PCRs be capped (unless we capped PCRs in kernel).
>
> My solution for keeping the secret by kernel is the EFI secure key type:
>    https://lkml.org/lkml/2018/8/5/31
>
> But the EFI boot variable doesn't design for keeping secret, so Windows
> and OEM/ODM do not use boot variable to keep secret. So this idea can
> not be accepted. We must think other key type against root.
>
>>> The TPM trusted key type is preferred to be the master key. But user
>>> defined key can also be used for testing or when the platform doesn't
>>> have TPM. User must be aware that the security of user key relies on
>>> user space. If the root account be compromised, then the user key will
>>> easy to be grabbed.
>>
>> In the TPM case, does userland have access to the key?
>
> In the TPM case, userland can only touch the sealed key blob. So userland
> doesn't know the real secret. But it has risk that root unseals the key
> before PCRs be capped.
>
>> Please explain your security goals.
>
> My security goals:
>
> - Encrypt and authicate hibernate snapshot image in kernel space. Userspace
>  can only touch an encrypted and signed snapshot image.

Signed?

I’m not entirely convinced that the keyring mechanism is what you
want. ISTM that there are two goals here:

a) Encryption: it should be as hard as can reasonably be arranged to
extract secrets from a hibernation image.

b) Authentication part 1: it should not be possible for someone in
possession of a turned-off machine to tamper with the hibernation
image such that the image, when booted, will leak its secrets. This
should protect against attackers who don’t know the encryption key.

c) Authentication part 2: it should be to verify, to the extent
practical, that the image came from the same machine and was really
created using hibernation.  Or maybe by the same user.

For (a) and (b), using an AE mode where the key is protected in some
reasonable way.  Joey, why are you using HMAC?  Please tell me you’re
at least doing encrypt-then-MAC.  But why not use a real AE mode like
AES-GCM?


I reviewed the code a bit.  Here are some thoughts:

You have some really weird crypto. You’re using an insanely long key
(512 bits, I think, although you’ve used some bizarre indirection).
You’re explicitly checking that it’s not zero, and I don’t see why.

Why are you manually supporting three different key types?  Can’t you
just somehow support all key types?  And shouldn’t you be verifying
the acceptable usage of trusted keys?

You are using a non-ephemeral key and generating a fresh IV each time.
This is probably okay, but it’s needlessly fragile. Just generate an
entirely fresh key each time, please.  You also seem to be doing
encrypt-and-MAC, which is not generally considered acceptable. And
you’re not authenticating everything — just the data. This seems very
weak.

Can you explain the trampoline?  It looks like you are using it to
tell the resumed kernel that it was tampered with. If so, NAK to that.
Just abort.

You say “If the encryption key be guessed then the snapshot master key
can also be grabbed from snapshot image.”  This makes little sense. If
the encryption key is guessed, the game is over. Just remove this
patch — it seems like pure snake oil.

As far as I can tell, there is only one reason that any of this needs
to be in the kernel: if it’s all in user code, then we lose “lockdown”
protection against compromised user code on a secure boot system.  Is
that, in fact, true?
