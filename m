From: "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Tue, 13 Aug 2019 00:49:27 +0000
Subject: Re: [PATCH v8 20/20] fscrypt: document the new ioctls and policy version
Message-Id: <20190813004927.GL28705@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-21-ebiggers@kernel.org>
In-Reply-To: <20190805162521.90882-21-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>

On Mon, Aug 05, 2019 at 09:25:21AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Update the fscrypt documentation file to catch up to all the latest
> changes, including the new ioctls to manage master encryption keys in
> the filesystem-level keyring and the support for v2 encryption policies.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, thanks!  Feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
