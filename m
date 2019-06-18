From: Kai Huang <kai.huang@linux.intel.com>
Date: Tue, 18 Jun 2019 00:05:42 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <1560816342.5187.63.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
         <20190508144422.13171-46-kirill.shutemov@linux.intel.com>
         <CALCETrVCdp4LyCasvGkc0+S6fvS+dna=_ytLdDPuD2xeAr5c-w@mail.gmail.com>
         <3c658cce-7b7e-7d45-59a0-e17dae986713@intel.com>
         <CALCETrUPSv4Xae3iO+2i_HecJLfx4mqFfmtfp+cwBdab8JUZrg@mail.gmail.com>
         <5cbfa2da-ba2e-ed91-d0e8-add67753fc12@intel.com>
         <CALCETrWFXSndmPH0OH4DVVrAyPEeKUUfNwo_9CxO-3xy9awq0g@mail.gmail.com>
In-Reply-To: <CALCETrWFXSndmPH0OH4DVVrAyPEeKUUfNwo_9CxO-3xy9awq0g@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>, keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>

On Mon, 2019-06-17 at 12:12 -0700, Andy Lutomirski wrote:
> On Mon, Jun 17, 2019 at 11:37 AM Dave Hansen <dave.hansen@intel.com> wrote:
> > 
> > Tom Lendacky, could you take a look down in the message to the talk of
> > SEV?  I want to make sure I'm not misrepresenting what it does today.
> > ...
> > 
> > 
> > > > I actually don't care all that much which one we end up with.  It's not
> > > > like the extra syscall in the second options means much.
> > > 
> > > The benefit of the second one is that, if sys_encrypt is absent, it
> > > just works.  In the first model, programs need a fallback because
> > > they'll segfault of mprotect_encrypt() gets ENOSYS.
> > 
> > Well, by the time they get here, they would have already had to allocate
> > and set up the encryption key.  I don't think this would really be the
> > "normal" malloc() path, for instance.
> > 
> > > >  How do we
> > > > eventually stack it on top of persistent memory filesystems or Device
> > > > DAX?
> > > 
> > > How do we stack anonymous memory on top of persistent memory or Device
> > > DAX?  I'm confused.
> > 
> > If our interface to MKTME is:
> > 
> >         fd = open("/dev/mktme");
> >         ptr = mmap(fd);
> > 
> > Then it's hard to combine with an interface which is:
> > 
> >         fd = open("/dev/dax123");
> >         ptr = mmap(fd);
> > 
> > Where if we have something like mprotect() (or madvise() or something
> > else taking pointer), we can just do:
> > 
> >         fd = open("/dev/anything987");
> >         ptr = mmap(fd);
> >         sys_encrypt(ptr);
> 
> I'm having a hard time imagining that ever working -- wouldn't it blow
> up if someone did:
> 
> fd = open("/dev/anything987");
> ptr1 = mmap(fd);
> ptr2 = mmap(fd);
> sys_encrypt(ptr1);
> 
> So I think it really has to be:
> fd = open("/dev/anything987");
> ioctl(fd, ENCRYPT_ME);
> mmap(fd);

This requires "/dev/anything987" to support ENCRYPT_ME ioctl, right?

So to support NVDIMM (DAX), we need to add ENCRYPT_ME ioctl to DAX?

> 
> But I really expect that the encryption of a DAX device will actually
> be a block device setting and won't look like this at all.  It'll be
> more like dm-crypt except without device mapper.

Are you suggesting not to support MKTME for DAX, or adding MKTME support to dm-crypt?

Thanks,
-Kai
