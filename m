From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 29 Nov 2019 23:01:46 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <20191129230146.GB15726@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
 <1573659978.17949.83.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
 <1574796456.4793.248.camel@linux.ibm.com>
In-Reply-To: <1574796456.4793.248.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: "Zhao, Shirley" <shirley.zhao@intel.com>, James Bottomley <jejb@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

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
> > $ tpm2_createpolicy --policy-pcr --pcr-list sha256:7 --policy pcr7_bin.=
policy > pcr7.policy
> >=20
> > Pcr7.policy is the ascii hex of policy:
> > $ cat pcr7.policy
> > 321fbd28b60fcc23017d501b133bd5dbf2889814588e8a23510fe10105cb2cc9
> >=20
> > Then generate the trusted key and configure policydigest and get the ke=
y ID:=20
> > $ keyctl add trusted kmk "new 32 keyhandle=3D0x81000001 hash=3Dsha256 p=
olicydigest=3D`cat pcr7.policy`" @u
> > 874117045
> >=20
> > Save the trusted key.=20
> > $ keyctl pipe 874117045 > kmk.blob
> >=20
> > Reboot and load the key.=20
> > Start a auth session to generate the policy:
> > $ tpm2_startauthsession -S session.ctx
> > session-handle: 0x3000000
> > $ tpm2_pcrlist -L sha256:7 -o pcr7.sha256
> > $ tpm2_policypcr -S session.ctx -L sha256:7 -F pcr7.sha256 -f pcr7.poli=
cy
> > policy-digest: 0x321FBD28B60FCC23017D501B133BD5DBF2889814588E8A23510FE1=
0105CB2CC9
> >=20
> > Input the policy handle to load trusted key:
> > $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=3D0x81000001 po=
licyhandle=3D0x3000000" @u
> > add_key: Operation not permitted
> >=20
> > The error should be policy check failed, because I use TPM command to u=
nseal directly with error of policy check failed.=20
> > $ tpm2_unseal -c 0x81000001 -L sha256:7
> > ERROR on line: "81" in file: "./lib/log.h": Tss2_Sys_Unseal(0x99D) - tp=
m:session(1):a policy check failed
> > ERROR on line: "213" in file: "tools/tpm2_unseal.c": Unseal failed!
> > ERROR on line: "166" in file: "tools/tpm2_tool.c": Unable to run tpm2_u=
nseal
> >=20
> > So my question is:
> > 1. How to use the option, policydigest, policyhandle?? Is there any exa=
mple?=20
> > 2. What's wrong with my test step?=20
>=20
> When reporting a problem please state which kernel is experiencing
> this problem. =A0Recently there was a trusted key regression. =A0Refer to
> commit e13cd21ffd50 "tpm: Wrap the buffer from the caller to tpm_buf
> in tpm_send()" for the details.
>=20
> Before delving into this particular problem, first please make sure
> you are able to create, save, remove, and then reload a trusted key
> not sealed to a PCR.

Please re-test with rc1 when available.

/Jarkko
