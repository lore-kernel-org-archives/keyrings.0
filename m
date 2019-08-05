From: Tyler Hicks <tyhicks@canonical.com>
Date: Mon, 05 Aug 2019 16:04:52 +0000
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <20190805160451.GB3449@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
 <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
 <20190801163215.mfkagoafkxscesne@linux.intel.com>
 <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
 <20190802142721.GA26616@elm>
 <20190802194226.oiztvme5klkmw6fh@linux.intel.com>
 <20190802202343.GE26616@elm>
 <e10f7b04-3d63-435e-180e-72a084ac4bab@huawei.com>
 <1565020459.11223.179.camel@linux.ibm.com>
In-Reply-To: <1565020459.11223.179.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, jejb@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On 2019-08-05 11:54:19, Mimi Zohar wrote:
> On Mon, 2019-08-05 at 16:50 +0200, Roberto Sassu wrote:
> > Regarding Mimi's proposal to avoid the issue by extending the PCR with
> > zeros, I think it also achieve the goal.=20
>=20
> Roberto, removing the following code from init_digests() would be the
> equivalent to the prior code, without needing to make any other
> changes. =A0Let's keep it simple. =A0Do you want to post the patch with
> the change, or should I?
>=20
>         ret =3D tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
>         if (ret < 0)
>                 return ret;
>         if (ret < TPM_MAX_DIGEST_SIZE)
>                 return -EFAULT;
>=20
> As I can't duplicate the problem, it would need to be tested by others
> experiencing the problem.

The bug reporter tested Roberto's last patch:

 https://bugzilla.kernel.org/show_bug.cgi?id 3953#c8

We should Cc the reporter on future patches or at least leave another
testing request in the bugzilla.

Tyler

>=20
> thanks,
>=20
> Mimi
>=20
