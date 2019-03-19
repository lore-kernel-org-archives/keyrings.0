From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 19 Mar 2019 22:56:29 +0000
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware TPM
Message-Id: <1553036189.4899.136.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1552955080.2785.26.camel@linux.ibm.com>
 <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
In-Reply-To: <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James Bottomley <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, Roberto Sassu <roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Dan,

On Mon, 2019-03-18 at 17:30 -0700, Dan Williams wrote:

Sorry for the late reply.

> On Mon, Mar 18, 2019 at 5:24 PM James Bottomley <jejb@linux.ibm.com> wrote:
> >
> > On Mon, 2019-03-18 at 16:45 -0700, Dan Williams wrote:
> > > Rather than fail initialization of the trusted.ko module, arrange for
> > > the module to load, but rely on trusted_instantiate() to fail
> > > trusted-key operations.
> >
> > What actual problem is this fixing?  To me it would seem like an
> > enhancement to make the trusted module fail at load time if there's no
> > TPM rather than waiting until first use to find out it can never work.
> > Is there some piece of user code that depends on the successful
> > insertion of trusted.ko?
> 
> The module dependency chain relies on it. If that can be broken that
> would also be an acceptable fix.
> 
> I found this through the following dependency chain: libnvdimm.ko ->
> encrypted_keys.ko -> trusted.ko.
> 
> "key_type_trusted" is the symbol that encrypted_keys needs regardless
> of whether the tpm is present.

Commit 982e617a313b ("encrypted-keys: remove trusted-keys dependency")
removed the dependency on trusted keys.  masterkey_trusted.c should
only be included if "CONFIG_TRUSTED_KEYS" is enabled.  Is
CONFIG_TRUSTED_KEYS enabled?

Mimi
