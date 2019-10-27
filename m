From: Mimi Zohar <zohar@linux.ibm.com>
Date: Sun, 27 Oct 2019 14:33:30 +0000
Subject: Re: [PATCH v2 3/4] KEYS: Added BUILTIN_TRUSTED_KEYS enum to measure keys added to builtin_trusted_ke
Message-Id: <1572186810.4532.206.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
         <20191023233950.22072-4-nramas@linux.microsoft.com>
In-Reply-To: <20191023233950.22072-4-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Wed, 2019-10-23 at 16:39 -0700, Lakshmi Ramasubramanian wrote:
> Added an ima policy hook BUILTIN_TRUSTED_KEYS to measure keys added
> to builtin_trusted_keys keyring.
> 
> Added a helper function to check if the given keyring is
> the builtin_trusted_keys keyring.
> 
> Defined a function to map the keyring to ima policy hook function
> and use it when measuring the key.
 
.builtin_trusted_keys is a trusted keyring, which is created by the
kernel.  It cannot be deleted or replaced by userspace, so it should
be possible to correlate a keyring name with a keyring number on
policy load.

Other examples of trusted keyrings are: .ima, .evm, .platform,
.blacklist, .builtin_regdb_keys.  Instead of defining a keyring
specific method of getting the keyring number, define a generic
method.  For example, the userspace command "keyctl describe
%keyring:.builtin_trusted_keys" searches /proc/keys, but the kernel
shouldn't need to access /proc/keys.

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy |  1 +
>  certs/system_keyring.c               |  5 +++++
>  include/keys/system_keyring.h        |  2 ++
>  security/integrity/ima/ima.h         |  2 ++
>  security/integrity/ima/ima_api.c     |  1 +
>  security/integrity/ima/ima_main.c    | 25 +++++++++++++++++++++++--
>  security/integrity/ima/ima_queue.c   |  2 +-
>  7 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index fc376a323908..25566c74e679 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -29,6 +29,7 @@ Description:
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>  				[KEXEC_CMDLINE]
> +				[BUILTIN_TRUSTED_KEYS]

The .builtin_trusted_keys is the name of a keyring, not of an IMA
hook.  Define a new IMA policy "keyring=" option, where keyring is
optional.  Some IMA policy rules might look like:

# measure all keys
measure func=KEYRING_CHECK

# measure keys on the IMA keyring
measure func=KEYRING_CHECK keyring=".ima"

# measure keys on the BUILTIN and IMA keyrings into a different PCR
measure func=KEYRING_CHECK keyring=".builtin_trusted_keys|.ima" pcr


>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> 
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index bce430b3386e..986f80eead4d 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -605,6 +605,24 @@ int ima_load_data(enum kernel_load_data_id id)
>  	return 0;
>  }
>  
> +/*
> + * Maps the given keyring to a IMA Hook.
> + * @keyring: A keyring to which a key maybe linked to.
> + *
> + * This function currently handles only builtin_trusted_keys.
> + * To handle more keyrings, this function, ima hook and
> + * ima policy handler need to be updated.
> + */
> +static enum ima_hooks keyring_policy_map(struct key *keyring)
> +{
> +	enum ima_hooks func = NONE;
> +
> +	if (is_builtin_trusted_keyring(keyring))
> +		func = BUILTIN_TRUSTED_KEYS;
> +
> +	return func;
> +}
> +
>  /*
>   * process_buffer_measurement - Measure the buffer to ima log.
>   * @buf: pointer to the buffer that needs to be added to the log.
> @@ -706,19 +724,22 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  				   unsigned long flags, bool create)
>  {
>  	const struct public_key *pk;
> +	enum ima_hooks func;
>  
>  	if (key->type != &key_type_asymmetric)
>  		return;
>  
> +	func = keyring_policy_map(keyring);
> +

"func", in this case, should be something like "KEYRING_CHECK".  No
mapping is necessary.

>  	if (!ima_initialized) {
> -		ima_queue_key_for_measurement(key, NONE);
> +		ima_queue_key_for_measurement(key, func);
>  		return;
>  	}
>  
>  	pk = key->payload.data[asym_crypto];
>  	process_buffer_measurement(pk->key, pk->keylen,
>  				   key->description,
> -				   NONE, 0);
> +				   func, 0);

Pass the "keyring" to process_buffer_measurement() and on to
ima_get_action(), so that ima_get_action() determines whether the
keyring is in policy.

Mimi

>  }
>  
