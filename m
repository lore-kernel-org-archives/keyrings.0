From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 08 May 2019 16:58:30 +0000
Subject: Re: [PATCH, RFC 52/62] x86/mm: introduce common code for mem encryption
Message-Id: <20190508165830.GA11815@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-53-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-53-kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:44:12PM +0300, Kirill A. Shutemov wrote:
> +EXPORT_SYMBOL_GPL(__mem_encrypt_dma_set);
> +
> +phys_addr_t __mem_encrypt_dma_clear(phys_addr_t paddr)
> +{
> +	if (sme_active())
> +		return __sme_clr(paddr);
> +
> +	return paddr & ~mktme_keyid_mask;
> +}
> +EXPORT_SYMBOL_GPL(__mem_encrypt_dma_clear);

In general nothing related to low-level dma address should ever
be exposed to modules.  What is your intended user for these two?
