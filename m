From: Eric Rannaud <eric.rannaud@gmail.com>
Date: Fri, 07 Dec 2018 23:35:29 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <CA+zRj8Uin5MsvOVstRYY3ARhHCfh8iQAHQfsHi1CRso3+siSjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com> <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
In-Reply-To: <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
To: kirill@shutemov.name
Cc: jarkko.sakkinen@intel.com, dan.j.williams@intel.com, alison.schofield@intel.com, luto@kernel.org, willy@infradead.org, kirill.shutemov@linux.intel.com, jmorris@namei.org, peterz@infradead.org, kai.huang@intel.com, keyrings@vger.kernel.org, tglx@linutronix.de, linux-mm@kvack.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, x86@kernel.org, hpa@zytor.com, mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com, jun.nakajima@intel.com

On Fri, Dec 7, 2018 at 3:57 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > What is the threat model anyway for AMD and Intel technologies?
> >
> > For me it looks like that you can read, write and even replay
> > encrypted pages both in SME and TME.
>
> What replay attack are you talking about? MKTME uses AES-XTS with physical
> address tweak. So the data is tied to the place in physical address space
> and replacing one encrypted page with another encrypted page from
> different address will produce garbage on decryption.

What if you have some control over the physical addresses you write
the stolen encrypted page to? For instance, VM_Eve might manage to use
physical address space previously used by VM_Alice by getting the
hypervisor to move memory around (memory pressure, force other VMs out
via some type of DOS attack, etc.).

Say:
    C is VM_Alice's clear text at hwaddr
    E = mktme_encrypt(VM_Allice_key, hwaddr, C)
    Eve somehow stole the encrypted bits E

Eve would need to write the page E without further encryption to make
sure that the DRAM contains the original stolen bits E, not encrypted
again with VM_Eve's key or mktme_encrypt(VM_Eve_key, hwaddr, E) would
be present in the DRAM which is not helpful. But with MKTME under the
current proposal VM_Eve can disable encryption for a given mapping,
right? (See also Note 1)

Eve gets the HV to move VM_Alice back over the same physical address,
Eve "somehow" gets VM_Alice to read that page and use its content
(which would likely be a use of uninitialized memory bug, from
VM_Alice's perspective) and you have a replay attack?

For TME, this doesn't work as you cannot partially disable encryption,
so if Eve tries to write the stolen encrypted bits E, even in the
"right place", they get encrypted again to tme_encrypt(hwaddr, E).
Upon decryption, VM_Alice will get E, not C.

Note 1: Actually, even if with MKTME you cannot disable encryption but
*if* Eve knows its own key, Eve can always write a preimage P that the
CPU encrypts to E for VM_Alice to read back and decrypt:
    P = mktme_decrypt(VM_Eve_key, hwaddr, E)

This is not possible with TME as Eve doesn't know the key used by the
CPU and cannot compute P.
