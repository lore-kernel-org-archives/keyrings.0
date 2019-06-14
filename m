From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 14 Jun 2019 11:04:58 +0000
Subject: Re: [PATCH, RFC 13/62] x86/mm: Add hooks to allocate and free encrypted pages
Message-Id: <20190614110458.GN3463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-14-kirill.shutemov@linux.intel.com>
 <20190614093409.GX3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190614093409.GX3436@hirez.programming.kicks-ass.net>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:34:09AM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:43:33PM +0300, Kirill A. Shutemov wrote:
> 
> > +		lookup_page_ext(page)->keyid = keyid;

> > +		lookup_page_ext(page)->keyid = 0;

Also, perhaps paranoid; but do we want something like:

static inline void page_set_keyid(struct page *page, int keyid)
{
	/* ensure nothing creeps after changing the keyid */
	barrier();
	WRITE_ONCE(lookup_page_ext(page)->keyid, keyid);
	barrier();
	/* ensure nothing creeps before changing the keyid */
}

And this is very much assuming there is no concurrency through the
allocator locks.
