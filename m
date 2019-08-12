From: "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Mon, 12 Aug 2019 22:20:03 +0000
Subject: Re: [PATCH v8 05/20] fscrypt: rename fscrypt_master_key to fscrypt_direct_key
Message-Id: <20190812222003.GD28705@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-6-ebiggers@kernel.org>
In-Reply-To: <20190805162521.90882-6-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>

On Mon, Aug 05, 2019 at 09:25:06AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In preparation for introducing a filesystem-level keyring which will
> contain fscrypt master keys, rename the existing 'struct
> fscrypt_master_key' to 'struct fscrypt_direct_key'.  This is the
> structure in the existing table of master keys that's maintained to
> deduplicate the crypto transforms for v1 DIRECT_KEY policies.
> 
> I've chosen to keep this table as-is rather than make it automagically
> add/remove the keys to/from the filesystem-level keyring, since that
> would add a lot of extra complexity to the filesystem-level keyring.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good.  You can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
