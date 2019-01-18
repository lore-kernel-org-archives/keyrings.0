From: Nayna <nayna@linux.vnet.ibm.com>
Date: Fri, 18 Jan 2019 14:35:27 +0000
Subject: Re: [PATCH v4 1/2] integrity, KEYS: add a reference to platform keyring
Message-Id: <3c7fa625-e77c-d6b4-35a4-8f8e9af60864@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190118091733.29940-1-kasong@redhat.com>
 <20190118091733.29940-2-kasong@redhat.com>
In-Reply-To: <20190118091733.29940-2-kasong@redhat.com>
To: Kairui Song <kasong@redhat.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org



On 01/18/2019 04:17 AM, Kairui Song wrote:
> commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
> introduced a .platform keyring for storing preboot keys, used for
> verifying kernel images' signature. Currently only IMA-appraisal is able
> to use the keyring to verify kernel images that have their signature
> stored in xattr.
>
> This patch exposes the .platform keyring, making it accessible for
> verifying PE signed kernel images as well.
>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Tested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   certs/system_keyring.c        | 9 +++++++++
>   include/keys/system_keyring.h | 5 +++++
>   security/integrity/digsig.c   | 6 ++++++
>   3 files changed, 20 insertions(+)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 81728717523d..4690ef9cda8a 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -24,6 +24,9 @@ static struct key *builtin_trusted_keys;
>   #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>   static struct key *secondary_trusted_keys;
>   #endif
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +static struct key *platform_trusted_keys;
> +#endif
>   
>   extern __initconst const u8 system_certificate_list[];
>   extern __initconst const unsigned long system_certificate_list_size;
> @@ -265,4 +268,10 @@ int verify_pkcs7_signature(const void *data, size_t len,
>   }
>   EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
>   
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +void __init set_platform_trusted_keys(struct key *keyring) {
> +	platform_trusted_keys = keyring;
> +}
> +#endif
> +
>   #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 359c2f936004..9e1b7849b6aa 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -61,5 +61,10 @@ static inline struct key *get_ima_blacklist_keyring(void)
>   }
>   #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
>   
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +
> +extern void __init set_platform_trusted_keys(struct key* keyring);
> +
> +#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
>   
>   #endif /* _KEYS_SYSTEM_KEYRING_H */
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index f45d6edecf99..bfabc2a8111d 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -89,6 +89,12 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
>   		keyring[id] = NULL;
>   	}
>   
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +	if (id = INTEGRITY_KEYRING_PLATFORM) {

Shouldn't it also check that keyring[id] is not NULL ?

Thanks & Regards,
     - Nayna

> +		set_platform_trusted_keys(keyring[id]);
> +	}
> +#endif
> +
>   	return err;
>   }
>   
