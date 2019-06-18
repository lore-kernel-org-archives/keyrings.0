From: Dave Hansen <dave.hansen@intel.com>
Date: Tue, 18 Jun 2019 14:19:46 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <8dc08b4c-82ee-8458-6941-248141afa2a3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-46-kirill.shutemov@linux.intel.com>
 <CALCETrVCdp4LyCasvGkc0+S6fvS+dna=_ytLdDPuD2xeAr5c-w@mail.gmail.com>
 <3c658cce-7b7e-7d45-59a0-e17dae986713@intel.com>
 <CALCETrUPSv4Xae3iO+2i_HecJLfx4mqFfmtfp+cwBdab8JUZrg@mail.gmail.com>
 <5cbfa2da-ba2e-ed91-d0e8-add67753fc12@intel.com>
 <CALCETrWFXSndmPH0OH4DVVrAyPEeKUUfNwo_9CxO-3xy9awq0g@mail.gmail.com>
 <d599b1d7-9455-3012-0115-96ddbad31833@intel.com>
 <1560818931.5187.70.camel@linux.intel.com>
 <CALCETrXNCmSnrTwGiwuF9=wLu797WBPZ0gt92D-CyU+V3sq7hA@mail.gmail.com>
In-Reply-To: <CALCETrXNCmSnrTwGiwuF9=wLu797WBPZ0gt92D-CyU+V3sq7hA@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>, Kai Huang <kai.huang@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>, keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>

On 6/17/19 6:50 PM, Andy Lutomirski wrote:
> I'm also wondering whether the kernel will always be able to be a
> one-stop shop for key allocation -- if the MKTME hardware gains
> interesting new uses down the road, who knows how key allocation will
> work?

I can't share all the details on LKML, of course, but I can at least say
that this model of allocating KeyID slots will continue to be used for a
number of generations.
