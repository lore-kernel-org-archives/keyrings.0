From: Paul Moore <paul@paul-moore.com>
Date: Fri, 17 Apr 2020 16:59:10 +0000
Subject: Re: Problem with 9ba09998baa9 ("selinux: Implement the watch_key security hook") in linux-next
Message-Id: <CAHC9VhQLYNzs=uBqxwZCh=h8n-C3z-EAojQEmt6DCoJxCKL5-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <56808ee47c8b6e184fd013b90072c6fb07ef84f2.camel@btinternet.com>
In-Reply-To: <56808ee47c8b6e184fd013b90072c6fb07ef84f2.camel@btinternet.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, Apr 17, 2020 at 12:32 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Fri, 2020-04-17 at 11:48 -0400, Paul Moore wrote:
> > I just notice that the "selinux: Implement the watch_key security
> > hook" patch made it's way into linux-next via 9ba09998baa9:
> >
> >   commit 9ba09998baa995518d94c9a32e6329b28ccb9045
> >   Author: David Howells <dhowells@redhat.com>
> >   Date:   Tue Jan 14 17:07:13 2020 +0000
> >
> >    selinux: Implement the watch_key security hook
> >
> >    Implement the watch_key security hook to make sure that a key
> > grants the
> >    caller View permission in order to set a watch on a key.
> >
> >    For the moment, the watch_devices security hook is left
> > unimplemented as
> >    it's not obvious what the object should be since the queue is
> > global and
> >    didn't previously exist.
> >
> >    Signed-off-by: David Howells <dhowells@redhat.com>
> >    Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> >
> > I'm reasonably confident that this code hasn't been tested as I
> > expect
> > it would fail, or at the very least behave in unintended ways.  The
> > problem is the selinux_watch_key(...) function, shown below:
>
> I built an selinx-testsuite test for this last year and it worked fine
> then. I'll send the test as an RFC patch as its been some time since I
> ran it. David also has a test in kernel
> samples/watch_queue/watch_test.c

See below.

> > +static int selinux_watch_key(struct key *key)
> > +{
> > +       struct key_security_struct *ksec = key->security;
> > +       u32 sid = current_sid();
> > +
> > +       return avc_has_perm(&selinux_state,
> > +                           sid, ksec->sid, SECCLASS_KEY,
> > KEY_NEED_VIEW, NULL);
> > +}
> >
> > ... in particular it is the fifth argument to avc_has_perm(),
> > "KEY_NEED_VIEW" which is a problem.  KEY_NEED_VIEW is not a SELinux
>
> True, however by magic the KEY_NEED_* perms match with the bits defined
> in classmap.h. I did some work on this during the 'keys' saga, see
> various emails in list like [1]
>
> [1]
> https://lore.kernel.org/selinux/20200220181031.156674-2-richard_c_haines@btinternet.com/

Esh, relying on the constants to line up is a recipe for disaster.  We
really need that permission translation layer.

-- 
paul moore
www.paul-moore.com
