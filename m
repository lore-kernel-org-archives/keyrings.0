From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Apr 2020 22:17:46 +0000
Subject: Re: [PATCH] selinux: Fix use of KEY_NEED_* instead of KEY__* perms
Message-Id: <CAHC9VhTSuWLheaQDXwEyELGXEJOAXoFr2--FYhiviQbDHQKhkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <2136640.1587472186@warthog.procyon.org.uk> <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
 <3834193.1587771802@warthog.procyon.org.uk> <CAHC9VhQbhG8-ZABtkZr1FXo9cuH4_nsbB=HP_fGvW+FNQ7iAXg@mail.gmail.com>
 <355576.1587996734@warthog.procyon.org.uk> <CAEjxPJ4S0wpAtXoD1f-54qrriRC8y_hj9T5-vKOGDmf1XhOLrQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4S0wpAtXoD1f-54qrriRC8y_hj9T5-vKOGDmf1XhOLrQ@mail.gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>

On Mon, Apr 27, 2020 at 1:02 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Apr 27, 2020 at 10:13 AM David Howells <dhowells@redhat.com> wrote:

...

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 0b4e32161b77..6087955b49d8 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6539,20 +6539,38 @@ static void selinux_key_free(struct key *k)
> >         kfree(ksec);
> >  }
> >
> > +static unsigned int selinux_keyperm_to_av(unsigned int need_perm)
> > +{
> > +       switch (need_perm) {
> > +       case KEY_NEED_VIEW:     return KEY__VIEW;
> > +       case KEY_NEED_READ:     return KEY__READ;
> > +       case KEY_NEED_WRITE:    return KEY__WRITE;
> > +       case KEY_NEED_SEARCH:   return KEY__SEARCH;
> > +       case KEY_NEED_LINK:     return KEY__LINK;
> > +       case KEY_NEED_SETATTR:  return KEY__SETATTR;
> > +       default:
>
> Possibly WARN() or BUG() here?  Or BUILD_BUG_ON(KEY_NEED_ALL != 0x3f)
> to force an update here
> whenever a new key permission is defined?

My vote is for a build time check via BUILD_BUG_ON() or similar
mechanism.  It's worked really well in other places, I'm thinking
specifically of the SELinux netlink mapping.

> > +               return 0;
> > +       }
> > +}
> > +
> >  static int selinux_key_permission(key_ref_t key_ref,
> >                                   const struct cred *cred,
> > -                                 unsigned perm)
> > +                                 unsigned need_perm)
> >  {
> >         struct key *key;
> >         struct key_security_struct *ksec;
> > +       unsigned int perm;
> >         u32 sid;
> >
> >         /* if no specific permissions are requested, we skip the
> >            permission check. No serious, additional covert channels
> >            appear to be created. */
> > -       if (perm = 0)
> > +       if (need_perm = 0)
> >                 return 0;
> >
> > +       perm = selinux_keyperm_to_av(need_perm);
> > +       if (perm = 0)
> > +               return -EACCES;
>
> We should log or audit some kind of message here, whether via WARN(),
> audit_log(), or something, to avoid silent denials.

Assuming we add a build time check (see above), I think a WARN here is okay.

-- 
paul moore
www.paul-moore.com
