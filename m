From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 18 Nov 2019 18:01:02 +0000
Subject: Re: [PATCH] fscrypt: support passing a keyring key to FS_IOC_ADD_ENCRYPTION_KEY
Message-Id: <20191118180102.GB5984@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191107001259.115018-1-ebiggers@kernel.org>
 <20191115172832.GA21300@linux.intel.com>
 <20191115192227.GA150987@sol.localdomain>
 <20191115225319.GB29389@linux.intel.com>
 <20191115230430.GA217050@gmail.com>
In-Reply-To: <20191115230430.GA217050@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Paul Crowley <paulcrowley@google.com>, Paul Lawrence <paullawrence@google.com>, keyrings@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, David Howells <dhowells@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>, Ondrej Kozina <okozina@redhat.com>

On Fri, Nov 15, 2019 at 03:04:31PM -0800, Eric Biggers wrote:
> On Sat, Nov 16, 2019 at 12:53:19AM +0200, Jarkko Sakkinen wrote:
> > 
> > > I'm working on an xfstest for this:
> > > 
> > > 	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git/commit/?h=fscrypt-provisioning&id$ab6abb7cf6a80be44b7c72b73f0519ccaa5a97
> > > 
> > > It's not quite ready, though.  I'll post it for review when it is.
> > > 
> > > Someone is also planning to update Android userspace to use this.  So if there
> > > are any issues from that, I'll hear about it.
> > 
> > Cool. Can you combine this patch and matching test (once it is done) to
> > a patch set?
> > 
> 
> xfstests is developed separately from the kernel (different git repo and
> maintainer), so combining kernel and xfstests patches into the same patchset
> doesn't make sense.  I can certainly send them out at the same time, though.

Is there instructions somewhere how to build and run these tests?

For me it is sufficient if you point a branch and have some kind
of instructions somewhere.

/Jarkko
