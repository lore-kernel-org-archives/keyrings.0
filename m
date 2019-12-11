From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 11 Dec 2019 18:00:55 +0000
Subject: Re: [RFC PATCH 0/3] xfstests: test adding filesystem-level fscrypt key via key_id
Message-Id: <20191211180054.GB82952@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191119223130.228341-1-ebiggers@kernel.org>
 <20191127204536.GA12520@linux.intel.com>
 <20191127225759.GA303989@sol.localdomain>
 <20191211095019.GA7077@linux.intel.com>
In-Reply-To: <20191211095019.GA7077@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org

Hi Jarkko,

On Wed, Dec 11, 2019 at 11:50:19AM +0200, Jarkko Sakkinen wrote:
> On Wed, Nov 27, 2019 at 02:57:59PM -0800, Eric Biggers wrote:
> > You could manually do what the xfstest does, which is more or less the following
> > (requires xfs_io patched with https://patchwork.kernel.org/patch/11252795/):
> 
> I postpone testing/reviewing this patch up until its depedencies are in
> the mainline.
> 
> I'll add these to my tree as soon as we have addressed a critical bug
> in tpm_tis:
> 
> 1. KEYS: remove CONFIG_KEYS_COMPAT
> 2. KEYS: asymmetric: return ENOMEM if akcipher_request_alloc() fails
> 
> Just mentioning that I haven't forgotten them.
> 

xfstests and xfsprogs are developed separately from the kernel, and their
maintainers don't apply patches that depend on non-mainlined features.  So
unless there are objections to the kernel patch [1], in a couple weeks I'll
apply it to the fscrypt tree for 5.6, and then once it's in mainline I'll resend
the patches for the test.  I've simply sent the test out early as an RFC, in
case it helps reviewing the kernel patch or in case there are early comments.

Again, while you're certainly welcome to manually test the kernel patch, it's
more important that we have test coverage of it in xfstests.

[1] https://lkml.kernel.org/linux-fscrypt/20191119222447.226853-1-ebiggers@kernel.org/

- Eric
