From: Paul Moore <paul@paul-moore.com>
Date: Sun, 26 Apr 2020 20:53:31 +0000
Subject: Re: Problem with 9ba09998baa9 ("selinux: Implement the watch_key security hook") in linux-next
Message-Id: <CAHC9VhQbhG8-ZABtkZr1FXo9cuH4_nsbB=HP_fGvW+FNQ7iAXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <2136640.1587472186@warthog.procyon.org.uk> <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
 <3834193.1587771802@warthog.procyon.org.uk>
In-Reply-To: <3834193.1587771802@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, Apr 24, 2020 at 7:43 PM David Howells <dhowells@redhat.com> wrote:
>
> Paul Moore <paul@paul-moore.com> wrote:
>
> > > > and then use this newly created mapping function in [...]
> > > > selinux_watch_key()
> > >
> > > No, I think I should just hard-code KEY__VIEW there.
> >
> > FWIW, my comment was based on a version of linux-next where you were
> > making policycap based permission adjustments to KEY_VIEW and I
> > thought you would want the same adjustments to be applied to both
> > access control points.  That code appears to now be gone in
> > linux-next.
>
> I don't think I changed KEY_VIEW specifically; anyway, that code is on hold
> for the moment since it collides with this.
>
> What I was wondering is if I should change KEY_NEED_xxx from a bitmask into an
> enum to remove the confusion about whether or not you're allowed to provide
> multiple 'needs' OR'd together.
>
> > > +       perm = selinux_keyperm_to_av(need_perm);
> >
> > ... and add a check for (perm < 0) as discussed above if we stick with
> > the switch statement.
>
> Actually, there was supposed to be a:
>
>         if (!perm)
>                 return -EPERM;
>
> after that line.

Okay, can you send the next version of the patch to the SELinux list for review?

Thank you.

-- 
paul moore
www.paul-moore.com
