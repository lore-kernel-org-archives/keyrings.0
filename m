From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 15 Nov 2019 22:53:19 +0000
Subject: Re: [PATCH] fscrypt: support passing a keyring key to FS_IOC_ADD_ENCRYPTION_KEY
Message-Id: <20191115225319.GB29389@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191107001259.115018-1-ebiggers@kernel.org>
 <20191115172832.GA21300@linux.intel.com>
 <20191115192227.GA150987@sol.localdomain>
In-Reply-To: <20191115192227.GA150987@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Paul Crowley <paulcrowley@google.com>, Paul Lawrence <paullawrence@google.com>, keyrings@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, David Howells <dhowells@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>, Ondrej Kozina <okozina@redhat.com>

On Fri, Nov 15, 2019 at 11:22:27AM -0800, Eric Biggers wrote:
> On Fri, Nov 15, 2019 at 07:28:53PM +0200, Jarkko Sakkinen wrote:
> > 
> > I don't see anything obviously wrong. Just would reformat it a bit.
> > How you tested it?
> > 
> 
> I'm not sure all the blank lines you're suggesting would be an improvement.
> The ones in fscrypt_provisioning_key_preparse() might make sense though.

OK. Some of this aesthics comes from the feedback that I've received
during Intel SGX patch set review process (of course subsystem is
different i.e. x86). I tend to agree at least that before a new
conditional statement it is more readable if there is a blank line
before it.

> I'm working on an xfstest for this:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git/commit/?h=fscrypt-provisioning&id$ab6abb7cf6a80be44b7c72b73f0519ccaa5a97
> 
> It's not quite ready, though.  I'll post it for review when it is.
> 
> Someone is also planning to update Android userspace to use this.  So if there
> are any issues from that, I'll hear about it.

Cool. Can you combine this patch and matching test (once it is done) to
a patch set?

/Jarkko
