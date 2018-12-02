From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sun, 02 Dec 2018 23:04:26 +0000
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
Message-Id: <20181202230426.GA6718@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
 <20181106164603.w46wspmdj5e4slwe@cantor>
 <1541528254.8568.48.camel@linux.ibm.com>
 <20181130234507.GA3792@linux.intel.com>
 <20181130234646.GB3792@linux.intel.com>
 <1543763436.4216.196.camel@linux.ibm.com>
In-Reply-To: <1543763436.4216.196.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: James Bottomley <jejb@linux.ibm.com>, Jerry Snitselaar <jsnitsel@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 10:10:36AM -0500, Mimi Zohar wrote:
> Are you asking about coordinating staging the trusted key patches to
> be upstreamed or about moving portions of the encrypted keys code out
> of the keyring subsystem?
>=20
> I'm not sure there needs to be a separate encrypted-keys pull request.
> =A0Either they can be upstreamed via the TPM or the integrity subsystem
> for now.

Nothing that ought to be rushed.

I'm speaking about this situation:

1. TPM 1.x trusted keys code is inside keyring subsystem.
2. TPM 2.0 trusted keys code is inside tpm subsystem.

We are doing effort to make TPM subsystem more friendly to send custom
commands outside (tpm_buf, my unnesting effort in progress, Tomas' clean
ups for TPM 1.x code) so I'm more dilated to the 2nd option.

/Jarkko
