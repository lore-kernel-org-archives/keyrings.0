From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 20 Nov 2017 22:00:41 +0000
Subject: Re: TPM trusted keys code
Message-Id: <20171120220041.vh3vrmy7nztqpvqn@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171024160603.or2yflspzfrf3bfo@linux.intel.com>
In-Reply-To: <20171024160603.or2yflspzfrf3bfo@linux.intel.com>
To: keyrings@vger.kernel.org

On Thu, Nov 16, 2017 at 05:33:16PM +0200, Tudor Ambarus wrote:
> Hi, David,
> 
> On 10/26/2017 06:13 PM, David Howells wrote:
> > I have a partial asymmetric key subtype implementation that uses the TPM code
> > also - but that broken thoroughly when the tpm-2 stuff was added.
> 
> I would like to take a look at your implementation, if you don't mind.
> Have you made it public somewhere?
> 
> Thanks,
> ta

I'll start rework on TPM in-kernel API as soon as the SGX driver has
been upstreamed. Instead of a raw buffer you pass a struct tpm_buf
instance to tpm_send() and get also the response to that buffer.

There is a set of helpers to construct command buffers already widely
used inside the TPM driver.

I'll also move all the protocol specific constants to
include/linux/tpm.h.

/Jarkko
