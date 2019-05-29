From: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 29 May 2019 18:12:11 +0000
Subject: Re: [PATCH, RFC 43/62] syscall/x86: Wire up a system call for MKTME encryption keys
Message-Id: <20190529181211.GA32533@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-44-kirill.shutemov@linux.intel.com>
 <20190529072136.GD3656@rapoport-lnx>
In-Reply-To: <20190529072136.GD3656@rapoport-lnx>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:21:37AM +0300, Mike Rapoport wrote:
> On Wed, May 08, 2019 at 05:44:03PM +0300, Kirill A. Shutemov wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > encrypt_mprotect() is a new system call to support memory encryption.
> > 
> > It takes the same parameters as legacy mprotect, plus an additional
> > key serial number that is mapped to an encryption keyid.
> 
> Shouldn't this patch be after the encrypt_mprotect() is added?

COND_SYSCALL(encrypt_mprotect) defined in kernel/sys_ni.c, allowed
it to build in this order, but the order is not logical. Thanks for
pointing it out. I will reorder the two patches.

Alison
