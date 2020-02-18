From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 18 Feb 2020 21:48:57 +0000
Subject: Re: [PATCH v2] xfs_io/encrypt: support passing a keyring key to add_enckey
Message-Id: <20200218214856.GA147283@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200203182013.43474-1-ebiggers@kernel.org>
In-Reply-To: <20200203182013.43474-1-ebiggers@kernel.org>
To: linux-xfs@vger.kernel.org
Cc: fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org

On Mon, Feb 03, 2020 at 10:20:13AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a '-k' option to the 'add_enckey' xfs_io command to allow exercising
> the key_id field that is being added to struct fscrypt_add_key_arg.
> 
> This is needed for the corresponding test in xfstests.
> 
> For more details, see the corresponding xfstests patches as well as
> kernel commit 93edd392cad7 ("fscrypt: support passing a keyring key to
> FS_IOC_ADD_ENCRYPTION_KEY").
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> No changes since v1.
> 
> This applies to the for-next branch of xfsprogs.
> 
>  configure.ac          |  1 +
>  include/builddefs.in  |  4 ++
>  io/encrypt.c          | 90 +++++++++++++++++++++++++++++++------------
>  m4/package_libcdev.m4 | 21 ++++++++++
>  man/man8/xfs_io.8     | 10 +++--
>  5 files changed, 98 insertions(+), 28 deletions(-)
> 

Any comments on this patch?  The corresponding xfstests patches were merged.

- Eric
