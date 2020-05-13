From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 May 2020 01:04:29 +0000
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
Message-Id: <CAHC9VhQhYz8xZ6MGv0S9q2D-gReb0Pqqb=2+oX=NVuxb_F5WfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
 <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
In-Reply-To: <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Casey Schaufler <casey@schaufler-ca.com>, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 6:33 PM David Howells <dhowells@redhat.com> wrote:
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
>
>  (4) An override due to an instantiation token being present.
>
>  (5) The permissions check is being deferred to later key_permission()
>      calls.
>
> The extra values give the opportunity for LSMs to audit these situations.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> cc: Paul Moore <paul@paul-moore.com>
> cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: keyrings@vger.kernel.org
> cc: selinux@vger.kernel.org
> ---
>
>  include/linux/key.h          |   30 ++++++++++++++++-----------
>  include/linux/security.h     |    6 +++--
>  security/keys/internal.h     |    8 ++++---
>  security/keys/keyctl.c       |   16 ++++++++-------
>  security/keys/permission.c   |   31 ++++++++++++++++++++++------
>  security/keys/process_keys.c |   46 ++++++++++++++++++++----------------------
>  security/security.c          |    6 +++--
>  security/selinux/hooks.c     |   25 ++++++++++++++++-------
>  security/smack/smack_lsm.c   |   31 +++++++++++++++++++++-------
>  9 files changed, 124 insertions(+), 75 deletions(-)

Thanks for clarifying this, it helps a lot.

My comments below are nitpicky, but take them into account, the style
of the SELinux code changes makes my eyes hurt.

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
> +       default:
> +               WARN_ON(1);
> +               return -EPERM;

Please move the default case to the bottom of the switch statement.

> -       sid = cred_sid(cred);
> +       case KEY_NEED_VIEW:     perm = KEY__VIEW;       break;
> +       case KEY_NEED_READ:     perm = KEY__READ;       break;
> +       case KEY_NEED_WRITE:    perm = KEY__WRITE;      break;
> +       case KEY_NEED_SEARCH:   perm = KEY__SEARCH;     break;
> +       case KEY_NEED_LINK:     perm = KEY__LINK;       break;
> +       case KEY_NEED_SETATTR:  perm = KEY__SETATTR;    break;

Please don't put the case statements all on one line, use the more
traditional multi-line format.  For example:

  case KEY_NEED_SETATTR:
          perm = KEY__SETATTR;
          break;

> +       }
>
> +       sid = cred_sid(cred);
>         key = key_ref_to_ptr(key_ref);
>         ksec = key->security;

-- 
paul moore
www.paul-moore.com
