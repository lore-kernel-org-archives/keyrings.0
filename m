From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 17 Jun 2019 09:30:54 +0000
Subject: Re: [PATCH, RFC 20/62] mm/page_ext: Export lookup_page_ext() symbol
Message-Id: <20190617093054.GB3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-21-kirill.shutemov@linux.intel.com>
 <20190614111259.GA3436@hirez.programming.kicks-ass.net>
 <20190614224443.qmqolaigu5wnf75p@box>
In-Reply-To: <20190614224443.qmqolaigu5wnf75p@box>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 01:44:43AM +0300, Kirill A. Shutemov wrote:
> On Fri, Jun 14, 2019 at 01:12:59PM +0200, Peter Zijlstra wrote:
> > On Wed, May 08, 2019 at 05:43:40PM +0300, Kirill A. Shutemov wrote:
> > > page_keyid() is inline funcation that uses lookup_page_ext(). KVM is
> > > going to use page_keyid() and since KVM can be built as a module
> > > lookup_page_ext() has to be exported.
> > 
> > I _really_ hate having to export world+dog for KVM. This one might not
> > be a real issue, but I itch every time I see an export for KVM these
> > days.
> 
> Is there any better way? Do we need to invent EXPORT_SYMBOL_KVM()? :P

Or disallow KVM (or parts thereof) from being a module anymore.
