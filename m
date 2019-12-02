From: "Zhao, Shirley" <shirley.zhao@intel.com>
Date: Mon, 02 Dec 2019 01:45:30 +0000
Subject: RE: One question about trusted key of keyring in Linux kernel.
Message-Id: <A888B25CD99C1141B7C254171A953E8E4909CA4B@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
 <1573659978.17949.83.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
 <1574796456.4793.248.camel@linux.ibm.com>
 <20191129230146.GB15726@linux.intel.com>
In-Reply-To: <20191129230146.GB15726@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: James Bottomley <jejb@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

Hi, Jarkko,=20

The rc1 you mentioned is the version for what?=20
How to download it and update it?=20

Thanks.=20

- Shirley=20

-----Original Message-----
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>=20
Sent: Saturday, November 30, 2019 7:02 AM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Zhao, Shirley <shirley.zhao@intel.com>; James Bottomley <jejb@linux.ibm=
.com>; Jonathan Corbet <corbet@lwn.net>; linux-integrity@vger.kernel.org; k=
eyrings@vger.kernel.org; linux-doc@vger.kernel.org; linux-kernel@vger.kerne=
l.org; 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>; Zhu, Bing <bin=
g.zhu@intel.com>; Chen, Luhai <luhai.chen@intel.com>
Subject: Re: One question about trusted key of keyring in Linux kernel.

On Tue, Nov 26, 2019 at 02:27:36PM -0500, Mimi Zohar wrote:
> On Tue, 2019-11-26 at 07:32 +0000, Zhao, Shirley wrote:
> > Thanks for your feedback, Mimi.=20
> > But the document of dracut can't solve my problem.=20
> >=20
> > I did more test these days and try to descript my question in more deta=
il.=20
> >=20
> > In my scenario, the trusted key will be sealed into TPM with PCR policy=
.=20
> > And there are some related options in manual like=20
> >        hash=3D         hash algorithm name as a string. For TPM 1.x the=
 only
> >                      allowed value is sha1. For TPM 2.x the allowed val=
ues
> >                      are sha1, sha256, sha384, sha512 and sm3-256.
> >        policydigest=3D digest for the authorization policy. must be cal=
culated
> >                      with the same hash algorithm as specified by the '=
hash=3D'
> >                      option.
> >        policyhandle=3D handle to an authorization policy session that d=
efines the
> >                      same policy and with the same hash algorithm as wa=
s used to
> >                      seal the key.=20
> >=20
> > Here is my test step.=20
> > Firstly, the pcr policy is generated as below:=20
> > $ tpm2_createpolicy --policy-pcr --pcr-list sha256:7 --policy=20
> > pcr7_bin.policy > pcr7.policy
> >=20
> > Pcr7.policy is the ascii hex of policy:
> > $ cat pcr7.policy
> > 321fbd28b60fcc23017d501b133bd5dbf2889814588e8a23510fe10105cb2cc9
> >=20
> > Then generate the trusted key and configure policydigest and get the ke=
y ID:=20
> > $ keyctl add trusted kmk "new 32 keyhandle=3D0x81000001 hash=3Dsha256=20
> > policydigest=3D`cat pcr7.policy`" @u
> > 874117045
> >=20
> > Save the trusted key.=20
> > $ keyctl pipe 874117045 > kmk.blob
> >=20
> > Reboot and load the key.=20
> > Start a auth session to generate the policy:
> > $ tpm2_startauthsession -S session.ctx
> > session-handle: 0x3000000
> > $ tpm2_pcrlist -L sha256:7 -o pcr7.sha256 $ tpm2_policypcr -S=20
> > session.ctx -L sha256:7 -F pcr7.sha256 -f pcr7.policy
> > policy-digest:=20
> > 0x321FBD28B60FCC23017D501B133BD5DBF2889814588E8A23510FE10105CB2CC9
> >=20
> > Input the policy handle to load trusted key:
> > $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=3D0x81000001=20
> > policyhandle=3D0x3000000" @u
> > add_key: Operation not permitted
> >=20
> > The error should be policy check failed, because I use TPM command to u=
nseal directly with error of policy check failed.=20
> > $ tpm2_unseal -c 0x81000001 -L sha256:7 ERROR on line: "81" in file:=20
> > "./lib/log.h": Tss2_Sys_Unseal(0x99D) - tpm:session(1):a policy=20
> > check failed ERROR on line: "213" in file: "tools/tpm2_unseal.c": Unsea=
l failed!
> > ERROR on line: "166" in file: "tools/tpm2_tool.c": Unable to run=20
> > tpm2_unseal
> >=20
> > So my question is:
> > 1. How to use the option, policydigest, policyhandle?? Is there any exa=
mple?=20
> > 2. What's wrong with my test step?=20
>=20
> When reporting a problem please state which kernel is experiencing=20
> this problem. =A0Recently there was a trusted key regression. =A0Refer to=
=20
> commit e13cd21ffd50 "tpm: Wrap the buffer from the caller to tpm_buf=20
> in tpm_send()" for the details.
>=20
> Before delving into this particular problem, first please make sure=20
> you are able to create, save, remove, and then reload a trusted key=20
> not sealed to a PCR.

Please re-test with rc1 when available.

/Jarkko
