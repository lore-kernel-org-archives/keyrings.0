From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 19 Mar 2019 01:34:02 +0000
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware TPM
Message-Id: <CAPcyv4h7iPHT2qSgPYvw8o61cdwfzjpocSDj0YF7LSsxEoO3fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1552955080.2785.26.camel@linux.ibm.com>
 <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
 <1552956989.2785.31.camel@linux.ibm.com>
In-Reply-To: <1552956989.2785.31.camel@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Roberto Sassu <roberto.sassu@huawei.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

On Mon, Mar 18, 2019 at 5:56 PM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Mon, 2019-03-18 at 17:30 -0700, Dan Williams wrote:
> > On Mon, Mar 18, 2019 at 5:24 PM James Bottomley <jejb@linux.ibm.com>
> > wrote:
> > >
> > > On Mon, 2019-03-18 at 16:45 -0700, Dan Williams wrote:
> > > > Rather than fail initialization of the trusted.ko module, arrange
> > > > for the module to load, but rely on trusted_instantiate() to fail
> > > > trusted-key operations.
> > >
> > > What actual problem is this fixing?  To me it would seem like an
> > > enhancement to make the trusted module fail at load time if there's
> > > no TPM rather than waiting until first use to find out it can never
> > > work. Is there some piece of user code that depends on the
> > > successful insertion of trusted.ko?
> >
> > The module dependency chain relies on it. If that can be broken that
> > would also be an acceptable fix.
> >
> > I found this through the following dependency chain: libnvdimm.ko ->
> > encrypted_keys.ko -> trusted.ko.
> >
> > "key_type_trusted" is the symbol that encrypted_keys needs regardless
> > of whether the tpm is present.
>
> That's a nasty dependency caused by every key type module exporting a
> symbol for its key type.  It really seems that key types should be
> looked up by name not symbol to prevent more of these dependency issues
> from spreading.  Something like this (untested and definitely won't
> work without doing an EXPORT_SYMBOL on key_type_lookup).
>
> If it does look acceptable we can also disentangle the nasty module
> dependencies in the encrypted key code around masterkey which alone
> should be a huge improvement because that code is too hacky to live.

Looks good to me. I fired it up with the export added and also included a:

    MODULE_SOFTDEP("pre: trusted");

...to encourage trusted.ko to be ready, if possible, for the lookup.
