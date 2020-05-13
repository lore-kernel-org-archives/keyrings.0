From: David Howells <dhowells@redhat.com>
Date: Wed, 13 May 2020 23:13:31 +0000
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
Message-Id: <3611507.1589411611@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com> <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Stephen Smalley <stephen.smalley.work@gmail.com> wrote:

> >  (3) An override due to CAP_SYS_ADMIN.
> 
> CAP_SYS_ADMIN should never skip SELinux checking.  Even for Smack,
> there is a separate capability (CAP_MAC_ADMIN) for that purpose.

The LSM doesn't get consulted at the moment.  With this patch, it will get
consulted.

> >  (4) An override due to an instantiation token being present.
> 
> Not sure what this means but again we shouldn't skip SELinux checking
> based on mere possession of an object capability (not a POSIX
> capability).

The kernel has delegated the instantiation of a key to the calling process and
has given it a temporary key of type ".request_key_auth" which it has put into
force with keyctl(KEYCTL_ASSUME_AUTHORITY).

This authorisation token grants the caller the ability to (a) perform
operations on the key it wouldn't otherwise have permission to do, (b) use the
key instantiation keyctls and (c) temporarily search the keyrings of the
caller of request_key() using the creds of that caller and to read/use the
keys found therein if the caller was permitted to do so.

> It would be better if the permission indicated the actual operation
> (e.g. KEY_NEED_INVALIDATE_SPECIAL), and the decision whether to permit
> CAP_SYS_ADMIN processes to override was left to the security modules.
> SELinux doesn't automatically allow CAP_SYS_ADMIN processes to do
> everything.

These individual permissions don't exist yet.  I have an ACL patchset that
allows me to add a greater range - though there's issues with SELinux there
also.

Also, the keyrings are specially marked to say that the sysadmin is allowed to
flush them at the moment - but that can go away with the ACL stuff.

> > +       switch (need_perm) {
> > +       case KEY_NEED_UNLINK:
> > +       case KEY_SYSADMIN_OVERRIDE:
> > +       case KEY_AUTHTOKEN_OVERRIDE:
> > +       case KEY_DEFER_PERM_CHECK:
> >                 return 0;
> 
> We really shouldn't be skipping any/all checking on CAP_SYS_ADMIN or
> an AUTHTOKEN; those should still be subject to MAC policy.

I'm not sure how to do that.

Note that KEY_NEED_UNLINK *must not* be overruled by the MAC policy.  The
value is only there because lookup_user_key() requires something to be put
into that parameter - it's more of a courtesy thing, I suppose.

Why should AUTHTOKEN be subject to MAC policy?  The kernel has told the
process to go and instantiate a key.  It shouldn't really then turn around and
tell the process "oh, but you're not actually allowed to do that".

David
