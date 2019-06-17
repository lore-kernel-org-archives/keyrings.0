From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 17 Jun 2019 15:07:29 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <CALCETrVCdp4LyCasvGkc0+S6fvS+dna=_ytLdDPuD2xeAr5c-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com> <20190508144422.13171-46-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-46-kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>, keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, May 8, 2019 at 7:44 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> Implement memory encryption for MKTME (Multi-Key Total Memory
> Encryption) with a new system call that is an extension of the
> legacy mprotect() system call.
>
> In encrypt_mprotect the caller must pass a handle to a previously
> allocated and programmed MKTME encryption key. The key can be
> obtained through the kernel key service type "mktme". The caller
> must have KEY_NEED_VIEW permission on the key.
>
> MKTME places an additional restriction on the protected data:
> The length of the data must be page aligned. This is in addition
> to the existing mprotect restriction that the addr must be page
> aligned.

I still find it bizarre that this is conflated with mprotect().

I also remain entirely unconvinced that MKTME on anonymous memory is
useful in the long run.  There will inevitably be all kinds of fancy
new CPU features that make the underlying MKTME mechanisms much more
useful.  For example, some way to bind a key to a VM, or a way to
*sanely* encrypt persistent memory.  By making this thing a syscall
that does more than just MKTME, you're adding combinatorial complexity
(you forget pkey!) and you're tying other functionality (change of
protection) to this likely-to-be-deprecated interface.

This is part of why I much prefer the idea of making this style of
MKTME a driver or some other non-intrusive interface.  Then, once
everyone gets tired of it, the driver can just get turned off with no
side effects.

--Andy
