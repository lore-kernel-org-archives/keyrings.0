From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 Mar 2019 05:48:11 +0000
Subject: Re: [PATCH 2/6] security/keys/encrypted: Clean up request_trusted_key()
Message-Id: <CAPcyv4gySHayfwtp1PgxEoM-T_s_1A4RTcnXefx5iRLn9g=D5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1553040398.4899.149.camel@linux.ibm.com>
 <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
 <1553049331.4899.177.camel@linux.ibm.com>
In-Reply-To: <1553049331.4899.177.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, James Bottomley <jejb@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Tue, Mar 19, 2019 at 7:36 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-03-19 at 17:20 -0700, Dan Williams wrote:
> > On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
> > >
> > > < snip >
> > >
> > > > +/*
> > > > + * request_trusted_key - request the trusted key
> > > > + *
> > > > + * Trusted keys are sealed to PCRs and other metadata. Although userspace
> > > > + * manages both trusted/encrypted key-types, like the encrypted key type
> > > > + * data, trusted key type data is not visible decrypted from userspace.
> > > > + */
> > > > +static struct key *request_trusted_key(const char *trusted_desc,
> > > > +                             const u8 **master_key, size_t *master_keylen)
> > > > +{
> > > > +     struct trusted_key_payload *tpayload;
> > > > +     struct key_type *type;
> > > > +     struct key *tkey;
> > > > +
> > > > +     type = key_type_lookup("trusted");
> > >
> > > The associated key_type_put() will need to be called.
> >
> > Yes.
>
> I don't know if defining a key_type_lookup() wrapper, perhaps named
> is_key_type_available(), would help.  Both key_type_lookup() and
> key_type_put() would be called.  The existing code could then remain
> the same.
>

Maybe, but something still needs to pin the hosting module. I think
this means that the first call to key_type->instantiate() pins the
hosting module, and the ->destroy() of the last key for the key_type
unpins the module. It does mean that the ->destroy() method is no
longer optional.
