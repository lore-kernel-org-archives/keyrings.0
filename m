From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 25 Sep 2020 07:28:29 +0000
Subject: Re: [PATCH v13 3/5] security: keys: trusted: fix TPM2 authorizations
Message-Id: <20200925072829.GA170658@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
 <20200922022809.7105-4-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200922022809.7105-4-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Mon, Sep 21, 2020 at 07:28:07PM -0700, James Bottomley wrote:
> In TPM 1.2 an authorization was a 20 byte number.  The spec actually
> recommended you to hash variable length passwords and use the sha1
> hash as the authorization.  Because the spec doesn't require this
> hashing, the current authorization for trusted keys is a 40 digit hex
> number.  For TPM 2.0 the spec allows the passing in of variable length
> passwords and passphrases directly, so we should allow that in trusted
> keys for ease of use.  Update the 'blobauth' parameter to take this
> into account, so we can now use plain text passwords for the keys.
>=20
> so before
>=20
> keyctl add trusted kmk "new 32 blobauth=F572d396fae9206628714fb2ce00f72e9=
4f2258fkeyhandle=81000001" @u
>=20
> after we will accept both the old hex sha1 form as well as a new
> directly supplied password:
>=20
> keyctl add trusted kmk "new 32 blobauth=3Dhello keyhandle=81000001" @u

I'm still getting -EINVAL from both with a Geminilake NUC.

/Jarkko
