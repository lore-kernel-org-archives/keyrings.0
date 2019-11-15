From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 15 Nov 2019 17:29:44 +0000
Subject: Re: [PATCH] fscrypt: support passing a keyring key to FS_IOC_ADD_ENCRYPTION_KEY
Message-Id: <20191115172944.GB21300@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191107001259.115018-1-ebiggers@kernel.org>
 <20191113203550.GI221701@gmail.com>
In-Reply-To: <20191113203550.GI221701@gmail.com>
To: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-fscrypt@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, Ondrej Mosnacek <omosnace@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, Paul Lawrence <paullawrence@google.com>, linux-mtd@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>, g@linux.intel.com

On Wed, Nov 13, 2019 at 12:35:51PM -0800, Eric Biggers wrote:
> On Wed, Nov 06, 2019 at 04:12:59PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Extend the FS_IOC_ADD_ENCRYPTION_KEY ioctl to allow the raw key to be
> > specified by a Linux keyring key, rather than specified directly.
> > 
> > This is useful because fscrypt keys belong to a particular filesystem
> > instance, so they are destroyed when that filesystem is unmounted.
> > Usually this is desired.  But in some cases, userspace may need to
> > unmount and re-mount the filesystem while keeping the keys, e.g. during
> > a system update.  This requires keeping the keys somewhere else too.
> > 
> > The keys could be kept in memory in a userspace daemon.  But depending
> > on the security architecture and assumptions, it can be preferable to
> > keep them only in kernel memory, where they are unreadable by userspace.
> > 
> > We also can't solve this by going back to the original fscrypt API
> > (where for each file, the master key was looked up in the process's
> > keyring hierarchy) because that caused lots of problems of its own.
> > 
> > Therefore, add the ability for FS_IOC_ADD_ENCRYPTION_KEY to accept a
> > Linux keyring key.  This solves the problem by allowing userspace to (if
> > needed) save the keys securely in a Linux keyring for re-provisioning,
> > while still using the new fscrypt key management ioctls.
> > 
> > This is analogous to how dm-crypt accepts a Linux keyring key, but the
> > key is then stored internally in the dm-crypt data structures rather
> > than being looked up again each time the dm-crypt device is accessed.
> > 
> > Use a custom key type "fscrypt-provisioning" rather than one of the
> > existing key types such as "logon".  This is strongly desired because it
> > enforces that these keys are only usable for a particular purpose: for
> > fscrypt as input to a particular KDF.  Otherwise, the keys could also be
> > passed to any kernel API that accepts a "logon" key with any service
> > prefix, e.g. dm-crypt, UBIFS, or (recently proposed) AF_ALG.  This would
> > risk leaking information about the raw key despite it ostensibly being
> > unreadable.  Of course, this mistake has already been made for multiple
> > kernel APIs; but since this is a new API, let's do it right.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> David and Jarkko, are you okay with this patch from a keyrings subsystem
> perspective?

Thanks for reminding. Still catching up with keyring. I gave some
feedback to the patch.

/Jarkko
