From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 13 May 2020 12:58:33 +0000
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
Message-Id: <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
 <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
In-Reply-To: <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, May 12, 2020 at 6:33 PM David Howells <dhowells@redhat.com> wrote:
>
> Since the meaning of combining the KEY_NEED_* constants is undefined, make
> it so that you can't do that by turning them into an enum.
>
> The enum is also given some extra values to represent special
> circumstances, such as:
>
>  (1) The '0' value is reserved and causes a warning to trap the parameter
>      being unset.
>
>  (2) The key is to be unlinked and we require no permissions on it, only
>      the keyring, (this replaces the KEY_LOOKUP_FOR_UNLINK flag).
>
>  (3) An override due to CAP_SYS_ADMIN.

CAP_SYS_ADMIN should never skip SELinux checking.  Even for Smack,
there is a separate capability (CAP_MAC_ADMIN) for that purpose.

>  (4) An override due to an instantiation token being present.

Not sure what this means but again we shouldn't skip SELinux checking
based on mere possession of an object capability (not a POSIX
capability).

>
>  (5) The permissions check is being deferred to later key_permission()
>      calls.
>
> The extra values give the opportunity for LSMs to audit these situations.
> ---

> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 7d8de1c9a478..6763ee45e04d 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -434,7 +434,7 @@ long keyctl_invalidate_key(key_serial_t id)
>
>                 /* Root is permitted to invalidate certain special keys */
>                 if (capable(CAP_SYS_ADMIN)) {
> -                       key_ref = lookup_user_key(id, 0, 0);
> +                       key_ref = lookup_user_key(id, 0, KEY_SYSADMIN_OVERRIDE);

It would be better if the permission indicated the actual operation
(e.g. KEY_NEED_INVALIDATE_SPECIAL), and the decision whether to permit
CAP_SYS_ADMIN processes to override was left to the security modules.
SELinux doesn't automatically allow CAP_SYS_ADMIN processes to do
everything.

> @@ -479,7 +479,8 @@ long keyctl_keyring_clear(key_serial_t ringid)
>
>                 /* Root is permitted to invalidate certain special keyrings */
>                 if (capable(CAP_SYS_ADMIN)) {
> -                       keyring_ref = lookup_user_key(ringid, 0, 0);
> +                       keyring_ref = lookup_user_key(ringid, 0,
> +                                                     KEY_SYSADMIN_OVERRIDE);

Ditto.

> @@ -663,7 +664,7 @@ long keyctl_describe_key(key_serial_t keyid,
>                                 key_put(instkey);
>                                 key_ref = lookup_user_key(keyid,
>                                                           KEY_LOOKUP_PARTIAL,
> -                                                         0);
> +                                                         KEY_AUTHTOKEN_OVERRIDE);

Similarly, it would be better if the permission indicated the
operation (e.g. KEY_NEED_DESCRIBE) rather than the means by which it
is being authorized.  A MAC scheme won't allow mere knowledge of a
token/password-capability to permit violation of its policy.

> @@ -1471,7 +1472,7 @@ long keyctl_set_timeout(key_serial_t id, unsigned timeout)
>                                 key_put(instkey);
>                                 key_ref = lookup_user_key(id,
>                                                           KEY_LOOKUP_PARTIAL,
> -                                                         0);
> +                                                         KEY_AUTHTOKEN_OVERRIDE);

Ditto.

> @@ -1579,7 +1580,8 @@ long keyctl_get_security(key_serial_t keyid,
>                         return PTR_ERR(instkey);
>                 key_put(instkey);
>
> -               key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, 0);
> +               key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL,
> +                                         KEY_AUTHTOKEN_OVERRIDE);

Ditto

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0b4e32161b77..3ff6b6dfc5ca 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6541,20 +6541,31 @@ static void selinux_key_free(struct key *k)
>
>  static int selinux_key_permission(key_ref_t key_ref,
>                                   const struct cred *cred,
> -                                 unsigned perm)
> +                                 enum key_need_perm need_perm)
>  {
>         struct key *key;
>         struct key_security_struct *ksec;
> -       u32 sid;
> +       u32 perm, sid;
>
> -       /* if no specific permissions are requested, we skip the
> -          permission check. No serious, additional covert channels
> -          appear to be created. */
> -       if (perm = 0)
> +       switch (need_perm) {
> +       case KEY_NEED_UNLINK:
> +       case KEY_SYSADMIN_OVERRIDE:
> +       case KEY_AUTHTOKEN_OVERRIDE:
> +       case KEY_DEFER_PERM_CHECK:
>                 return 0;

We really shouldn't be skipping any/all checking on CAP_SYS_ADMIN or
an AUTHTOKEN; those should still be subject to MAC policy.
