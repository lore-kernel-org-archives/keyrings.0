From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 11 Dec 2019 11:03:00 +0000
Subject: Re: [PATCH RESEND] KEYS: remove CONFIG_KEYS_COMPAT
Message-Id: <20191211110300.GA16450@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180105191947.91775-1-ebiggers3@gmail.com>
In-Reply-To: <20180105191947.91775-1-ebiggers3@gmail.com>
To: keyrings@vger.kernel.org

On Mon, Dec 09, 2019 at 12:18:42PM -0800, Eric Biggers wrote:
> On Tue, Nov 12, 2019 at 10:08:48PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Nov 11, 2019 at 10:20:47AM -0800, Eric Biggers wrote:
> > > On Mon, Oct 14, 2019 at 10:53:54PM +0300, Jarkko Sakkinen wrote:
> > > > On Wed, Oct 09, 2019 at 04:04:43PM -0700, Eric Biggers wrote:
> > > > > From: Eric Biggers <ebiggers@google.com>
> > > > > 
> > > > > KEYS_COMPAT now always takes the value of COMPAT && KEYS.  But the
> > > > > security/keys/ directory is only compiled if KEYS is enabled, so in
> > > > > practice KEYS_COMPAT is the same as COMPAT.  Therefore, remove the
> > > > > unnecessary KEYS_COMPAT and just use COMPAT directly.
> > > > > 
> > > > > (Also remove an outdated comment from compat.c.)
> > > > > 
> > > > > Reviewed-by: James Morris <jamorris@linux.microsoft.com>
> > > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > 
> > > > (aka compiling with the different combinations).
> > > > 
> > > > /Jarkko
> > > 
> > > Ping.
> > 
> > I can pick this up to my v5.5-rc2 PR (already sent one for rc1).
> > 
> > /Jarkko
> 
> Ping.

rc1 was just out last Sunday so nothing could have happened to this
anyway. It is on my queue but we have to fix tpm_tis issues first.

/Jarkko
