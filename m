From: "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Sun, 28 Jul 2019 15:08:02 +0000
Subject: Re: [PATCH v7 01/16] fs, fscrypt: move uapi definitions to new header <linux/fscrypt.h>
Message-Id: <20190728150802.GA6088@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-2-ebiggers@kernel.org>
In-Reply-To: <20190726224141.14044-2-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>

On Fri, Jul 26, 2019 at 03:41:26PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> More fscrypt definitions are being added, and we shouldn't use a
> disproportionate amount of space in <linux/fs.h> for fscrypt stuff.
> So move the fscrypt definitions to a new header <linux/fscrypt.h>.
> 
> For source compatibility with existing userspace programs, <linux/fs.h>
> still includes the new header.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
