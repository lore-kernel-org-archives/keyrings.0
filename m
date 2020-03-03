From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 03 Mar 2020 20:39:08 +0000
Subject: Re: [PATCH v6 3/6] security: keys: trusted: fix TPM2 authorizations
Message-Id: <1583267948.3638.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
         <20200302122759.5204-4-James.Bottomley@HansenPartnership.com>
         <20200303193302.GC5775@linux.intel.com>
In-Reply-To: <20200303193302.GC5775@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Tue, 2020-03-03 at 21:33 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 02, 2020 at 07:27:56AM -0500, James Bottomley wrote:
> > In TPM 1.2 an authorization was a 20 byte number.  The spec
> > actually recommended you to hash variable length passwords and use
> > the sha1 hash as the authorization.  Because the spec doesn't
> > require this hashing, the current authorization for trusted keys is
> > a 40 digit hex number.  For TPM 2.0 the spec allows the passing in
> > of variable length passwords and passphrases directly, so we should
> > allow that in trusted keys for ease of use.  Update the 'blobauth'
> > parameter to take this into account, so we can now use plain text
> > passwords for the keys.
> >=20
> > so before
> >=20
> > keyctl add trusted kmk "new 32
> > blobauth=F572d396fae9206628714fb2ce00f72e94f2258f"
> >=20
> > after we will accept both the old hex sha1 form as well as a new
> > directly supplied password:
> >=20
> > keyctl add trusted kmk "new 32 blobauth=3Dhello keyhandle=81000001"
> >=20
> > Since a sha1 hex code must be exactly 40 bytes long and a direct
> > password must be 20 or less, we use the length as the discriminator
> > for which form is input.
> >=20
> > Note this is both and enhancement and a potential bug fix.  The TPM
> > 2.0 spec requires us to strip leading zeros, meaning empyty
> > authorization is a zero length HMAC whereas we're currently passing
> > in
> > 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> > Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this
> > patch
> > makes the Microsoft TPM emulator work with trusted keys.
>=20
> The commit message does not mention it but there limitation that you
> cannot have this as a *password*:
>=20
>   f572d396fae9206628714fb2ce00f72e94f2258f
>=20
> The commit message should explicitly state this.

Well, that's impossible anyway: the password can be at most
TPM_DIGEST_SIZE characters and the above is twice that, so the
discriminator is fairly simple: if the string size is less than or
equal to TPM_DIGEST_SIZE, then it's a plain password, if it's exactly
2xTPM_DIGEST_SIZE it must be a hex value and if it's anything else,
it's illegal.  I thought the sentence

   Since a sha1 hex code must be exactly 40 bytes long and a direct
   password must be 20 or less, we use the length as the discriminator
   for which form is input.

Was the explanation for this, but I can update it.

> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0
> > chips")
>=20
> Fixes should be before SOB.

OK, I'll reverse them.

James
