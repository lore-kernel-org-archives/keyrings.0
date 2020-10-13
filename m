From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Tue, 13 Oct 2020 19:25:24 +0000
Subject: Re: [PATCH] MAINTAINERS: jarkko.sakkinen@linux.intel.com -> jarkko@kernel.org
Message-Id: <20201013192524.GA164334@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20201013104705.140127-1-jarkko.sakkinen@linux.intel.com>
 <dce9442565fc3176ad770788bc1cf76b02080486.camel@perches.com>
In-Reply-To: <dce9442565fc3176ad770788bc1cf76b02080486.camel@perches.com>
To: Joe Perches <joe@perches.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>

On Tue, Oct 13, 2020 at 08:30:38AM -0700, Joe Perches wrote:
> On Tue, 2020-10-13 at 13:46 +0300, Jarkko Sakkinen wrote:
> > Use korg address as the main communications end point. Update the
> > corresponding M-entries.
> 
> Maybe add an equivalent entry to .mailmap?

Ugh, neither has @linux.intel.com. So, I'll insert these two lines:

Jarkko Sakkinen <jarkko@kernel.org>
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > -M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > +M:	Jarkko Sakkinen <jarkko@kernel.org>

Thanks.

/Jarkko
