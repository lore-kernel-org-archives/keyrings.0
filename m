From: David Howells <dhowells@redhat.com>
Date: Thu, 26 Oct 2017 15:13:35 +0000
Subject: Re: TPM trusted keys code
Message-Id: <27220.1509030815@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171024160603.or2yflspzfrf3bfo@linux.intel.com>
In-Reply-To: <20171024160603.or2yflspzfrf3bfo@linux.intel.com>
To: keyrings@vger.kernel.org

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> My rationale here is that it is domain specific code used by only one
> subsystem. For overall kernel arch it probably makes sense to have that
> code located in that subsystems and have TPM driver only provide great
> tools to implement that, right?
> 
> Just wanted to ask you before I start this effort. Thank you.

I have a partial asymmetric key subtype implementation that uses the TPM code
also - but that broken thoroughly when the tpm-2 stuff was added.  I'll have
to have another look at that (unless you want to), but it won't be till after
the next merge window.

My approach was to make a common library of routines that both the asymmetric
subtype and the trusted/encrypted types could use.

David
