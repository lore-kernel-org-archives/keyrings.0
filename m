From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 20 Mar 2019 01:10:52 +0000
Subject: Re: [PATCH 2/6] security/keys/encrypted: Clean up request_trusted_key()
Message-Id: <1553044252.4899.165.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1553040398.4899.149.camel@linux.ibm.com>
 <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
In-Reply-To: <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, James Bottomley <jejb@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Tue, 2019-03-19 at 17:20 -0700, Dan Williams wrote:
> On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
> 
> > > diff --git a/security/keys/key.c b/security/keys/key.c
> > > index 696f1c092c50..9045b62afb04 100644
> > > --- a/security/keys/key.c
> > > +++ b/security/keys/key.c
> > > @@ -706,6 +706,7 @@ struct key_type *key_type_lookup(const char *type)
> > >  found_kernel_type:
> > >       return ktype;
> > >  }
> > > +EXPORT_SYMBOL_GPL(key_type_lookup);
> 
> This needs to be moved to patch1.
> 
> > Only the kernel is calling key_type_lookup().  Why does
> > key_type_lookup() need to be exported?
> 
> This patch series adds several new callers outside of keys-subsystem
> core that need this export, the first one being encrypted-keys itself
> in patch1.

It's needed, because they could be compiled as kernel modules, not
builtin (eg. EVM).

Mimi

> 
> drivers/nvdimm/security.c:57:   type = key_type_lookup("encrypted");
> fs/ecryptfs/keystore.c:1627:    type = key_type_lookup("encrypted");
> security/integrity/evm/evm_crypto.c:361:        type > key_type_lookup("encrypted");
> security/keys/encrypted-keys/encrypted.c:440:   type > key_type_lookup("trusted");
> 
