From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 02 Aug 2019 17:31:49 +0000
Subject: Re: [PATCH v7 14/16] f2fs: wire up new fscrypt ioctls
Message-Id: <20190802173148.GA51937@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-15-ebiggers@kernel.org>
 <e3cf53a7-faf2-0321-22de-07d2e2783752@huawei.com>
In-Reply-To: <e3cf53a7-faf2-0321-22de-07d2e2783752@huawei.com>
To: Chao Yu <yuchao0@huawei.com>
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>

On Fri, Aug 02, 2019 at 04:10:15PM +0800, Chao Yu wrote:
> Hi Eric,
> 
> On 2019/7/27 6:41, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Wire up the new ioctls for adding and removing fscrypt keys to/from the
> > filesystem, and the new ioctl for retrieving v2 encryption policies.
> > 
> > FS_IOC_REMOVE_ENCRYPTION_KEY also required making f2fs_drop_inode() call
> > fscrypt_drop_inode().
> > 
> > For more details see Documentation/filesystems/fscrypt.rst and the
> > fscrypt patches that added the implementation of these ioctls.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> BTW, do you think it needs to make xxfs_has_support_encrypt() function be a
> common interface defined in struct fscrypt_operations, as I see all
> fscrypt_ioctl_*() needs to check with it, tho such cleanup is minor...
> 

Maybe.  It would work nicely for ext4 and f2fs, but ubifs does things
differently since it automatically enables the encryption feature if needed.
So we'd have to make the callback optional.

In any case, I think this should be separate from this patchset.

- Eric
