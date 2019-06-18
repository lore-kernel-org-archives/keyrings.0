From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 18 Jun 2019 01:40:31 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <CALCETrWq98--AgXXj=h1R70CiCWNncCThN2fEdxj2ZkedMw6=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-46-kirill.shutemov@linux.intel.com> <CALCETrVCdp4LyCasvGkc0+S6fvS+dna=_ytLdDPuD2xeAr5c-w@mail.gmail.com>
 <3c658cce-7b7e-7d45-59a0-e17dae986713@intel.com> <CALCETrUPSv4Xae3iO+2i_HecJLfx4mqFfmtfp+cwBdab8JUZrg@mail.gmail.com>
 <5cbfa2da-ba2e-ed91-d0e8-add67753fc12@intel.com> <1560815959.5187.57.camel@linux.intel.com>
 <cbbc6af7-36f8-a81f-48b1-2ad4eefc2417@amd.com>
In-Reply-To: <cbbc6af7-36f8-a81f-48b1-2ad4eefc2417@amd.com>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Kai Huang <kai.huang@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Jun 17, 2019 at 6:34 PM Lendacky, Thomas
<Thomas.Lendacky@amd.com> wrote:
>
> On 6/17/19 6:59 PM, Kai Huang wrote:
> > On Mon, 2019-06-17 at 11:27 -0700, Dave Hansen wrote:

> >
> > And yes from my reading (better to have AMD guys to confirm) SEV guest uses anonymous memory, but it
> > also pins all guest memory (by calling GUP from KVM -- SEV specifically introduced 2 KVM ioctls for
> > this purpose), since SEV architecturally cannot support swapping, migraiton of SEV-encrypted guest
> > memory, because SME/SEV also uses physical address as "tweak", and there's no way that kernel can
> > get or use SEV-guest's memory encryption key. In order to swap/migrate SEV-guest memory, we need SGX
> > EPC eviction/reload similar thing, which SEV doesn't have today.
>
> Yes, all the guest memory is currently pinned by calling GUP when creating
> an SEV guest.

Ick.

What happens if QEMU tries to read the memory?  Does it just see
ciphertext?  Is cache coherency lost if QEMU writes it?
