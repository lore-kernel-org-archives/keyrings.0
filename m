From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 25 Feb 2020 16:48:50 +0000
Subject: Re: [PATCH v5 3/6] security: keys: trusted fix tpm2 authorizations
Message-Id: <20200225164850.GB15662@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
 <20200130101812.6271-4-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200130101812.6271-4-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Thu, Jan 30, 2020 at 11:18:09AM +0100, James Bottomley wrote:
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
4f2258f"
>=20
> after we will accept both the old hex sha1 form as well as a new
> directly supplied password:
>=20
> keyctl add trusted kmk "new 32 blobauth=3Dhello keyhandle=81000001"
>=20
> Since a sha1 hex code must be exactly 40 bytes long and a direct
> password must be 20 or less, we use the length as the discriminator
> for which form is input.
>=20
> Note this is both and enhancement and a potential bug fix.  The TPM
> 2.0 spec requires us to strip leading zeros, meaning empyty
> authorization is a zero length HMAC whereas we're currently passing in
> 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this patch
> makes the Microsoft TPM emulator work with trusted keys.
>=20
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Should have a fixes tag.

> ---
>  include/keys/trusted-type.h               |  1 +
>  security/keys/trusted-keys/trusted_tpm1.c | 26 +++++++++++++++++++++-----
>  security/keys/trusted-keys/trusted_tpm2.c | 10 ++++++----
>  3 files changed, 28 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index a94c03a61d8f..b2ed3481c6a0 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -30,6 +30,7 @@ struct trusted_key_options {
>  	uint16_t keytype;
>  	uint32_t keyhandle;
>  	unsigned char keyauth[TPM_DIGEST_SIZE];
> +	uint32_t blobauth_len;
>  	unsigned char blobauth[TPM_DIGEST_SIZE];
>  	uint32_t pcrinfo_len;
>  	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/tr=
usted-keys/trusted_tpm1.c
> index d2c5ec1e040b..3f33d3f74d3c 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -781,12 +781,28 @@ static int getoptions(char *c, struct trusted_key_p=
ayload *pay,
>  				return -EINVAL;
>  			break;
>  		case Opt_blobauth:
> -			if (strlen(args[0].from) !=3D 2 * SHA1_DIGEST_SIZE)
> -				return -EINVAL;
> -			res =3D hex2bin(opt->blobauth, args[0].from,
> -				      SHA1_DIGEST_SIZE);
> -			if (res < 0)
> +			/*
> +			 * TPM 1.2 authorizations are sha1 hashes
> +			 * passed in as hex strings.  TPM 2.0
> +			 * authorizations are simple passwords
> +			 * (although it can take a hash as well)

Justify to the 80 character line length.

> +			 */
> +			opt->blobauth_len =3D strlen(args[0].from);
> +			if (opt->blobauth_len =3D 2 * TPM_DIGEST_SIZE) {
> +				res =3D hex2bin(opt->blobauth, args[0].from,
> +					      TPM_DIGEST_SIZE);
> +				if (res < 0)
> +					return -EINVAL;
> +
> +				opt->blobauth_len =3D TPM_DIGEST_SIZE;
> +			} else if (tpm2 &&
> +				   opt->blobauth_len <=3D sizeof(opt->blobauth)) {
> +				memcpy(opt->blobauth, args[0].from,
> +				       opt->blobauth_len);
> +			} else {
>  				return -EINVAL;
> +			}

This starts to be unnecessarily complicated.

This is what I would suggest:

opt->blobauth_len =3D strlen(args[0].from);
if (opt->blobauth_len =3D 2 * TPM_DIGEST_SIZE) {
	res =3D hex2bin(opt->blobauth, args[0].from,
		      TPM_DIGEST_SIZE);
	if (res < 0)
		return -EINVAL;

	opt->blobauth_len =3D TPM_DIGEST_SIZE;
	return 0;
}

if (tpm2 && opt->blobauth_len <=3D sizeof(opt->blobauth)) {
	memcpy(opt->blobauth, args[0].from,
	       opt->blobauth_len);
	return 0;
}

return -EINVAL;

Easier to see quickly "when happens what".

/Jarkko
