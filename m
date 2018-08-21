From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Tue, 21 Aug 2018 18:30:04 +0000
Subject: Re: [PATCH 01/23] TPM: Add new TPMs to the tail of the list to prevent inadvertent change of dev
Message-Id: <20180821183004.GB25543@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
 <153486701644.13066.13372706238885253812.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486701644.13066.13372706238885253812.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com, jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

On Tue, Aug 21, 2018 at 04:56:56PM +0100, David Howells wrote:
> Add newly registered TPMs to the tail of the list, not the beginning, so that
> things that are specifying TPM_ANY_NUM don't find that the device they're
> using has inadvertently changed.  Adding a second device would break IMA, for
> instance.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> cc: stable@vger.kernel.org
> ---

We really should apply this patch...

Jason
