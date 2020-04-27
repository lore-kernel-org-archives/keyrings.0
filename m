From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Apr 2020 14:36:00 +0000
Subject: Re: [PATCH] selinux: Fix use of KEY_NEED_* instead of KEY__* perms
Message-Id: <CAEjxPJ4ScTAbOOxd8FUa2XcfMqbNuWLxnHhRko=je2+0re8Ztg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <2136640.1587472186@warthog.procyon.org.uk> <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
 <3834193.1587771802@warthog.procyon.org.uk> <CAHC9VhQbhG8-ZABtkZr1FXo9cuH4_nsbB=HP_fGvW+FNQ7iAXg@mail.gmail.com>
 <355576.1587996734@warthog.procyon.org.uk>
In-Reply-To: <355576.1587996734@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>

On Mon, Apr 27, 2020 at 10:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Paul Moore <paul@paul-moore.com> wrote:
>
> > Okay, can you send the next version of the patch to the SELinux list for
> > review?
>
> Here you go.  Note that I did this a few days ago and I actually used EACCES
> rather than EPERM.  Which one is one preferred for this?

Generally SELinux returns EACCES unless the hook normally returns
EPERM (e.g. capable).
Should we use a build-time or runtime guard to catch introduction of
new KEY_NEED values without corresponding SELinux
permissions?

>
> David
> ---
> selinux: Fix use of KEY_NEED_* instead of KEY__* perms
>
> selinux_key_getsecurity() is passing the KEY_NEED_* permissions to
> security_sid_to_context() instead of the KEY__* values.  It happens to work

s/security_sid_to_context/avc_has_perm

> because the values are all coincident.

Shrug.  That was just a requirement on key permissions when they were
introduced; same is true of capabilities.
Not opposed to explicitly mapping them now but it isn't really a bug.

>
> Fixes: d720024e94de ("[PATCH] selinux: add hooks for key subsystem")
> Reported-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  security/selinux/hooks.c |   22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0b4e32161b77..6087955b49d8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6539,20 +6539,38 @@ static void selinux_key_free(struct key *k)
>         kfree(ksec);
>  }
>
> +static unsigned int selinux_keyperm_to_av(unsigned int need_perm)
> +{
> +       switch (need_perm) {
> +       case KEY_NEED_VIEW:     return KEY__VIEW;
> +       case KEY_NEED_READ:     return KEY__READ;
> +       case KEY_NEED_WRITE:    return KEY__WRITE;
> +       case KEY_NEED_SEARCH:   return KEY__SEARCH;
> +       case KEY_NEED_LINK:     return KEY__LINK;
> +       case KEY_NEED_SETATTR:  return KEY__SETATTR;
> +       default:
> +               return 0;
> +       }
> +}
> +
>  static int selinux_key_permission(key_ref_t key_ref,
>                                   const struct cred *cred,
> -                                 unsigned perm)
> +                                 unsigned need_perm)
>  {
>         struct key *key;
>         struct key_security_struct *ksec;
> +       unsigned int perm;
>         u32 sid;
>
>         /* if no specific permissions are requested, we skip the
>            permission check. No serious, additional covert channels
>            appear to be created. */
> -       if (perm = 0)
> +       if (need_perm = 0)
>                 return 0;
>
> +       perm = selinux_keyperm_to_av(need_perm);
> +       if (perm = 0)
> +               return -EACCES;
>         sid = cred_sid(cred);
>
>         key = key_ref_to_ptr(key_ref);
>
