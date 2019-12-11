From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 11 Dec 2019 09:50:19 +0000
Subject: Re: [RFC PATCH 0/3] xfstests: test adding filesystem-level fscrypt key via key_id
Message-Id: <20191211095019.GA7077@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191119223130.228341-1-ebiggers@kernel.org>
 <20191127204536.GA12520@linux.intel.com>
 <20191127225759.GA303989@sol.localdomain>
In-Reply-To: <20191127225759.GA303989@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>, dhowells@redhat.com
Cc: fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org

On Wed, Nov 27, 2019 at 02:57:59PM -0800, Eric Biggers wrote:
> You could manually do what the xfstest does, which is more or less the following
> (requires xfs_io patched with https://patchwork.kernel.org/patch/11252795/):

I postpone testing/reviewing this patch up until its depedencies are in
the mainline.

I'll add these to my tree as soon as we have addressed a critical bug
in tpm_tis:

1. KEYS: remove CONFIG_KEYS_COMPAT
2. KEYS: asymmetric: return ENOMEM if akcipher_request_alloc() fails

Just mentioning that I haven't forgotten them.

/Jarkko
