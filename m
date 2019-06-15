From: Alison Schofield <alison.schofield@intel.com>
Date: Sat, 15 Jun 2019 00:32:31 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <20190615003231.GA15479@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-46-kirill.shutemov@linux.intel.com>
 <20190614115137.GF3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190614115137.GF3436@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:51:37PM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:44:05PM +0300, Kirill A. Shutemov wrote:
snip
> >  /*
> > - * When pkey=NO_KEY we get legacy mprotect behavior here.
> > + * do_mprotect_ext() supports the legacy mprotect behavior plus extensions
> > + * for Protection Keys and Memory Encryption Keys. These extensions are
> > + * mutually exclusive and the behavior is:
> > + *	(pkey=NO_KEY && keyid=NO_KEY) => legacy mprotect
> > + *	(pkey is valid)  => legacy mprotect plus Protection Key extensions
> > + *	(keyid is valid) => legacy mprotect plus Encryption Key extensions
> >   */
> >  static int do_mprotect_ext(unsigned long start, size_t len,
> > -		unsigned long prot, int pkey)
> > +			   unsigned long prot, int pkey, int keyid)
> >  {

snip

>
> I've missed the part where pkey && keyid results in a WARN or error or
> whatever.
> 
I wasn't so sure about that since do_mprotect_ext()
is the call 'behind' the system calls. 

legacy mprotect always calls with: NO_KEY, NO_KEY
pkey_mprotect always calls with:  pkey, NO_KEY
encrypt_mprotect always calls with  NO_KEY, keyid

Would a check on those arguments be debug only 
to future proof this?
