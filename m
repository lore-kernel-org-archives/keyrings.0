From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 06 Dec 2018 01:09:30 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com> <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com>
In-Reply-To: <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>, alison.schofield@intel.com, Matthew Wilcox <willy@infradead.org>, Dan Williams <dan.j.williams@intel.com>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, kai.huang@intel.com, Jun Nakajima <jun.nakajima@intel.com>, "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>

On Wed, Dec 5, 2018 at 3:49 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 12/4/18 11:19 AM, Andy Lutomirski wrote:
> > I'm not Thomas, but I think it's the wrong direction.  As it stands,
> > encrypt_mprotect() is an incomplete version of mprotect() (since it's
> > missing the protection key support),
>
> I thought about this when I added mprotect_pkey().  We start with:
>
>         mprotect(addr, len, prot);
>
> then
>
>         mprotect_pkey(addr, len, prot);
>
> then
>
>         mprotect_pkey_encrypt(addr, len, prot, key);
>
> That doesn't scale because we eventually have
> mprotect_and_a_history_of_mm_features(). :)
>
> What I was hoping to see was them do this (apologies for the horrible
> indentation:
>
>         ptr = mmap(..., PROT_NONE);
>         mprotect_pkey(   addr, len, PROT_NONE, pkey);
>         mprotect_encrypt(addr, len, PROT_NONE, keyid);
>         mprotect(        addr, len, real_prot);
>
> The point is that you *can* stack these things and don't have to have an
> mprotect_kitchen_sink() if you use PROT_NONE for intermediate
> permissions during setup.

Sure, but then why call it mprotect at all?  How about:

mmap(..., PROT_NONE);
mencrypt(..., keyid);
mprotect_pkey(...);

But wouldn't this be much nicer:

int fd = memfd_create(...);
memfd_set_tme_key(fd, keyid);  /* fails if len != 0 */
mmap(fd, ...);

>
> > and it's also functionally just MADV_DONTNEED.  In other words, the
> > sole user-visible effect appears to be that the existing pages are
> > blown away.  The fact that it changes the key in use doesn't seem
> > terribly useful, since it's anonymous memory,
>
> It's functionally MADV_DONTNEED, plus a future promise that your writes
> will never show up as plaintext on the DIMM.

But that's mostly vacuous.  If I read the docs right, MKTME systems
also support TME, so you *already* have that promise, unless the
firmware totally blew it.  If we want a boot option to have the kernel
use MKTME to forcibly encrypt everything regardless of what the TME
MSRs say, I'd be entirely on board.  Heck, the implementation would be
quite simple because we mostly reuse the SME code.

>
> We also haven't settled on the file-backed properties.  For file-backed,
> my hope was that you could do:
>
>         ptr = mmap(fd, size, prot);
>         printf("ciphertext: %x\n", *ptr);
>         mprotect_encrypt(ptr, len, prot, keyid);
>         printf("plaintext: %x\n", *ptr);

Why would you ever want the plaintext?  Also, how does this work on a
normal fs, where relocation of the file would cause the ciphertext to
get lost?  It really seems to be that it should look more like
dm-crypt where you encrypt a filesystem.  Maybe you'd just configure
the pmem device to be encrypted before you mount it, or you'd get a
new pmem-mktme device node instead.  This would also avoid some nasty
multiple-copies-of-the-direct-map issue, since you'd only ever have
one of them mapped.

>
> > The main implementation concern I have with this patch set is cache
> > coherency and handling of the direct map.  Unless I missed something,
> > you're not doing anything about the direct map, which means that you
> > have RW aliases of the same memory with different keys.  For use case
> > #2, this probably means that you need to either get rid of the direct
> > map and make get_user_pages() fail, or you need to change the key on
> > the direct map as well, probably using the pageattr.c code.
>
> The current, public hardware spec has a description of what's required
> to maintain cache coherency.  Basically, you can keep as many mappings
> of a physical page as you want, but only write to one mapping at a time,
> and clflush the old one when you want to write to a new one.

Surely you at least have to clflush the old mapping and then the new
mapping, since the new mapping could have been speculatively read.

> > Finally, If you're going to teach the kernel how to have some user
> > pages that aren't in the direct map, you've essentially done XPO,
> > which is nifty but expensive.  And I think that doing this gets you
> > essentially all the benefit of MKTME for the non-pmem use case.  Why
> > exactly would any software want to use anything other than a
> > CPU-managed key for anything other than pmem?
>
> It is handy, for one, to let you "cluster" key usage.  If you have 5
> Pepsi VMs and 5 Coke VMs, each Pepsi one using the same key and each
> Coke one using the same key, you can boil it down to only 2 hardware
> keyid slots that get used, and do this transparently.

I understand this from a marketing perspective but not a security
perspective.  Say I'm Coke and you've sold me some VMs that are
"encrypted with a Coke-specific key and no other VMs get to use that
key."  I can't think of *any* not-exceedingly-contrived attack in
which this makes the slightest difference.  If Pepsi tries to attack
Coke without MKTME, then they'll either need to get the hypervisor to
leak Coke's data through the direct map or they'll have to find some
way to corrupt a page table or use something like L1TF to read from a
physical address Coke owns.  With MKTME, if they can read through the
host direct map, then they'll get Coke's cleartext, and if they can
corrupt a page table or use L1TF to read from your memory, they'll get
Coke's cleartext.

TME itself provides a ton of protection -- you can't just barge into
the datacenter, refrigerate the DIMMs, walk away with them, and read
off everyone's data.

Am I missing something?

>
> But, I think what you're implying is that the security properties of
> user-supplied keys can only be *worse* than using CPU-generated keys
> (assuming the CPU does a good job generating it).  So, why bother
> allowing user-specified keys in the first place?

That too :)
