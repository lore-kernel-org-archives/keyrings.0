From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 18 Nov 2019 18:05:16 +0000
Subject: Re: [PATCH] fscrypt: support passing a keyring key to FS_IOC_ADD_ENCRYPTION_KEY
Message-Id: <20191118180516.GD5984@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191107001259.115018-1-ebiggers@kernel.org>
 <20191115172832.GA21300@linux.intel.com>
 <20191115192227.GA150987@sol.localdomain>
 <20191115225319.GB29389@linux.intel.com>
 <20191116000139.GB18146@mit.edu>
 <20191118180222.GC5984@linux.intel.com>
In-Reply-To: <20191118180222.GC5984@linux.intel.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, g@linux.intel.com
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Paul Crowley <paulcrowley@google.com>, Paul Lawrence <paullawrence@google.com>, keyrings@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, David Howells <dhowells@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>, Ondrej Kozina <okozina@redhat.com>

On Mon, Nov 18, 2019 at 08:02:22PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 15, 2019 at 07:01:39PM -0500, Theodore Y. Ts'o wrote:
> > On Sat, Nov 16, 2019 at 12:53:19AM +0200, Jarkko Sakkinen wrote:
> > > > I'm working on an xfstest for this:
> > > > 
> > > > 	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git/commit/?h=fscrypt-provisioning&id$ab6abb7cf6a80be44b7c72b73f0519ccaa5a97
> > > > 
> > > > It's not quite ready, though.  I'll post it for review when it is.
> > > > 
> > > > Someone is also planning to update Android userspace to use this.  So if there
> > > > are any issues from that, I'll hear about it.
> > > 
> > > Cool. Can you combine this patch and matching test (once it is done) to
> > > a patch set?
> > 
> > That's generally not done since the test goes to a different repo
> > (xfstests.git) which has a different review process from the kernel
> > change.
> 
> OK, sorry, both fscrypt and xfstests are both somewhat alien to me. That
> is why I'm looking into setting up test environment so that I can review
> these patches with a sane judgement.

And also since I've just barely started to help David on co-maintaining
keyring it is better to put extra emphasis on testing even for the most
trivial patches. That is fastest way to learn different interactions.

/Jarkko
