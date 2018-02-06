From: Eric Biggers <ebiggers@google.com>
Date: Tue, 06 Feb 2018 01:54:35 +0000
Subject: Re: [PATCH 1/1] KEYS: encrypted: fix buffer overread in valid_master_desc()
Message-Id: <20180206015435.GA91829@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180205200246.12253-1-jinqian@android.com>
In-Reply-To: <20180205200246.12253-1-jinqian@android.com>
To: linux-security-module@vger.kernel.org

On Mon, Feb 05, 2018 at 12:02:46PM -0800, Jin Qian wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> commit 794b4bc292f5d31739d89c0202c54e7dc9bc3add upstream
> 
> With the 'encrypted' key type it was possible for userspace to provide a
> data blob ending with a master key description shorter than expected,
> e.g. 'keyctl add encrypted desc "new x" @s'.  When validating such a
> master key description, validate_master_desc() could read beyond the end
> of the buffer.  Fix this by using strncmp() instead of memcmp().  [Also
> clean up the code to deduplicate some logic.]
> 
> Cc: stable@vger.kernel.org
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: James Morris <james.l.morris@oracle.com>
> Signed-off-by: Jin Qian <jinqian@android.com>
> ---
>  security/keys/encrypted-keys/encrypted.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 

Hi Jin, see Documentation/stable_kernel_rules.txt -- patches for stable should
be sent To: stable@vger.kernel.org (and generally with a lighter Cc: list,
unless it's a complicated backport), and you need to say which kernel version(s)
it should be applied to.  Also for upstream commits that cherry-pick cleanly,
such as this one, you don't need to send an actual patch but rather just request
that it be applied.  The reason it should be applied is helpful too; in this
case the commit fixes a bug that caused a KASAN warning.

Thanks!

- Eric
