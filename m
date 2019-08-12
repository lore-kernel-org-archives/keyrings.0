From: "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Mon, 12 Aug 2019 22:53:28 +0000
Subject: Re: [PATCH v8 07/20] fscrypt: move v1 policy key setup to keysetup_v1.c
Message-Id: <20190812225328.GF28705@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-8-ebiggers@kernel.org>
In-Reply-To: <20190805162521.90882-8-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>

On Mon, Aug 05, 2019 at 09:25:08AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In preparation for introducing v2 encryption policies which will find
> and derive encryption keys differently from the current v1 encryption
> policies, move the v1 policy-specific key setup code from keyinfo.c into
> keysetup_v1.c.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, you can add

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
