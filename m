From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 07 Dec 2018 23:48:55 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <CALCETrXOkwZ-SmK1euy_ys=VvMx6dAGbTqPm-VW9jWw3TvoFag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
 <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1> <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
 <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
In-Reply-To: <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
To: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, James Morris <jmorris@namei.org>, kai.huang@intel.com, keyrings@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux-MM <linux-mm@kvack.org>, David Howells <dhowells@redhat.com>, LSM List <linux-security-module@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, Alison Schofield <alison.schofield@intel.com>, Jun Nakajima <jun.nakajima@intel.com>

On Fri, Dec 7, 2018 at 3:45 PM Sakkinen, Jarkko
<jarkko.sakkinen@intel.com> wrote:
>
> On Fri, 2018-12-07 at 13:59 -0800, Jarkko Sakkinen wrote:
> > On Fri, 2018-12-07 at 14:57 +0300, Kirill A. Shutemov wrote:
> > > > What is the threat model anyway for AMD and Intel technologies?
> > > >
> > > > For me it looks like that you can read, write and even replay
> > > > encrypted pages both in SME and TME.
> > >
> > > What replay attack are you talking about? MKTME uses AES-XTS with physical
> > > address tweak. So the data is tied to the place in physical address space
> > > and
> > > replacing one encrypted page with another encrypted page from different
> > > address will produce garbage on decryption.
> >
> > Just trying to understand how this works.
> >
> > So you use physical address like a nonce/version for the page and
> > thus prevent replay? Was not aware of this.
>
> The brutal fact is that a physical address is an astronomical stretch
> from a random value or increasing counter. Thus, it is fair to say that
> MKTME provides only naive measures against replay attacks...
>

And this is potentially a big deal, since there are much simpler
replay attacks that can compromise the system.  For example, if I can
replay the contents of a page table, I can write to freed memory.

--Andy
