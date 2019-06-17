From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 17 Jun 2019 09:25:31 +0000
Subject: Re: [PATCH, RFC 13/62] x86/mm: Add hooks to allocate and free encrypted pages
Message-Id: <20190617092531.GZ3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-14-kirill.shutemov@linux.intel.com>
 <20190614093409.GX3436@hirez.programming.kicks-ass.net>
 <20190614110458.GN3463@hirez.programming.kicks-ass.net>
 <20190614132836.spl6bmk2kkx65nfr@box>
 <20190614134335.GU3436@hirez.programming.kicks-ass.net>
 <20190614224131.q2gjai32la4zb42p@box>
In-Reply-To: <20190614224131.q2gjai32la4zb42p@box>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 01:41:31AM +0300, Kirill A. Shutemov wrote:
> On Fri, Jun 14, 2019 at 03:43:35PM +0200, Peter Zijlstra wrote:

> > Not really, it all 'works' because clflush_cache_range() includes mb()
> > and page_address() has an address dependency on the store, and there are
> > no other sites that will ever change 'keyid', which is all kind of
> > fragile.
> 
> Hm. I don't follow how the mb() in clflush_cache_range() relevant...
> 
> Any following access of page's memory by kernel will go through
> page_keyid() and therefore I believe there's always address dependency on
> the store.
> 
> Am I missing something?

The dependency doesn't help with prior calls; consider:

	addr = page_address(page);

	*addr = foo;

	page->key_id = bar;

	addr2 = page_address(page);


Without a barrier() between '*addr = foo' and 'page->key_id = bar', the
compiler is allowed to reorder these stores.

Now, the clflush stuff we do, that already hard orders things -- we need
to be done writing before we start flushing -- so we can/do rely on
that, but we should explicitly mention that.

Now, for the second part, addr2 must observe bar, because of the address
dependency, the compiler is not allowed mess that up, but again, that is
something we should put in a comment.
