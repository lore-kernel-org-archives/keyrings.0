From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 25 Sep 2020 17:39:23 +0000
Subject: Re: [PATCH v13 3/5] security: keys: trusted: fix TPM2 authorizations
Message-Id: <49f167946299ced25cf6ad0db1a53f8b319c3491.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
         <20200922022809.7105-4-James.Bottomley@HansenPartnership.com>
         <20200925072829.GA170658@linux.intel.com>
In-Reply-To: <20200925072829.GA170658@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Fri, 2020-09-25 at 10:28 +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 21, 2020 at 07:28:07PM -0700, James Bottomley wrote:
[...]
> > keyctl add trusted kmk "new 32
> > blobauth=F572d396fae9206628714fb2ce00f72e94f2258fkeyhandle=81000001
> > " @u
> >=20
> > after we will accept both the old hex sha1 form as well as a new
> > directly supplied password:
> >=20
> > keyctl add trusted kmk "new 32 blobauth=3Dhello keyhandle=81000001"
> > @u
>=20
> I'm still getting -EINVAL from both with a Geminilake NUC.

Since I don't have one of those you're going to have to give me more to
go on.  I've tested this works in a VM with the ibmtss and on a Rainbow
Pass with a variety of physical TPMs.  Keyctl returns -EINVAL for an
annoying number of conditions it shouldn't ... the most frequent of
which is that the key already exists in the keyring.

So what's different about the Geminilake NUC?  Either it's a kernel
problem with the TPM, in which case there should be something in dmesg
or it's a userspace problem with keyctl, in which case perhaps strace
might get us further forward.

James
