From: Dave Hansen <dave.hansen@intel.com>
Date: Tue, 18 Jun 2019 16:48:45 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <7e001776-a8f8-9109-a536-90398de81d53@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <CALCETrUPSv4Xae3iO+2i_HecJLfx4mqFfmtfp+cwBdab8JUZrg@mail.gmail.com>
 <5cbfa2da-ba2e-ed91-d0e8-add67753fc12@intel.com>
 <CALCETrWFXSndmPH0OH4DVVrAyPEeKUUfNwo_9CxO-3xy9awq0g@mail.gmail.com>
 <1560816342.5187.63.camel@linux.intel.com>
 <CALCETrVcrPYUUVdgnPZojhJLgEhKv5gNqnT6u2nFVBAZprcs5g@mail.gmail.com>
 <1560821746.5187.82.camel@linux.intel.com>
 <CALCETrUrFTFGhRMuNLxD9G9=GsR6U-THWn4AtminR_HU-nBj+Q@mail.gmail.com>
 <1560824611.5187.100.camel@linux.intel.com>
 <20190618091246.GM3436@hirez.programming.kicks-ass.net>
 <2ec26c05-7c57-d0e0-a628-94d581b96b63@intel.com>
 <20190618161502.jiuqhvs3wvnac5ow@box.shutemov.name>
 <f701f859-0990-9f02-baa2-451dd6c8b3c4@intel.com>
 <8FDB1E33-21BC-400D-9051-7BE61400ACD2@amacapital.net>
In-Reply-To: <8FDB1E33-21BC-400D-9051-7BE61400ACD2@amacapital.net>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Peter Zijlstra <peterz@infradead.org>, Kai Huang <kai.huang@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>, keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>

On 6/18/19 9:36 AM, Andy Lutomirski wrote:
> Should MKTME+DAX encrypt the entire volume or should it encrypt individua=
l files?  Or both?

Our current thought is that there should be two modes: One for entire
DAX namespaces and one for filesystem DAX that would allow it to be at
the file level.  More likely, we would mirror fscrypt and do it at the
directory level.

> If it encrypts individual files, should the fs be involved at all?
> Should there be metadata that can check whether a given key is the
> correct key?
FWIW, this is a question for the fs guys.  Their guidance so far has
been "do what fscrypt does", and fscrypt does not protect against
incorrect keys being specified.  See:

	https://www.kernel.org/doc/html/v5.1/filesystems/fscrypt.html

Which says:

> Currently, fscrypt does not prevent a user from maliciously providing
> an incorrect key for another user=E2=80=99s existing encrypted files. A
> protection against this is planned.

> If it encrypts individual files, is it even conceptually possible to
> avoid corruption if the fs is not involved?  After all, many
> filesystems think that they can move data blocks, compute checksums,
> journal data, etc.

Yes, exactly.  Thankfully, fscrypt has thought about this already and
has infrastructure for this.  For instance:

> Online defragmentation of encrypted files is not supported. The
> EXT4_IOC_MOVE_EXT and F2FS_IOC_MOVE_RANGE ioctls will fail with
> EOPNOTSUPP.
