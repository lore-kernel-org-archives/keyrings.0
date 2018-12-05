From: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 05 Dec 2018 05:30:20 +0000
Subject: Re: [RFC v2 09/13] mm: Restrict memory encryption to anonymous VMA's
Message-Id: <20181205053020.GB18596@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <0b294e74f06a0d6bee51efcd7b0eb1f20b00babe.1543903910.git.alison.schofield@intel.com>
 <20181204091044.GP11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181204091044.GP11614@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Tue, Dec 04, 2018 at 10:10:44AM +0100, Peter Zijlstra wrote:
> > + * Encrypted mprotect is only supported on anonymous mappings.
> > + * All VMA's in the requested range must be anonymous. If this
> > + * test fails on any single VMA, the entire mprotect request fails.
> > + */
> > +bool mem_supports_encryption(struct vm_area_struct *vma, unsigned long end)
> 
> That's a 'weird' interface and cannot do what the comment says it should
> do.

More please? With MKTME, only anonymous memory supports encryption.
Is it the naming that's weird, or you don't see it doing what it says?

> > +	struct vm_area_struct *test_vma = vma;
> 
> That variable is utterly pointless.
Got it. Will fix.

Thanks
