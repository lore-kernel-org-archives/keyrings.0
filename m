From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 13 May 2019 14:27:39 +0000
Subject: Re: [PATCH, RFC 03/62] mm/ksm: Do not merge pages with different KeyIDs
Message-Id: <20190513142739.7v3cnrnnnsdldcuc@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-4-kirill.shutemov@linux.intel.com>
 <1697adad-6ae2-ea85-bab5-0144929ed2d9@intel.com>
In-Reply-To: <1697adad-6ae2-ea85-bab5-0144929ed2d9@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 06:07:11PM +0000, Dave Hansen wrote:
> On 5/8/19 7:43 AM, Kirill A. Shutemov wrote:
> > KeyID indicates what key to use to encrypt and decrypt page's content.
> > Depending on the implementation a cipher text may be tied to physical
> > address of the page. It means that pages with an identical plain text
> > would appear different if KSM would look at a cipher text. It effectively
> > disables KSM for encrypted pages.
> > 
> > In addition, some implementations may not allow to read cipher text at all.
> > 
> > KSM compares plain text instead (transparently to KSM code).
> > 
> > But we still need to make sure that pages with identical plain text will
> > not be merged together if they are encrypted with different keys.
> > 
> > To make it work kernel only allows merging pages with the same KeyID.
> > The approach guarantees that the merged page can be read by all users.
> 
> I can't really parse this description.  Can I suggest replacement text?

Sure.

-- 
 Kirill A. Shutemov
