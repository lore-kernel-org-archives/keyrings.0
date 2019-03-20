From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 Mar 2019 01:37:29 +0000
Subject: Re: [PATCH 2/6] security/keys/encrypted: Clean up request_trusted_key()
Message-Id: <CAPcyv4g+cA=itBjFJj4JCKopBdHrFXg7Bbg5KYF2=qYPAdAMfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1553040398.4899.149.camel@linux.ibm.com>
 <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
 <1553044252.4899.165.camel@linux.ibm.com>
 <CAPcyv4jB0HW8mB_wdMDQ3FO6jW-B-WdTELq2UeM4ZnSienoccQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jB0HW8mB_wdMDQ3FO6jW-B-WdTELq2UeM4ZnSienoccQ@mail.gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, James Bottomley <jejb@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Tue, Mar 19, 2019 at 6:34 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Mar 19, 2019 at 6:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2019-03-19 at 17:20 -0700, Dan Williams wrote:
> > > On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
> > >
> > > > > diff --git a/security/keys/key.c b/security/keys/key.c
> > > > > index 696f1c092c50..9045b62afb04 100644
> > > > > --- a/security/keys/key.c
> > > > > +++ b/security/keys/key.c
> > > > > @@ -706,6 +706,7 @@ struct key_type *key_type_lookup(const char *type)
> > > > >  found_kernel_type:
> > > > >       return ktype;
> > > > >  }
> > > > > +EXPORT_SYMBOL_GPL(key_type_lookup);
> > >
> > > This needs to be moved to patch1.
> > >
> > > > Only the kernel is calling key_type_lookup().  Why does
> > > > key_type_lookup() need to be exported?
> > >
> > > This patch series adds several new callers outside of keys-subsystem
> > > core that need this export, the first one being encrypted-keys itself
> > > in patch1.
> >
> > It's needed, because they could be compiled as kernel modules, not
> > builtin (eg. EVM).
> >
>
> Right, but now I realize a problem. The side effect of having direct
> module dependencies to the key_type_{encrypted,trusted} symbols is
> that module reference counting is handled automatically.
>
> So, I need to respin this with some explicit try_module_get() and
> module_put() added otherwise the encrypted_keys facility can be
> removed while active keys are instantiated.

...and now I'm wondering if this refactoring is getting too big and
should wait for v5.2. In the meantime apply my small fix for v5.1

https://patchwork.kernel.org/patch/10858649/
