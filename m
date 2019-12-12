From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 12 Dec 2019 21:44:06 +0000
Subject: Re: [PATCH RESEND] KEYS: remove CONFIG_KEYS_COMPAT
Message-Id: <20191212214330.GA31054@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180105191947.91775-1-ebiggers3@gmail.com>
In-Reply-To: <20180105191947.91775-1-ebiggers3@gmail.com>
To: keyrings@vger.kernel.org

On Mon, Oct 14, 2019 at 10:53:54PM +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 09, 2019 at 04:04:43PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > KEYS_COMPAT now always takes the value of COMPAT && KEYS.  But the
> > security/keys/ directory is only compiled if KEYS is enabled, so in
> > practice KEYS_COMPAT is the same as COMPAT.  Therefore, remove the
> > unnecessary KEYS_COMPAT and just use COMPAT directly.
> > 
> > (Also remove an outdated comment from compat.c.)
> > 
> > Reviewed-by: James Morris <jamorris@linux.microsoft.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> (aka compiling with the different combinations).

I applied this to git://git.infradead.org/users/jjs/linux-tpmdd.git

/Jarkko
