From: Eric Snowberg <eric.snowberg@oracle.com>
Date: Tue, 19 Nov 2019 01:18:13 +0000
Subject: Re: [PATCH v8 3/5] KEYS: Call the IMA hook to measure keys
Message-Id: <886A71DC-B2B9-4C25-90D6-511E86F2CA19@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-4-nramas@linux.microsoft.com>
In-Reply-To: <20191118223818.3353-4-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: zohar@linux.ibm.com, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org


> On Nov 18, 2019, at 3:38 PM, Lakshmi Ramasubramanian <nramas@linux.microsoft.com> wrote:
> 
> Call the IMA hook from key_create_or_update function to measure
> the key when a new key is created or an existing key is updated.
> 
> This patch adds the call to the IMA hook from key_create_or_update
> function to measure the key on key create or update.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: James Morris <jamorris@linux.microsoft.com>
> ---
> include/linux/ima.h | 13 +++++++++++++
> security/keys/key.c |  7 +++++++
> 2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 6d904754d858..6b0824b7a32f 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -25,6 +25,12 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
> extern void ima_post_path_mknod(struct dentry *dentry);
> extern void ima_kexec_cmdline(const void *buf, int size);
> 
> +#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +extern void ima_post_key_create_or_update(struct key *keyring,
> +					  struct key *key,
> +					  unsigned long flags, bool create);
> +#endif

The extern void ima_post_key_create_or_update will only be defined if CONFIG_IMA=y.

> +
> #ifdef CONFIG_IMA_KEXEC
> extern void ima_add_kexec_buffer(struct kimage *image);
> #endif
> @@ -101,6 +107,13 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
> {}
> #endif
> 
> +#ifndef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +static inline void ima_post_key_create_or_update(struct key *keyring,
> +						 struct key *key,
> +						 unsigned long flags,
> +						 bool create) {}
> +#endif
> +
> #ifdef CONFIG_IMA_APPRAISE
> extern bool is_ima_appraise_enabled(void);
> extern void ima_inode_post_setattr(struct dentry *dentry);
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 764f4c57913e..a0f1e7b3b8b9 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -13,6 +13,7 @@
> #include <linux/security.h>
> #include <linux/workqueue.h>
> #include <linux/random.h>
> +#include <linux/ima.h>
> #include <linux/err.h>
> #include "internal.h"
> 
> @@ -936,6 +937,8 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
> 		goto error_link_end;
> 	}
> 
> +	ima_post_key_create_or_update(keyring, key, flags, true);

This will cause a compile error if CONFIG_IMA is not defined and CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y.

security/keys/key.c: In function 'key_create_or_update':
security/keys/key.c:940:2: error: implicit declaration of function 'ima_post_key_create_or_update'; did you mean 'key_create_or_update'? [-Werror=implicit-function-declaration]
  ima_post_key_create_or_update(keyring, key, flags, true);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  key_create_or_update
cc1: some warnings being treated as errors


> +
> 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
> 
> error_link_end:
> @@ -965,6 +968,10 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
> 	}
> 
> 	key_ref = __key_update(key_ref, &prep);
> +
> +	if (!IS_ERR(key_ref))
> +		ima_post_key_create_or_update(keyring, key, flags, false);
> +
> 	goto error_free_prep;
> }
> EXPORT_SYMBOL(key_create_or_update);
> -- 
> 2.17.1
> 
