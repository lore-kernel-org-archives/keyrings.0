From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 27 Feb 2020 16:19:49 +0000
Subject: Re: [PATCH v5 3/6] security: keys: trusted fix tpm2 authorizations
Message-Id: <20200227161949.GD5140@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
 <20200130101812.6271-4-James.Bottomley@HansenPartnership.com>
 <20200225164850.GB15662@linux.intel.com>
 <1582765091.4245.33.camel@HansenPartnership.com>
In-Reply-To: <1582765091.4245.33.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Wed, Feb 26, 2020 at 04:58:11PM -0800, James Bottomley wrote:
> On Tue, 2020-02-25 at 18:48 +0200, Jarkko Sakkinen wrote:
> > On Thu, Jan 30, 2020 at 11:18:09AM +0100, James Bottomley wrote:
> > > In TPM 1.2 an authorization was a 20 byte number.  The spec
> > > actually recommended you to hash variable length passwords and use
> > > the sha1 hash as the authorization.  Because the spec doesn't
> > > require this hashing, the current authorization for trusted keys is
> > > a 40 digit hex number.  For TPM 2.0 the spec allows the passing in
> > > of variable length passwords and passphrases directly, so we should
> > > allow that in trusted keys for ease of use.  Update the 'blobauth'
> > > parameter to take this into account, so we can now use plain text
> > > passwords for the keys.
> > >=20
> > > so before
> > >=20
> > > keyctl add trusted kmk "new 32
> > > blobauth=F572d396fae9206628714fb2ce00f72e94f2258f"
> > >=20
> > > after we will accept both the old hex sha1 form as well as a new
> > > directly supplied password:
> > >=20
> > > keyctl add trusted kmk "new 32 blobauth=3Dhello keyhandle=81000001"
> > >=20
> > > Since a sha1 hex code must be exactly 40 bytes long and a direct
> > > password must be 20 or less, we use the length as the discriminator
> > > for which form is input.
> > >=20
> > > Note this is both and enhancement and a potential bug fix.  The TPM
> > > 2.0 spec requires us to strip leading zeros, meaning empyty
> > > authorization is a zero length HMAC whereas we're currently passing
> > > in
> > > 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> > > Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this
> > > patch
> > > makes the Microsoft TPM emulator work with trusted keys.
> > >=20
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > > om>
> >=20
> > Should have a fixes tag.
>=20
> I made all the other changes, but I'm not sure what to identify in the
> fixes tag.  The problem is the code I updated was simply carried over
> unaltered from TPM 1.2
>=20
> You could certainly argue that commit
>=20
> commit 0fe5480303a1657b328a0a389f8d99249d9961f5
> Author: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Date:   Fri Jun 26 22:28:26 2015 +0300
>=20
>     keys, trusted: seal/unseal with TPM 2.0 chips
>=20
> Should have updated the blobauth handling ... is that the one you'd
> like fixes: to identify?

What I'm thinking is to have fixes tag w/o cc to stable. I'm not
sure at this point whether we want to backport this but it still
makes sense to tag it.

/Jarkko
