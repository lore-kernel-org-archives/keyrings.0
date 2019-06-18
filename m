From: Dave Hansen <dave.hansen@intel.com>
Date: Tue, 18 Jun 2019 16:22:10 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <f701f859-0990-9f02-baa2-451dd6c8b3c4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CALCETrUPSv4Xae3iO+2i_HecJLfx4mqFfmtfp+cwBdab8JUZrg@mail.gmail.com>
 <5cbfa2da-ba2e-ed91-d0e8-add67753fc12@intel.com>
 <CALCETrWFXSndmPH0OH4DVVrAyPEeKUUfNwo_9CxO-3xy9awq0g@mail.gmail.com>
 <1560816342.5187.63.camel@linux.intel.com>
 <CALCETrVcrPYUUVdgnPZojhJLgEhKv5gNqnT6u2nFVBAZprcs5g@mail.gmail.com>
 <1560821746.5187.82.camel@linux.intel.com>
 <CALCETrUrFTFGhRMuNLxD9G9=GsR6U-THWn4AtminR_HU-nBj+Q@mail.gmail.com>
 <1560824611.5187.100.camel@linux.intel.com>
 <20190618091246.GM3436@hirez.programming.kicks-ass.net>
 <2ec26c05-7c57-d0e0-a628-94d581b96b63@intel.com>
 <20190618161502.jiuqhvs3wvnac5ow@box.shutemov.name>
In-Reply-To: <20190618161502.jiuqhvs3wvnac5ow@box.shutemov.name>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Peter Zijlstra <peterz@infradead.org>, Kai Huang <kai.huang@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>, keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>

On 6/18/19 9:15 AM, Kirill A. Shutemov wrote:
>> We'd need two rules:
>> 1. A page must not be faulted into a VMA if the page's page_keyid()
>>    is not consistent with the VMA's
>> 2. Upon changing the VMA's KeyID, all underlying PTEs must either be
>>    checked or zapped.
>>
>> If the rules are broken, we SIGBUS.  Andy's suggestion has the same
>> basic requirements.  But, with his scheme, the error can be to the
>> ioctl() instead of in the form of a SIGBUS.  I guess that makes the
>> fuzzers' lives a bit easier.
> I see a problem with the scheme: if we don't have a way to decide if the
> key is right for the file, user without access to the right key is able to
> prevent legitimate user from accessing the file. Attacker just need read
> access to the encrypted file to prevent any legitimate use to access it.

I think you're bringing up a separate issue.

We were talking about how you resolve a conflict when someone attempts
to use two *different* keyids to decrypt the data in the API and what
the resulting API interaction looks like.

You're describing the situation where one of those is the wrong *key*
(not keyid).  That's a subtly different scenario and requires different
handling (or no handling IMNHO).
