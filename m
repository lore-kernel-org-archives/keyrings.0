From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 04 Dec 2018 08:58:35 +0000
Subject: Re: [RFC v2 07/13] x86/mm: Add helpers for reference counting encrypted VMAs
Message-Id: <20181204085835.GO11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <e4407d95c74300c4a6b4c5f9321660e9097fff8f.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <e4407d95c74300c4a6b4c5f9321660e9097fff8f.1543903910.git.alison.schofield@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Mon, Dec 03, 2018 at 11:39:54PM -0800, Alison Schofield wrote:

> +void vma_put_encrypt_ref(struct vm_area_struct *vma)
> +{
> +	if (vma_keyid(vma))
> +		if (refcount_dec_and_test(&encrypt_count[vma_keyid(vma)])) {
> +			mktme_map_lock();
> +			mktme_map_free_keyid(vma_keyid(vma));
> +			mktme_map_unlock();
> +		}

This violates CodingStyle

> +}

> +void key_put_encrypt_ref(int keyid)
> +{
> +	if (refcount_dec_and_test(&encrypt_count[keyid])) {
> +		mktme_map_lock();

That smells like it wants to use refcount_dec_and_lock() instead.

> +		mktme_map_free_keyid(keyid);
> +		mktme_map_unlock();
> +	}
> +}

Also, if you write that like:

	if (!refcount_dec_and_lock(&encrypt_count[keyid], &lock))
		return;

you loose an indent level.
