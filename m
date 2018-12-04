From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 04 Dec 2018 20:00:41 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <CALCETrXM_nQMFHsAfQGqqURL3=B46AXdiG+4p8Mpm6n4cOqXsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com> <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
In-Reply-To: <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
To: Andrew Lutomirski <luto@kernel.org>
Cc: alison.schofield@intel.com, Matthew Wilcox <willy@infradead.org>, Dan Williams <dan.j.williams@intel.com>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, kai.huang@intel.com, Jun Nakajima <jun.nakajima@intel.com>, "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>

On Tue, Dec 4, 2018 at 11:19 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Dec 3, 2018 at 11:37 PM Alison Schofield
> <alison.schofield@intel.com> wrote:
> >

> Finally, If you're going to teach the kernel how to have some user
> pages that aren't in the direct map, you've essentially done XPO,
> which is nifty but expensive.  And I think that doing this gets you
> essentially all the benefit of MKTME for the non-pmem use case.  Why
> exactly would any software want to use anything other than a
> CPU-managed key for anything other than pmem?
>

Let me say this less abstractly.  Here's a somewhat concrete actual
proposal.  Make a new memfd_create() flag like MEMFD_ISOLATED.  The
semantics are that the underlying pages are made not-present in the
direct map when they're allocated (which is hideously slow, but so be
it), and that anything that tries to get_user_pages() the resulting
pages fails.  And then make sure we have all the required APIs so that
QEMU can still map this stuff into a VM.

If there is indeed a situation in which MKTME-ifying the memory adds
some value, then we can consider doing that.

And maybe we get fancy and encrypt this memory when it's swapped, but
maybe we should just encrypt everything when it's swapped.
