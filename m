From: "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Mon, 29 Jul 2019 20:14:45 +0000
Subject: Re: [PATCH v7 06/16] fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl
Message-Id: <20190729201445.GA16445@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-7-ebiggers@kernel.org>
 <20190728185003.GF6088@mit.edu> <20190729194644.GE169027@gmail.com>
In-Reply-To: <20190729194644.GE169027@gmail.com>
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, linux-api@vger.kernel.org, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Paul Crowley <paulcrowley@google.com>, Satya Tangirala <satyat@google.com>

On Mon, Jul 29, 2019 at 12:46:45PM -0700, Eric Biggers wrote:
> > For that matter, we could just add a new ioctl which returns the file
> > system's keyring id.  That way an application program won't have to
> > try to figure out what a file's underlying sb->s_id happens to be.
> > (Especially if things like overlayfs are involved.)
> 
> Keep in mind that the new ioctls (FS_IOC_ADD_ENCRYPTION_KEY,
> FS_IOC_REMOVE_ENCRYPTION_KEY, FS_IOC_GET_ENCRYPTION_KEY_STATUS) don't take the
> keyring ID as a parameter, since it's already known from the filesystem the
> ioctl is executed on.  So there actually isn't much that can be done with the
> keyring ID.  But sure, if it's needed later we can add an API to get it.

Yeah, I was thinking about for testing/debugging purposes so that we
could use keyctl to examine the per-file system keyring and see what
keys are attached to a file system.  This is only going to be usable
by root, so I guess we can just try to figure it out by going through
/proc/keys and searching by sb->s_id.  If there are ambiguities that
make this hard to do, we can add an interface to make this easier.

     	       	      	     - Ted
