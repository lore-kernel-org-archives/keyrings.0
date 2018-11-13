From: David Howells <dhowells@redhat.com>
Date: Tue, 13 Nov 2018 15:54:06 +0000
Subject: Re: [PATCH v3] keyutils: Add pkg-config file for keyutils library
Message-Id: <26710.1542124446@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <154204238794.56932.9923417628758022915.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <154204238794.56932.9923417628758022915.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +prefix=@prefix@
> +exec_prefix=@exec_prefix@

Is there any point to these two lines?  You added a 'PREFIX' variable to the
Makefile, but it's not used for anything.

David
