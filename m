From: "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Tue, 30 Jul 2019 00:39:12 +0000
Subject: Re: [PATCH v7 15/16] ubifs: wire up new fscrypt ioctls
Message-Id: <20190730003912.GB16445@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-16-ebiggers@kernel.org>
In-Reply-To: <20190726224141.14044-16-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>

On Fri, Jul 26, 2019 at 03:41:40PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up the new ioctls for adding and removing fscrypt keys to/from the
> filesystem, and the new ioctl for retrieving v2 encryption policies.
> 
> FS_IOC_REMOVE_ENCRYPTION_KEY also required making UBIFS use
> fscrypt_drop_inode().
> 
> For more details see Documentation/filesystems/fscrypt.rst and the
> fscrypt patches that added the implementation of these ioctls.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

					- Ted
