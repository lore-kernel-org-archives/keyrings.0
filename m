From: Dave Hansen <dave.hansen@intel.com>
Date: Mon, 17 Jun 2019 15:28:27 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <3c658cce-7b7e-7d45-59a0-e17dae986713@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-46-kirill.shutemov@linux.intel.com>
 <CALCETrVCdp4LyCasvGkc0+S6fvS+dna=_ytLdDPuD2xeAr5c-w@mail.gmail.com>
In-Reply-To: <CALCETrVCdp4LyCasvGkc0+S6fvS+dna=_ytLdDPuD2xeAr5c-w@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>, keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 6/17/19 8:07 AM, Andy Lutomirski wrote:
> I still find it bizarre that this is conflated with mprotect().

This needs to be in the changelog.  But, for better or worse, it's
following the mprotect_pkey() pattern.

Other than the obvious "set the key on this memory", we're looking for
two other properties: atomicity (ensuring there is no transient state
where the memory is usable without the desired properties) and that it
is usable on existing allocations.

For atomicity, we have a model where we can allocate things with
PROT_NONE, then do mprotect_pkey() and mprotect_encrypt() (plus any
future features), then the last mprotect_*() call takes us from
PROT_NONE to the desired end permisions.  We could just require a plain
old mprotect() to do that instead of embedding mprotect()-like behavior
in these, of course, but that isn't the path we're on at the moment with
mprotect_pkey().

So, for this series it's just a matter of whether we do this:

	ptr = mmap(..., PROT_NONE);
	mprotect_pkey(protect_key, ptr, PROT_NONE);
	mprotect_encrypt(encr_key, ptr, PROT_READ|PROT_WRITE);
	// good to go

or this:

	ptr = mmap(..., PROT_NONE);
	mprotect_pkey(protect_key, ptr, PROT_NONE);
	sys_encrypt(key, ptr);
	mprotect(ptr, PROT_READ|PROT_WRITE);
	// good to go

I actually don't care all that much which one we end up with.  It's not
like the extra syscall in the second options means much.

> This is part of why I much prefer the idea of making this style of
> MKTME a driver or some other non-intrusive interface.  Then, once
> everyone gets tired of it, the driver can just get turned off with no
> side effects.

I like the concept, but not where it leads.  I'd call it the 'hugetlbfs
approach". :)  Hugetblfs certainly go us huge pages, but it's continued
to be a parallel set of code with parallel bugs and parallel
implementations of many VM features.  It's not that you can't implement
new things on hugetlbfs, it's that you *need* to.  You never get them
for free.

For instance, if we do a driver, how do we get large pages?  How do we
swap/reclaim the pages?  How do we do NUMA affinity?  How do we
eventually stack it on top of persistent memory filesystems or Device
DAX?  With a driver approach, I think we're stuck basically
reimplementing things or gluing them back together.  Nothing comes for free.

With this approach, we basically start with our normal, full feature set
(modulo weirdo interactions like with KSM).
