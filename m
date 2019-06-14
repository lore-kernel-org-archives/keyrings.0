From: Alison Schofield <alison.schofield@intel.com>
Date: Fri, 14 Jun 2019 17:10:25 +0000
Subject: Re: [PATCH, RFC 26/62] keys/mktme: Move the MKTME payload into a cache aligned structure
Message-Id: <20190614171025.GA5917@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-27-kirill.shutemov@linux.intel.com>
 <20190614113523.GC3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190614113523.GC3436@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:35:23PM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:43:46PM +0300, Kirill A. Shutemov wrote:
> 
> > +/* Copy the payload to the HW programming structure and program this KeyID */
> > +static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
> > +{
> > +	struct mktme_key_program *kprog = NULL;
> > +	int ret;
> > +
> > +	kprog = kmem_cache_zalloc(mktme_prog_cache, GFP_ATOMIC);
> 
> Why GFP_ATOMIC, afaict neither of the usage is with a spinlock held.

Got it. GFP_ATOMIC not needed.
That said, this is an artifact of reworking the locking, and that 
locking may need to change again. If it does, will try to pre-allocate
rather than depend on GFP_ATOMIC here.

> 
> > +	if (!kprog)
> > +		return -ENOMEM;
> > +
> > +	/* Hardware programming requires cached aligned struct */
> > +	kprog->keyid = keyid;
> > +	kprog->keyid_ctrl = payload->keyid_ctrl;
> > +	memcpy(kprog->key_field_1, payload->data_key, MKTME_AES_XTS_SIZE);
> > +	memcpy(kprog->key_field_2, payload->tweak_key, MKTME_AES_XTS_SIZE);
> > +
> > +	ret = MKTME_PROG_SUCCESS;	/* Future programming call */
> > +	kmem_cache_free(mktme_prog_cache, kprog);
> > +	return ret;
> > +}
