From: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 05 Dec 2018 05:28:03 +0000
Subject: Re: [RFC v2 07/13] x86/mm: Add helpers for reference counting encrypted VMAs
Message-Id: <20181205052802.GA18596@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <e4407d95c74300c4a6b4c5f9321660e9097fff8f.1543903910.git.alison.schofield@intel.com>
 <20181204085835.GO11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181204085835.GO11614@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Tue, Dec 04, 2018 at 09:58:35AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 03, 2018 at 11:39:54PM -0800, Alison Schofield wrote:
> 
> > +void vma_put_encrypt_ref(struct vm_area_struct *vma)
> > +{
> > +	if (vma_keyid(vma))
> > +		if (refcount_dec_and_test(&encrypt_count[vma_keyid(vma)])) {
> > +			mktme_map_lock();
> > +			mktme_map_free_keyid(vma_keyid(vma));
> > +			mktme_map_unlock();
> > +		}
> 
> This violates CodingStyle

Got it!
Will fix this and the other instances where you noticed poorly nested
if statements. 

> > +	if (refcount_dec_and_test(&encrypt_count[keyid])) {
> > +		mktme_map_lock();
> 
> That smells like it wants to use refcount_dec_and_lock() instead.
> 
> Also, if you write that like:
> 
> 	if (!refcount_dec_and_lock(&encrypt_count[keyid], &lock))
> 		return;
> 
> you loose an indent level.
Looks good! I need to make sure it's OK to switch to a spinlock to use
the *_lock functions.
