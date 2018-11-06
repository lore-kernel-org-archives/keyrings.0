From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 06 Nov 2018 15:08:05 +0000
Subject: Re: [PATCH v2 2/3] keys: export find_keyring_by_name()
Message-Id: <1541516885.8568.29.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20180309153803.25859-1-nayna@linux.vnet.ibm.com>
         <20180309153803.25859-2-nayna@linux.vnet.ibm.com>
In-Reply-To: <20180309153803.25859-2-nayna@linux.vnet.ibm.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>, dhowells@redhat.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, jforbes@redhat.com, seth.forshee@canonical.com, pjones@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, ebiederm@xmission.com, kexec@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>

Hi Nayna,

On Fri, 2018-03-09 at 21:08 +0530, Nayna Jain wrote:
> This patch exports the function find_keyring_by_name() to be used by
> other subsystems.

Looking this patch over again, I realize that exported functions must
be prefixed with the subsystem name.  I'm also a bit concerned with
exporting find_keyring_by_name().  David, any comments?

Perhaps it would be better if IMA creates the .platform keyring so
that it has access to the keyring id instead.

Mimi
  
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> ---
> Changelog:
> 
> v2:
> * Fix the patch description per line length as suggested by Mimi
> 
>  include/linux/key.h      | 2 ++
>  security/keys/internal.h | 2 --
>  security/keys/keyring.c  | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/key.h b/include/linux/key.h
> index e58ee10f6e58..c8d332d4103c 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -346,6 +346,8 @@ static inline key_serial_t key_serial(const struct key *key)
> 
>  extern void key_set_timeout(struct key *, unsigned);
> 
> +extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
> +
>  /*
>   * The permissions required on a key that we're looking up.
>   */
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 9f8208dc0e55..8aa8d347a1ab 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -141,8 +141,6 @@ extern key_ref_t keyring_search_aux(key_ref_t keyring_ref,
>  extern key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx);
>  extern key_ref_t search_process_keyrings(struct keyring_search_context *ctx);
> 
> -extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
> -
>  extern int install_user_keyrings(void);
>  extern int install_thread_keyring_to_cred(struct cred *);
>  extern int install_process_keyring_to_cred(struct cred *);
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 41bcf57e96f2..4b9c3f1166d1 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1152,6 +1152,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
>  	read_unlock(&keyring_name_lock);
>  	return keyring;
>  }
> +EXPORT_SYMBOL(find_keyring_by_name);
> 
>  static int keyring_detect_cycle_iterator(const void *object,
>  					 void *iterator_data)
