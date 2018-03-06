From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Tue, 06 Mar 2018 15:44:01 +0000
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-Id: <20180306154401.GB13395@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
 <1520336251.7549.13.camel@linux.intel.com>
In-Reply-To: <1520336251.7549.13.camel@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>

On Tue, Mar 06, 2018 at 01:37:31PM +0200, Jarkko Sakkinen wrote:
> On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_probe() to use it.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Jason, is this now OK? I removed the error klog.

Sure the log message is gone - but I haven't been auditing your tpm_buf
work..

Jason
