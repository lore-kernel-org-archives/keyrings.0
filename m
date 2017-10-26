From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 26 Oct 2017 16:16:47 +0000
Subject: Re: TPM trusted keys code
Message-Id: <20171026161647.k4klsehsb7i6cqu4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171024160603.or2yflspzfrf3bfo@linux.intel.com>
In-Reply-To: <20171024160603.or2yflspzfrf3bfo@linux.intel.com>
To: keyrings@vger.kernel.org

On Thu, Oct 26, 2017 at 04:13:35PM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > My rationale here is that it is domain specific code used by only one
> > subsystem. For overall kernel arch it probably makes sense to have that
> > code located in that subsystems and have TPM driver only provide great
> > tools to implement that, right?
> > 
> > Just wanted to ask you before I start this effort. Thank you.
> 
> I have a partial asymmetric key subtype implementation that uses the TPM code
> also - but that broken thoroughly when the tpm-2 stuff was added.  I'll have
> to have another look at that (unless you want to), but it won't be till after
> the next merge window.
> 
> My approach was to make a common library of routines that both the asymmetric
> subtype and the trusted/encrypted types could use.
> 
> David

That sounds like a awesome idea to me!

I'll continue to rework the TPM driver to the direction where you pass
struct tpm_buf to tpm_send() function instead of plain buffer.

After all the ad hoc code that trusted keys has to build TPM command
buffers can be taken away and replaced with tpm_buf helpers.

/Jarkko
