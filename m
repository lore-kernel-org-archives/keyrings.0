From: David Howells <dhowells@redhat.com>
Date: Wed, 13 May 2020 23:16:12 +0000
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
Message-Id: <3611715.1589411772@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHC9VhQhYz8xZ6MGv0S9q2D-gReb0Pqqb=2+oX=NVuxb_F5WfA@mail.gmail.com> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com> <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAHC9VhQhYz8xZ6MGv0S9q2D-gReb0Pqqb=2+oX=NVuxb_F5WfA@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: dhowells@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Casey Schaufler <casey@schaufler-ca.com>, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> wrote:

> > +       case KEY_NEED_VIEW:     perm = KEY__VIEW;       break;
> > +       case KEY_NEED_READ:     perm = KEY__READ;       break;
> > +       case KEY_NEED_WRITE:    perm = KEY__WRITE;      break;
> > +       case KEY_NEED_SEARCH:   perm = KEY__SEARCH;     break;
> > +       case KEY_NEED_LINK:     perm = KEY__LINK;       break;
> > +       case KEY_NEED_SETATTR:  perm = KEY__SETATTR;    break;
> 
> Please don't put the case statements all on one line, use the more
> traditional multi-line format.  For example:
> 
>   case KEY_NEED_SETATTR:
>           perm = KEY__SETATTR;
>           break;

Tabulation was invented something like 6000 years ago for just this kind of
purpose;-)  It's less readable your way, but whatever...

David
