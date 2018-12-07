From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Fri, 07 Dec 2018 11:57:13 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
In-Reply-To: <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
To: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>, "luto@kernel.org" <luto@kernel.org>, "willy@infradead.org" <willy@infradead.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "jmorris@namei.org" <jmorris@namei.org>, "peterz@infradead.org" <peterz@infradead.org>, "Huang, Kai" <kai.huang@intel.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Hansen, Dave" <dave.hansen@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>

On Wed, Dec 05, 2018 at 10:19:20PM +0000, Sakkinen, Jarkko wrote:
> On Tue, 2018-12-04 at 11:19 -0800, Andy Lutomirski wrote:
> > I'm not Thomas, but I think it's the wrong direction.  As it stands,
> > encrypt_mprotect() is an incomplete version of mprotect() (since it's
> > missing the protection key support), and it's also functionally just
> > MADV_DONTNEED.  In other words, the sole user-visible effect appears
> > to be that the existing pages are blown away.  The fact that it
> > changes the key in use doesn't seem terribly useful, since it's
> > anonymous memory, and the most secure choice is to use CPU-managed
> > keying, which appears to be the default anyway on TME systems.  It
> > also has totally unclear semantics WRT swap, and, off the top of my
> > head, it looks like it may have serious cache-coherency issues and
> > like swapping the pages might corrupt them, both because there are no
> > flushes and because the direct-map alias looks like it will use the
> > default key and therefore appear to contain the wrong data.
> > 
> > I would propose a very different direction: don't try to support MKTME
> > at all for anonymous memory, and instead figure out the important use
> > cases and support them directly.  The use cases that I can think of
> > off the top of my head are:
> > 
> > 1. pmem.  This should probably use a very different API.
> > 
> > 2. Some kind of VM hardening, where a VM's memory can be protected a
> > little tiny bit from the main kernel.  But I don't see why this is any
> > better than XPO (eXclusive Page-frame Ownership), which brings to
> > mind:
> 
> What is the threat model anyway for AMD and Intel technologies?
> 
> For me it looks like that you can read, write and even replay 
> encrypted pages both in SME and TME. 

What replay attack are you talking about? MKTME uses AES-XTS with physical
address tweak. So the data is tied to the place in physical address space
and replacing one encrypted page with another encrypted page from
different address will produce garbage on decryption.

-- 
 Kirill A. Shutemov
