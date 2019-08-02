From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 02 Aug 2019 16:15:28 +0000
Subject: Re: [PATCH v2] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <20190802161527.GC26616@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190802150733.1972-1-roberto.sassu@huawei.com>
 <20190802153030.GB26616@elm>
 <3222714a-a280-0708-f4c0-5db6d342d8dc@huawei.com>
 <8baf1c39-ad04-5cd6-bc67-341e7411db16@huawei.com>
In-Reply-To: <8baf1c39-ad04-5cd6-bc67-341e7411db16@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On 2019-08-02 18:11:09, Roberto Sassu wrote:
> On 8/2/2019 5:34 PM, Roberto Sassu wrote:
> > On 8/2/2019 5:30 PM, Tyler Hicks wrote:
> > > On 2019-08-02 17:07:33, Roberto Sassu wrote:
> > > > Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to
> > > > initialize w/o a
> > > > TPM") allows the trusted module to be loaded even a TPM is not foun=
d to
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ^ if
> > >=20
> > > > avoid module dependency problems.
> > > >=20
> > > > However, trusted module initialization can still fail if the TPM is
> > > > inactive or deactivated. This patch ignores tpm_get_random() errors=
 in
> > > > init_digests() and returns -EFAULT in pcrlock() if the TPM didn't r=
eturn
> > > > random data.
> > > >=20
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > The code changes look correct to me.
> > >=20
> > > =A0=A0 Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
> > >=20
> > > For whoever takes this patch through their tree, I think that adding =
the
> > > following Fixes tag would be useful (as well as cc'ing stable):
> > >=20
> > > =A0=A0 Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip
> > > structure...")
> > >=20
> > > I think it is also worth leaving a short note, in the commit message,
> > > for backporters that commit 782779b60faa ("tpm: Actually fail on TPM
> > > errors during "get random"") should be included with any backports of
> > > this patch.
> >=20
> > Right, thanks. I wait for Jarkko's comments and I add both the Fixes tag
> > and the short note in the next version of the patch.
>=20
> Uhm, I was thinking that maybe it is not necessary to mention commit
> 782779b60faa. This patch would still return 0 even if that commit is not
> backported (TPM_ERR_DISABLED < TPM_MAX_DIGEST_SIZE).

The commit message for 782779b60faa shows 379 being returned when
attempting to get random:

  [   18.092103] tpm tpm0: A TPM error (379) occurred attempting get random

I don't know enough about TPM chips to know how common that is...

Tyler

>=20
> Roberto
>=20
> --=20
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli
