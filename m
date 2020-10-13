From: Joe Perches <joe@perches.com>
Date: Tue, 13 Oct 2020 19:36:44 +0000
Subject: Re: [PATCH] MAINTAINERS: jarkko.sakkinen@linux.intel.com -> jarkko@kernel.org
Message-Id: <b1ccdfbb3119528490ea10f40e1da084b1b23f87.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20201013104705.140127-1-jarkko.sakkinen@linux.intel.com>
         <dce9442565fc3176ad770788bc1cf76b02080486.camel@perches.com>
         <20201013192524.GA164334@kernel.org>
In-Reply-To: <20201013192524.GA164334@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>

On Tue, 2020-10-13 at 22:25 +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 13, 2020 at 08:30:38AM -0700, Joe Perches wrote:
> > On Tue, 2020-10-13 at 13:46 +0300, Jarkko Sakkinen wrote:
> > > Use korg address as the main communications end point. Update the
> > > corresponding M-entries.
> > 
> > Maybe add an equivalent entry to .mailmap?
> 
> Ugh, neither has @linux.intel.com. So, I'll insert these two lines:
> 
> Jarkko Sakkinen <jarkko@kernel.org>
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I think a single line like works
Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@linux.intel.com>

Adding this to .mailmap gives:

$ ./scripts/get_maintainer.pl -f drivers/char/tpm/tpm-sysfs.c
Peter Huewe <peterhuewe@gmx.de> (maintainer:TPM DEVICE DRIVER)
Jarkko Sakkinen <jarkko@kernel.org> (maintainer:TPM DEVICE DRIVER)
Jason Gunthorpe <jgg@ziepe.ca> (reviewer:TPM DEVICE DRIVER)
linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER)
linux-kernel@vger.kernel.org (open list)

even without the MAINTAINER file changes

(though you should really do those too so
 people that read the file can use the
 proper address)

---
.mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e4ccac4e2f88..1e14566a3d56 100644
--- a/.mailmap
+++ b/.mailmap
@@ -133,6 +133,7 @@ James Ketrenos <jketreno@io.(none)>
 Jan Glauber <jan.glauber@gmail.com> <jang@de.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jang@linux.vnet.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
+Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@linux.intel.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
