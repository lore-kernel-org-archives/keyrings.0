From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Tue, 18 Jun 2019 16:15:02 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <20190618161502.jiuqhvs3wvnac5ow@box.shutemov.name>
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
In-Reply-To: <2ec26c05-7c57-d0e0-a628-94d581b96b63@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Kai Huang <kai.huang@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>, keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>

On Tue, Jun 18, 2019 at 07:09:36AM -0700, Dave Hansen wrote:
> On 6/18/19 2:12 AM, Peter Zijlstra wrote:
> > On Tue, Jun 18, 2019 at 02:23:31PM +1200, Kai Huang wrote:
> >> Assuming I am understanding the context correctly, yes from this perspective it seems having
> >> sys_encrypt is annoying, and having ENCRYPT_ME should be better. But Dave said "nobody is going to
> >> do what you suggest in the ptr1/ptr2 example"? 
> > 
> > You have to phrase that as: 'nobody who knows what he's doing is going
> > to do that', which leaves lots of people and fuzzers.
> > 
> > Murphy states that if it is possible, someone _will_ do it. And this
> > being something that causes severe data corruption on persistent
> > storage,...
> 
> I actually think it's not a big deal at all to avoid the corruption that
> would occur if it were allowed.  But, if you're even asking to map the
> same data with two different keys, you're *asking* for data corruption.
>  What we're doing here is continuing to  preserve cache coherency and
> ensuring an early failure.
> 
> We'd need two rules:
> 1. A page must not be faulted into a VMA if the page's page_keyid()
>    is not consistent with the VMA's
> 2. Upon changing the VMA's KeyID, all underlying PTEs must either be
>    checked or zapped.
> 
> If the rules are broken, we SIGBUS.  Andy's suggestion has the same
> basic requirements.  But, with his scheme, the error can be to the
> ioctl() instead of in the form of a SIGBUS.  I guess that makes the
> fuzzers' lives a bit easier.

I see a problem with the scheme: if we don't have a way to decide if the
key is right for the file, user without access to the right key is able to
prevent legitimate user from accessing the file. Attacker just need read
access to the encrypted file to prevent any legitimate use to access it.

The problem applies to ioctl() too.

To make sense of it we must have a way to distinguish right key from
wrong. I don't see obvious solution with the current hardware design.

-- 
 Kirill A. Shutemov
