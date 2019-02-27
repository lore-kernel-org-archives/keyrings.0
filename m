From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 27 Feb 2019 13:07:30 +0000
Subject: Re: [PATCH] RFC: user-mode extensible trusted key support
Message-Id: <20190227130730.GA12394@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190211173033.2493-1-Janne.Karhunen@gmail.com>
In-Reply-To: <20190211173033.2493-1-Janne.Karhunen@gmail.com>
To: janne.karhunen@gmail.com
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com

On Mon, Feb 11, 2019 at 07:30:33PM +0200, janne.karhunen@gmail.com wrote:
> From: Janne Karhunen <Janne.Karhunen@gmail.com>
> 
> Current kernel key subsystem only supports tpm to implement
> trusted keys. This is fine, but the tpm is poorly supported
> in the embedded world that primarily use custom trust roots,
> TEEs or even white box crypto. Problem with these setups is
> that they are extremely diverse, complex, proprietary and
> in some cases for valid reasons (white box).
> 
> This patch provides trial plumbing to enable declaration
> of new trust sources via tiny user mode helpers baked as
> part of the kernel image. If the hardware based trust source
> is available, the provided um helper can read the given
> device node and act as a translator for the kernel key
> requests and the actual device node can be kept out of the
> 'regular' userland. In the case of white box crypto, the
> um helper is free to perform any sort of software magic
> required to mangle the keys within the kernel keyring.
> 
> The kernel built-in usermode helper key operations are made
> available via new key type named 'ext-trusted' that is
> compatible with the existing userland utilities:
> keyctl add ext-trusted foo "new_umh 32" @u
> keyctl pipe `keyctl search @u ext-trusted foo` > foo.key
> keyctl add ext-trusted bar "load `cat foo.key`" @u
> ...
> 
> Signed-off-by: Janne Karhunen <Janne.Karhunen@gmail.com>
> Reviewed-by: Pekka Honkanen <Pekka.Honkanen@aalto.fi>

I guess this misses an actual workload to look at.

/Jarkko
