From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 05 Dec 2018 09:07:34 +0000
Subject: Re: [RFC v2 09/13] mm: Restrict memory encryption to anonymous VMA's
Message-Id: <20181205090734.GA4234@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <0b294e74f06a0d6bee51efcd7b0eb1f20b00babe.1543903910.git.alison.schofield@intel.com>
 <20181204091044.GP11614@hirez.programming.kicks-ass.net>
 <20181205053020.GB18596@alison-desk.jf.intel.com>
In-Reply-To: <20181205053020.GB18596@alison-desk.jf.intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Tue, Dec 04, 2018 at 09:30:20PM -0800, Alison Schofield wrote:
> On Tue, Dec 04, 2018 at 10:10:44AM +0100, Peter Zijlstra wrote:
> > > + * Encrypted mprotect is only supported on anonymous mappings.
> > > + * All VMA's in the requested range must be anonymous. If this
> > > + * test fails on any single VMA, the entire mprotect request fails.
> > > + */
> > > +bool mem_supports_encryption(struct vm_area_struct *vma, unsigned long end)
> > 
> > That's a 'weird' interface and cannot do what the comment says it should
> > do.
> 
> More please? With MKTME, only anonymous memory supports encryption.
> Is it the naming that's weird, or you don't see it doing what it says?

It's weird because you don't fully speficy the range -- ie. it cannot
verify the vma argument. It is also weird because the start and end are
not of the same type -- or rather, there is no start at all.

So while the comment talks about a range, there is not in fact a range
(only the implied @start is somewhere inside @vma). The comment also
states all vmas in the range, but again, because of a lack of range
specification it cannot verify this statement.

Now, I don't necessarily object to the function and its implementation,
but that comment is just plain misleading.
