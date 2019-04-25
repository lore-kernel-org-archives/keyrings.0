From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Thu, 25 Apr 2019 04:27:50 +0000
Subject: Re: [PATCH 05/11] keys: Add a 'recurse' flag for keyring searches
Message-Id: <CAOq732KsRiXtGD9Wj-iGB77pqJbprCiuDKy_Ypi=dLfvn_9QNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk>
 <155612245200.8564.4960129218705025182.stgit@warthog.procyon.org.uk>
In-Reply-To: <155612245200.8564.4960129218705025182.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: ebiederm@xmission.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dwalsh@redhat.com, vgoyal@redhat.com

On Wed, 24 Apr 2019 at 18:14, David Howells <dhowells@redhat.com> wrote:
> Add a 'recurse' flag for keyring searches so that the flag can be omitted
> and recursion disabled, thereby allowing just the nominated keyring to be
> searched and none of the children.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  Documentation/security/keys/core.rst     |   10 ++++++----
>  certs/blacklist.c                        |    2 +-
>  crypto/asymmetric_keys/asymmetric_type.c |    2 +-
>  include/linux/key.h                      |    3 ++-
>  lib/digsig.c                             |    2 +-
>  net/rxrpc/security.c                     |    2 +-
>  security/integrity/digsig_asymmetric.c   |    4 ++--
>  security/keys/internal.h                 |    1 +
>  security/keys/keyctl.c                   |    2 +-
>  security/keys/keyring.c                  |   12 ++++++++++--
>  security/keys/proc.c                     |    3 ++-
>  security/keys/process_keys.c             |    3 ++-
>  security/keys/request_key.c              |    3 ++-
>  security/keys/request_key_auth.c         |    3 ++-
>  14 files changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
> index 9521c4207f01..99079b664036 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -1159,11 +1159,13 @@ payload contents" for more information.
>
>         key_ref_t keyring_search(key_ref_t keyring_ref,
>                                  const struct key_type *type,
> -                                const char *description)
> +                                const char *description,
> +                                bool recurse)
>
> -    This searches the keyring tree specified for a matching key. Error ENOKEY
> -    is returned upon failure (use IS_ERR/PTR_ERR to determine). If successful,
> -    the returned key will need to be released.
> +    This searches the specified keyring only (recurse = false) or keyring tree
> +    (recurse = true) specified for a matching key. Error ENOKEY is returned
> +    upon failure (use IS_ERR/PTR_ERR to determine). If successful, the returned
> +    key will need to be released.
>
>      The possession attribute from the keyring reference is used to control
>      access through the permissions mask and is propagated to the returned key
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 3a507b9e2568..181cb7fa9540 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -128,7 +128,7 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_len, const char *type)
>         *p = 0;
>
>         kref = keyring_search(make_key_ref(blacklist_keyring, true),
> -                             &key_type_blacklist, buffer);
> +                             &key_type_blacklist, buffer, false);
>         if (!IS_ERR(kref)) {
>                 key_ref_put(kref);
>                 ret = -EKEYREJECTED;
> diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
> index 69a0788a7de5..084027ef3121 100644
> --- a/crypto/asymmetric_keys/asymmetric_type.c
> +++ b/crypto/asymmetric_keys/asymmetric_type.c
> @@ -87,7 +87,7 @@ struct key *find_asymmetric_key(struct key *keyring,
>         pr_debug("Look up: \"%s\"\n", req);
>
>         ref = keyring_search(make_key_ref(keyring, 1),
> -                            &key_type_asymmetric, req);
> +                            &key_type_asymmetric, req, true);
>         if (IS_ERR(ref))
>                 pr_debug("Request for key '%s' err %ld\n", req, PTR_ERR(ref));
>         kfree(req);
> diff --git a/include/linux/key.h b/include/linux/key.h
> index b39f5876b66d..bdd179169508 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -333,7 +333,8 @@ extern int keyring_clear(struct key *keyring);
>
>  extern key_ref_t keyring_search(key_ref_t keyring,
>                                 struct key_type *type,
> -                               const char *description);
> +                               const char *description,
> +                               bool no_recurse);

No functional difference but it's "recurse" everywhere else.

Best regards
