From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 18 Jun 2019 09:12:46 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <20190618091246.GM3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CALCETrVCdp4LyCasvGkc0+S6fvS+dna=_ytLdDPuD2xeAr5c-w@mail.gmail.com>
 <3c658cce-7b7e-7d45-59a0-e17dae986713@intel.com>
 <CALCETrUPSv4Xae3iO+2i_HecJLfx4mqFfmtfp+cwBdab8JUZrg@mail.gmail.com>
 <5cbfa2da-ba2e-ed91-d0e8-add67753fc12@intel.com>
 <CALCETrWFXSndmPH0OH4DVVrAyPEeKUUfNwo_9CxO-3xy9awq0g@mail.gmail.com>
 <1560816342.5187.63.camel@linux.intel.com>
 <CALCETrVcrPYUUVdgnPZojhJLgEhKv5gNqnT6u2nFVBAZprcs5g@mail.gmail.com>
 <1560821746.5187.82.camel@linux.intel.com>
 <CALCETrUrFTFGhRMuNLxD9G9=GsR6U-THWn4AtminR_HU-nBj+Q@mail.gmail.com>
 <1560824611.5187.100.camel@linux.intel.com>
In-Reply-To: <1560824611.5187.100.camel@linux.intel.com>
To: Kai Huang <kai.huang@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>, keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>

On Tue, Jun 18, 2019 at 02:23:31PM +1200, Kai Huang wrote:
> Assuming I am understanding the context correctly, yes from this perspective it seems having
> sys_encrypt is annoying, and having ENCRYPT_ME should be better. But Dave said "nobody is going to
> do what you suggest in the ptr1/ptr2 example"? 

You have to phrase that as: 'nobody who knows what he's doing is going
to do that', which leaves lots of people and fuzzers.

Murphy states that if it is possible, someone _will_ do it. And this
being something that causes severe data corruption on persistent
storage,...
