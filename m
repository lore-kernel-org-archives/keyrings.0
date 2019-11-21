From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 21 Nov 2019 00:25:29 +0000
Subject: Re: [RFC PATCH 3/3] generic: test adding filesystem-level fscrypt key via key_id
Message-Id: <20191121002528.GE168530@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191119223130.228341-1-ebiggers@kernel.org>
 <20191119223130.228341-4-ebiggers@kernel.org>
In-Reply-To: <20191119223130.228341-4-ebiggers@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

On Tue, Nov 19, 2019 at 02:31:30PM -0800, Eric Biggers wrote:
> +# Require support for adding a key to a filesystem's fscrypt keyring via an
> +# "fscrypt-provisioning" keyring key.
> +_require_add_enckey_by_key_id()
> +{
> +	local mnt=$1
> +
> +	# Userspace support
> +	_require_xfs_io_command "add_enckey" "-k"
> +
> +	# Kernel support
> +	if $XFS_IO_PROG -c "$add_enckey -k 12345 $mnt" \
> +		|& grep -q 'Invalid argument'; then
> +		_notrun "Kernel doesn't support key_id parameter to FS_IOC_ADD_ENCRYPTION_KEY"
> +	fi
> +}

There's a bug here that makes the test not be skipped when it should.
It should say:

	if $XFS_IO_PROG -c "add_enckey -k 12345" "$mnt" \

I'll fix this in the next version.

- Eric
