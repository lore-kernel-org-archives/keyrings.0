From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 04 Feb 2019 12:07:46 +0000
Subject: Re: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()
Message-Id: <20190204120746.GG26799@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-7-roberto.sassu@huawei.com>
 <1549048506.6993.73.camel@linux.ibm.com>
 <9f8a64d6-d566-1497-1d2b-465440cdfa80@huawei.com>
In-Reply-To: <9f8a64d6-d566-1497-1d2b-465440cdfa80@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Mon, Feb 04, 2019 at 10:14:38AM +0100, Roberto Sassu wrote:
> On 2/1/2019 8:15 PM, Mimi Zohar wrote:
> > Hi Roberto,
> >=20
> > Sorry for the delayed review. =A0A few comments inline below, minor
> > suggestions.
> >=20
> > > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/im=
a.h
> > > index cc12f3449a72..e6b2dcb0846a 100644
> > > --- a/security/integrity/ima/ima.h
> > > +++ b/security/integrity/ima/ima.h
> > > @@ -56,6 +56,7 @@ extern int ima_policy_flag;
> > >   extern int ima_hash_algo;
> > >   extern int ima_appraise;
> > >   extern struct tpm_chip *ima_tpm_chip;
> > > +extern struct tpm_digest *digests;
> > >   /* IMA event related data */
> > >   struct ima_event_data {
> > > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/i=
ma/ima_init.c
> > > index 6bb42a9c5e47..296a965b11ef 100644
> > > --- a/security/integrity/ima/ima_init.c
> > > +++ b/security/integrity/ima/ima_init.c
> > > @@ -27,6 +27,7 @@
> > >   /* name for boot aggregate entry */
> > >   static const char boot_aggregate_name[] =3D "boot_aggregate";
> > >   struct tpm_chip *ima_tpm_chip;
> > > +struct tpm_digest *digests;
> >=20
> > "digests" is used in the new ima_init_digests() and in
> > ima_pcr_extend(). =A0It's nice that the initialization routines are
> > grouped together here in ima_init.c, but wouldn't it better to define
> > "digests" in ima_queued.c, where it is currently being used?
> >  =A0"digests" could then be defined as static.
>=20
> 'digests' and ima_init_digests() can be moved to ima_queue.c, but I have
> to add the definition of ima_init_digests() to ima.h. Should I do it?
>=20
>=20
> > >   /* Add the boot aggregate to the IMA measurement list and extend
> > >    * the PCR register.
> > > @@ -104,6 +105,24 @@ void __init ima_load_x509(void)
> > >   }
> > >   #endif
> > > +int __init ima_init_digests(void)
> > > +{
> > > +	int i;
> > > +
> > > +	if (!ima_tpm_chip)
> > > +		return 0;
> > > +
> > > +	digests =3D kcalloc(ima_tpm_chip->nr_allocated_banks, sizeof(*diges=
ts),
> > > +			  GFP_NOFS);
> > > +	if (!digests)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i =3D 0; i < ima_tpm_chip->nr_allocated_banks; i++)
> > > +		digests[i].alg_id =3D ima_tpm_chip->allocated_banks[i].alg_id;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   int __init ima_init(void)
> > >   {
> > >   	int rc;
> > > @@ -125,6 +144,9 @@ int __init ima_init(void)
> > >   	ima_load_kexec_buffer();
> > > +	rc =3D ima_init_digests();
> >=20
> > Ok. Getting the tpm chip is at the beginning of this function.
> >  =A0Deferring allocating "digests" to here, avoids having to free memory
> > on failure.
> >=20
> > ima_load_kexec_buffer() restores prior measurements, but doesn't
> > extend the TPM. =A0For anyone reading the code, a short comment above
> > ima_load_kexec_buffer() would make sense.
>=20
> Ok. Should I resend the last patch again with the fixes you suggested?

Send the full patch set. For me it is easier then to apply the series
rather than cherry-picking patches from random versions of the patch
set.

/Jarkko
