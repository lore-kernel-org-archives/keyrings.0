From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 14 May 2020 01:41:09 +0000
Subject: Re: [PATCH v9 3/8] security: keys: trusted: fix TPM2 authorizations
Message-Id: <1589420469.9117.12.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <20200507231147.27025-4-James.Bottomley@HansenPartnership.com>
         <00325dff8292a18212bbdaa3fd81cebee2a60bc2.camel@linux.intel.com>
         <664f00cf18c68e3f6316b50679b2fd56919d5aeb.camel@linux.intel.com>
In-Reply-To: <664f00cf18c68e3f6316b50679b2fd56919d5aeb.camel@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Thu, 2020-05-14 at 04:12 +0300, Jarkko Sakkinen wrote:
> On Thu, 2020-05-14 at 04:11 +0300, Jarkko Sakkinen wrote:
> > On Thu, 2020-05-07 at 16:11 -0700, James Bottomley wrote:
> > > In TPM 1.2 an authorization was a 20 byte number.  The spec
> > > actually recommended you to hash variable length passwords and
> > > use the sha1 hash as the authorization.  Because the spec doesn't
> > > require this hashing, the current authorization for trusted keys
> > > is a 40 digit hex number.  For TPM 2.0 the spec allows the
> > > passing in of variable length passwords and passphrases directly,
> > > so we should allow that in trusted keys for ease of use.  Update
> > > the 'blobauth' parameter to take this into account, so we can now
> > > use plain text passwords for the keys.
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
> > > password must be 20 or less, we use the length as the
> > > discriminator for which form is input.
> > >=20
> > > Note this is both and enhancement and a potential bug fix.  The
> > > TPM 2.0 spec requires us to strip leading zeros, meaning empyty
> > > authorization is a zero length HMAC whereas we're currently
> > > passing in 20 bytes of zeros.  A lot of TPMs simply accept this
> > > as OK, but the Microsoft TPM emulator rejects it with
> > > TPM_RC_BAD_AUTH, so this patch makes the Microsoft TPM emulator
> > > work with trusted keys.
> > >=20
> > > Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0
> > > chips")
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership
> > > .com>
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >=20
> > Have not checked yet the tail. Probably won't check before PR for
> > v5.8 is out.
> >=20
> > Just wondering would it hurt to merge everything up until this
> > patch?

Everything would be OK if you applied 1, 2 and 3.  Except we'd have an
ASN.1 API in the tree with no consumers, which excites some people.

> I.e. could land it also to the release.

That would likely be fine and should satisfy the API with no consumers
issue.

James
