From: David Howells <dhowells@redhat.com>
Date: Wed, 13 May 2020 23:25:19 +0000
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
Message-Id: <3612472.1589412319@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <004ec27a-cc3a-c75c-952b-ff371b82b8d1@schaufler-ca.com> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com> <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
In-Reply-To: <004ec27a-cc3a-c75c-952b-ff371b82b8d1@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: dhowells@redhat.com, stephen.smalley.work@gmail.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > -	if (perm & ~KEY_NEED_ALL)
> > -		return -EINVAL;
> > +	switch (need_perm) {
> > +	default:
> > +		return -EACCES;
> ...
> Is the change from -EINVAL to -EACCES a bug fix?
> Does it introduce an incompatibility?

It shouldn't happen.  All the actual cases should be covered explicitly in the
switch.  It's to catch a programming issue in the kernel where a new value
gets added to the enum but not propagated to all the places that check for it.

I'd actually prefer it to be something even more obvious, especially as EINVAL
is so widely used in the kernel.  Should I put a WARN_ON in there?

David
