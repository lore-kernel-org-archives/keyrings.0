From: Paul Moore <paul@paul-moore.com>
Date: Fri, 01 May 2020 16:37:32 +0000
Subject: Re: [PATCH] selinux: Fix use of KEY_NEED_* instead of KEY__* perms [v2]
Message-Id: <CAHC9VhTO0Ag-CODexD8hjZdTzUBEd4nJdR191o__=+iOLUHmFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <924658.1588078484@warthog.procyon.org.uk> <CAEjxPJ5+DtZfX36OLYiLbU=1tGZcPUWFUi1=mFfx=ntehtvd3Q@mail.gmail.com>
 <1072935.1588089479@warthog.procyon.org.uk> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>

On Tue, Apr 28, 2020 at 12:19 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Apr 28, 2020 at 11:58 AM David Howells <dhowells@redhat.com> wrote:
> > Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > > 1) Are we guaranteed that the caller only ever passes a single
> > > KEY_NEED_* perm at a time (i.e. hook is never called with a bitmask
> > > of multiple permissions)?  Where is that guarantee enforced?
> >
> > Currently it's the case that only one perm is ever used at once.  I'm tempted
> > to enforce this by switching the KEY_NEED_* to an enum rather than a bitmask.
> >
> > I'm not sure how I would actually define the meaning of two perms being OR'd
> > together.  Either okay?  Both required?
>
> Both required is the usual convention in functions like
> inode_permission() or avc_has_perm().
> But if you know that you'll never use combinations, we should just
> prohibit it up front, e.g.
> key_task_permission() or whatever can reject them before they reach
> the hook call.  Then the
> hook code doesn't have to revisit the issue.
>
> >
> > > 2) We had talked about adding a BUILD_BUG_ON() or other build-time
> > > guard
> >
> > That doesn't help you trap unallowed perm combinations, though.
>
> I think we want both.

Yep, we want both. #moarsafety

-- 
paul moore
www.paul-moore.com
