From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 12 Nov 2019 20:09:08 +0000
Subject: Re: [PATCH RESEND] KEYS: asymmetric: return ENOMEM if akcipher_request_alloc() fails
Message-Id: <20191112200908.GD11213@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190529210132.120114-1-ebiggers@kernel.org>
In-Reply-To: <20190529210132.120114-1-ebiggers@kernel.org>
To: keyrings@vger.kernel.org

On Mon, Nov 11, 2019 at 10:20:55AM -0800, Eric Biggers wrote:
> On Mon, Oct 14, 2019 at 10:48:46PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Oct 09, 2019 at 04:03:49PM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > No error code was being set on this error path.
> > > 
> > > Fixes: ad4b1eb5fb33 ("KEYS: asym_tpm: Implement encryption operation [ver #2]")
> > > Fixes: c08fed737126 ("KEYS: Implement encrypt, decrypt and sign for software asymmetric key [ver #2]")
> > > Reviewed-by: James Morris <jamorris@linux.microsoft.com>
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > I can pick this up to my tree given the TPM association. David?
> > 
> > /Jarkko
> 
> Ping.

I can pick this up to my v5.5-rc2 PR (already sent one for rc1).

/Jarkko
