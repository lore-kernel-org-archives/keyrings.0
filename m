From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 15 Nov 2019 19:22:27 +0000
Subject: Re: [PATCH] fscrypt: support passing a keyring key to FS_IOC_ADD_ENCRYPTION_KEY
Message-Id: <20191115192227.GA150987@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191107001259.115018-1-ebiggers@kernel.org>
 <20191115172832.GA21300@linux.intel.com>
In-Reply-To: <20191115172832.GA21300@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-fscrypt@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Paul Crowley <paulcrowley@google.com>, Paul Lawrence <paullawrence@google.com>, keyrings@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, David Howells <dhowells@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>, Ondrej Kozina <okozina@redhat.com>

On Fri, Nov 15, 2019 at 07:28:53PM +0200, Jarkko Sakkinen wrote:
> 
> I don't see anything obviously wrong. Just would reformat it a bit.
> How you tested it?
> 

I'm not sure all the blank lines you're suggesting would be an improvement.
The ones in fscrypt_provisioning_key_preparse() might make sense though.

I'm working on an xfstest for this:

	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git/commit/?h=fscrypt-provisioning&id$ab6abb7cf6a80be44b7c72b73f0519ccaa5a97

It's not quite ready, though.  I'll post it for review when it is.

Someone is also planning to update Android userspace to use this.  So if there
are any issues from that, I'll hear about it.

- Eric
