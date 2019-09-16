From: David Howells <dhowells@redhat.com>
Date: Mon, 16 Sep 2019 08:52:51 +0000
Subject: Re: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring subsystems
Message-Id: <32692.1568623971@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <33da71451cbc5836efd61ccf125be89c6e946253.camel@perches.com> <20190910143228.30305-1-jarkko.sakkinen@linux.intel.com> <11580.1568387033@warthog.procyon.org.uk>
In-Reply-To: <33da71451cbc5836efd61ccf125be89c6e946253.camel@perches.com>
To: Joe Perches <joe@perches.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, James Bottomley <jejb@linux.ibm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, open list <linux-kernel@vger.kernel.org>

Joe Perches <joe@perches.com> wrote:

> > I would recommend splitting the patch in two and putting something like:
> > 
> > 	keys: Add Jarkko Sakkinen as co-maintainer
> > 
> > as the subject of the keyrings maintainership one.
> 
> Why is there utility in micro splitting such a trivial patch?

Because the keyrings maintainership piece is addressing a major procedural
concern on Linus's part - and I think it needs to go in its own patch with the
subject I suggested.

David
