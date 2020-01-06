From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 06 Jan 2020 21:48:07 +0000
Subject: Re: [PATCH v4 3/9] security: keys: trusted fix tpm2 authorizations
Message-Id: <b17b2aca2a56be2aace6479e40b763e4ec176d3d.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-4-James.Bottomley@HansenPartnership.com>
         <c03eb4a8aa3627f58bc45bbc23a4dcd660dc6e2f.camel@linux.intel.com>
In-Reply-To: <c03eb4a8aa3627f58bc45bbc23a4dcd660dc6e2f.camel@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, 2020-01-06 at 23:45 +0200, Jarkko Sakkinen wrote:
> On Mon, 2019-12-30 at 09:37 -0800, James Bottomley wrote:
> > In TPM 1.2 an authorization was a 20 byte number.  The spec actually
> > recommended you to hash variable length passwords and use the sha1
> > hash as the authorization.  Because the spec doesn't require this
> > hashing, the current authorization for trusted keys is a 40 digit hex
> > number.  For TPM 2.0 the spec allows the passing in of variable length
> > passwords and passphrases directly, so we should allow that in trusted
> > keys for ease of use.  Update the 'blobauth' parameter to take this
> > into account, so we can now use plain text passwords for the keys.
> >=20
> > so before
> >=20
> > keyctl add trusted kmk "new 32 blobauth=F572d396fae9206628714fb2ce00f72=
e94f2258f"
> >=20
> > after:
> >=20
> > keyctl add trusted kmk "new 32 blobauth=3Dhello keyhandle=81000001"
> >=20
> > Note this is both and enhancement and a potential bug fix.  The TPM
> > 2.0 spec requires us to strip leading zeros, meaning empyty
> > authorization is a zero length HMAC whereas we're currently passing in
> > 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> > Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this patch
> > makes the Microsoft TPM emulator work with trusted keys.
>=20
> Even if for good reasons, you should be explicit when you make an API
> change that is not backwards compatible.

Also you have illformed abbrevation in your short summary. Should
be TPM2, not tpm2.

/Jarkko
