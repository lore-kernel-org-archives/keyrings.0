From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 15 Sep 2020 09:09:50 +0000
Subject: Re: [PATCH v11 3/5] security: keys: trusted: fix TPM2 authorizations
Message-Id: <20200915090950.GB3612@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20200912172643.9063-1-James.Bottomley@HansenPartnership.com>
 <20200912172643.9063-4-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200912172643.9063-4-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Sat, Sep 12, 2020 at 10:26:41AM -0700, James Bottomley wrote:
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
> Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0 chips")
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I created a key:

$ sudo ./tpm2-root-key
0x80000000
$ sudo ./tpm2-list-handles
0x80000000
$ keyctl add trusted kmk "new 32 blobauth=3Dhello keyhandle=3D0x80000000"
<keyctl usage>
$ lsmod
Module                  Size  Used by
sha1_generic           16384  2
trusted                32768  0
asn1_encoder           16384  1 trusted
x86_pkg_temp_thermal    20480  0
iwlmvm                356352  0
iwlwifi               315392  1 iwlmvm
tpm_crb                16384  0
tpm_tis                16384  0
tpm_tis_core           24576  1 tpm_tis
tpm                    61440  4 tpm_tis,trusted,tpm_crb,tpm_tis_core
efivarfs               16384  1

What could be wrong? Have the full seris applied on a test kernel.

The root key creation is contained in create_root_key():

https://github.com/jsakkine-intel/tpm2-scripts/blob/master/tpm2.py

/Jarkko
