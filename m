From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 14 Nov 2019 14:54:27 +0000
Subject: Re: [PATCH v7 3/5] KEYS: Call the IMA hook to measure keys
Message-Id: <1573743267.4793.43.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
         <20191114031202.18012-4-nramas@linux.microsoft.com>
In-Reply-To: <20191114031202.18012-4-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2019-11-13 at 19:12 -0800, Lakshmi Ramasubramanian wrote:
> Call the IMA hook from key_create_or_update function to measure
> the key when a new key is created or an existing key is updated.
> 
> This patch adds the call to the IMA hook from key_create_or_update
> function to measure the key on key create or update.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

No need to Cc David Howells on the entire patch set.  Just Cc him,
here, after your tag.

With this patch, keys are now being measured.  With the boot command
line, we can verify the measurement entry against /proc/cmdline.  How
can the key measurement entry be verified?  Please include that
information, here, in this patch description.

Also, can the key data, now included in the measurement list, be used
to verify signatures in the ima-sig or ima-modsig templates?  Is there
a way of correlating a signature with a key?  Perhaps include a
kselftest as an example.

Mimi

> ---
>  include/linux/ima.h | 13 +++++++++++++
>  security/keys/key.c |  7 +++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 6d904754d858..0af88b781ab6 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -25,6 +25,12 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  extern void ima_post_path_mknod(struct dentry *dentry);
>  extern void ima_kexec_cmdline(const void *buf, int size);
>  
> +#ifdef CONFIG_KEYS
> +extern void ima_post_key_create_or_update(struct key *keyring,
> +					  struct key *key,
> +					  unsigned long flags, bool create);
> +#endif
> +
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
>  #endif
> @@ -101,6 +107,13 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
>  {}
>  #endif
>  
> +#ifndef CONFIG_KEYS
> +static inline void ima_post_key_create_or_update(struct key *keyring,
> +						 struct key *key,
> +						 unsigned long flags,
> +						 bool create) {}
> +#endif
> +
>  #ifdef CONFIG_IMA_APPRAISE
>  extern bool is_ima_appraise_enabled(void);
>  extern void ima_inode_post_setattr(struct dentry *dentry);
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 764f4c57913e..a0f1e7b3b8b9 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -13,6 +13,7 @@
>  #include <linux/security.h>
>  #include <linux/workqueue.h>
>  #include <linux/random.h>
> +#include <linux/ima.h>
>  #include <linux/err.h>
>  #include "internal.h"
>  
> @@ -936,6 +937,8 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  		goto error_link_end;
>  	}
>  
> +	ima_post_key_create_or_update(keyring, key, flags, true);
> +
>  	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
>  
>  error_link_end:
> @@ -965,6 +968,10 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  	}
>  
>  	key_ref = __key_update(key_ref, &prep);
> +
> +	if (!IS_ERR(key_ref))
> +		ima_post_key_create_or_update(keyring, key, flags, false);
> +
>  	goto error_free_prep;
>  }
>  EXPORT_SYMBOL(key_create_or_update);
