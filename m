From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 09 Dec 2019 20:18:42 +0000
Subject: Re: [PATCH RESEND] KEYS: remove CONFIG_KEYS_COMPAT
Message-Id: <20191209201842.GD149190@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180105191947.91775-1-ebiggers3@gmail.com>
In-Reply-To: <20180105191947.91775-1-ebiggers3@gmail.com>
To: keyrings@vger.kernel.org

On Tue, Nov 12, 2019 at 10:08:48PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 11, 2019 at 10:20:47AM -0800, Eric Biggers wrote:
> > On Mon, Oct 14, 2019 at 10:53:54PM +0300, Jarkko Sakkinen wrote:
> > > On Wed, Oct 09, 2019 at 04:04:43PM -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > KEYS_COMPAT now always takes the value of COMPAT && KEYS.  But the
> > > > security/keys/ directory is only compiled if KEYS is enabled, so in
> > > > practice KEYS_COMPAT is the same as COMPAT.  Therefore, remove the
> > > > unnecessary KEYS_COMPAT and just use COMPAT directly.
> > > > 
> > > > (Also remove an outdated comment from compat.c.)
> > > > 
> > > > Reviewed-by: James Morris <jamorris@linux.microsoft.com>
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > (aka compiling with the different combinations).
> > > 
> > > /Jarkko
> > 
> > Ping.
> 
> I can pick this up to my v5.5-rc2 PR (already sent one for rc1).
> 
> /Jarkko

Ping.
