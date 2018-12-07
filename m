From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 07 Dec 2018 23:53:16 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <CALCETrWHqE-H1jTJY-ApuuLt5cyZ3N1UdgH+szgYm+7mUMZ2pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com> <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
 <1544147742.28511.18.camel@intel.com>
In-Reply-To: <1544147742.28511.18.camel@intel.com>
To: kai.huang@intel.com
Cc: Andrew Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, James Morris <jmorris@namei.org>, Peter Zijlstra <peterz@infradead.org>, keyrings@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux-MM <linux-mm@kvack.org>, David Howells <dhowells@redhat.com>, LSM List <linux-security-module@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>, Borislav Petkov <bp@alien8.de>, Alison Schofield <alison.schofield@intel.com>, Jun Nakajima <jun.nakajima@intel.com>

> On Dec 6, 2018, at 5:55 PM, Huang, Kai <kai.huang@intel.com> wrote:
>
>
>>
>> TME itself provides a ton of protection -- you can't just barge into
>> the datacenter, refrigerate the DIMMs, walk away with them, and read
>> off everyone's data.
>>
>> Am I missing something?
>
> I think we can make such assumption in most cases, but I think it's better that we don't make any
> assumption at all. For example, the admin of data center (or anyone) who has physical access to
> servers may do something malicious. I am not expert but there should be other physical attack
> methods besides coldboot attack, if the malicious employee can get physical access to server w/o
> being detected.
>
>>
>>>
>>> But, I think what you're implying is that the security properties of
>>> user-supplied keys can only be *worse* than using CPU-generated keys
>>> (assuming the CPU does a good job generating it).  So, why bother
>>> allowing user-specified keys in the first place?
>>
>> That too :)
>
> I think one usage of user-specified key is for NVDIMM, since CPU key will be gone after machine
> reboot, therefore if NVDIMM is encrypted by CPU key we are not able to retrieve it once
> shutdown/reboot, etc.
>
> There are some other use cases that already require tenant to send key to CSP. For example, the VM
> image can be provided by tenant and encrypted by tenant's own key, and tenant needs to send key to
> CSP when asking CSP to run that encrypted image.


I can imagine a few reasons why one would want to encrypt one’s image.
For example, the CSP could issue a public key and state, or even
attest, that the key is wrapped and locked to particular PCRs of their
TPM or otherwise protected by an enclave that verifies that the key is
only used to decrypt the image for the benefit of a hypervisor.

I don’t see what MKTME has to do with this.  The only remotely
plausible way I can see to use MKTME for this is to have the
hypervisor load a TPM (or other enclave) protected key into an MKTME
user key slot and to load customer-provided ciphertext into the
corresponding physical memory (using an MKTME no-encrypt slot).  But
this has three major problems.  First, it's effectively just a fancy
way to avoid one AES pass over the data.  Second, sensible scheme for
this type of VM image protection would use *authenticated* encryption
or at least verify a signature, which MKTME can't do.  The third
problem is the real show-stopper, though: this scheme requires that
the ciphertext go into predetermined physical addresses, which would
be a giant mess.
