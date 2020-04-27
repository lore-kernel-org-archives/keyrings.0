From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Apr 2020 15:24:17 +0000
Subject: Re: [PATCH] selinux: Fix use of KEY_NEED_* instead of KEY__* perms
Message-Id: <CAHC9VhRQfq+QsmdwkNfLs8bs8xGnBOA3_G=+--13sTmUkdjgCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <2136640.1587472186@warthog.procyon.org.uk> <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
 <3834193.1587771802@warthog.procyon.org.uk> <CAHC9VhQbhG8-ZABtkZr1FXo9cuH4_nsbB=HP_fGvW+FNQ7iAXg@mail.gmail.com>
 <355576.1587996734@warthog.procyon.org.uk> <CAEjxPJ4ScTAbOOxd8FUa2XcfMqbNuWLxnHhRko=je2+0re8Ztg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ScTAbOOxd8FUa2XcfMqbNuWLxnHhRko=je2+0re8Ztg@mail.gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>

On Mon, Apr 27, 2020 at 10:36 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Apr 27, 2020 at 10:13 AM David Howells <dhowells@redhat.com> wrote:
> >
> > Paul Moore <paul@paul-moore.com> wrote:
> >
> > > Okay, can you send the next version of the patch to the SELinux list for
> > > review?
> >
> > Here you go.  Note that I did this a few days ago and I actually used EACCES
> > rather than EPERM.  Which one is one preferred for this?
>
> Generally SELinux returns EACCES unless the hook normally returns
> EPERM (e.g. capable).
> Should we use a build-time or runtime guard to catch introduction of
> new KEY_NEED values without corresponding SELinux
> permissions?
>
> >
> > David
> > ---
> > selinux: Fix use of KEY_NEED_* instead of KEY__* perms
> >
> > selinux_key_getsecurity() is passing the KEY_NEED_* permissions to
> > security_sid_to_context() instead of the KEY__* values.  It happens to work
>
> s/security_sid_to_context/avc_has_perm
>
> > because the values are all coincident.
>
> Shrug.  That was just a requirement on key permissions when they were
> introduced; same is true of capabilities.
> Not opposed to explicitly mapping them now but it isn't really a bug.

I haven't looked at the rest of the patch yet, but I wanted to make a
quick comment on this ... over the years I've seen a number of
problems that crop up because of cross-subsytem assumptions, unless
there is some performance critical path where the mapping is
problematic I would prefer to see a translation layer to help protect
SELinux.

-- 
paul moore
www.paul-moore.com
