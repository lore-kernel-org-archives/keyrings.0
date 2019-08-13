From: "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Tue, 13 Aug 2019 00:15:55 +0000
Subject: Re: [PATCH v8 15/20] fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS ioctl
Message-Id: <20190813001555.GJ28705@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-16-ebiggers@kernel.org>
In-Reply-To: <20190805162521.90882-16-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>

On Mon, Aug 05, 2019 at 09:25:16AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a root-only variant of the FS_IOC_REMOVE_ENCRYPTION_KEY ioctl which
> removes all users' claims of the key, not just the current user's claim.
> I.e., it always removes the key itself, no matter how many users have
> added it.
> 
> This is useful for forcing a directory to be locked, without having to
> figure out which user ID(s) the key was added under.  This is planned to
> be used by a command like 'sudo fscrypt lock DIR --all-users' in the
> fscrypt userspace tool (http://github.com/google/fscrypt).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, thanks.   Feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
