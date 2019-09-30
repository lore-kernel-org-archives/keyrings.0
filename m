From: Richard Haines <richard_c_haines@btinternet.com>
Date: Mon, 30 Sep 2019 16:39:49 +0000
Subject: Re: [RFC PATCH 22/27] KEYS: Replace uid/gid/perm permissions checking with an ACL
Message-Id: <dc24a7ad0e3c191310128cba4e64123e5aa66692.camel@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <758871dc-15b7-ed5c-a119-a40037309507@tycho.nsa.gov>
         <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
         <155024709026.21651.7275876165845045967.stgit@warthog.procyon.org.uk>
         <32623.1550252354@warthog.procyon.org.uk>
In-Reply-To: <32623.1550252354@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, SELinux <selinux@vger.kernel.org>

On Fri, 2019-02-15 at 17:39 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -6560,6 +6560,7 @@ static int selinux_key_permission(key_ref_t
> > > key_ref,
> > >   {
> > >   	struct key *key;
> > >   	struct key_security_struct *ksec;
> > > +	unsigned oldstyle_perm;
> > >   	u32 sid;
> > >     	/* if no specific permissions are requested, we skip
> > > the
> > > @@ -6568,13 +6569,26 @@ static int
> > > selinux_key_permission(key_ref_t key_ref,
> > >   	if (perm = 0)
> > >   		return 0;
> > >   +	oldstyle_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ |
> > > KEY_NEED_WRITE
> > > +				KEY_NEED_SEARCH | KEY_NEED_LINK);
> > > +	if (perm & KEY_NEED_SETSEC)
> > > +		oldstyle_perm |= OLD_KEY_NEED_SETATTR;
> > > +	if (perm & KEY_NEED_INVAL)
> > > +		oldstyle_perm |= KEY_NEED_SEARCH;
> > > +	if (perm & KEY_NEED_REVOKE && !(perm & OLD_KEY_NEED_SETATTR))
> > > +		oldstyle_perm |= KEY_NEED_WRITE;
> > > +	if (perm & KEY_NEED_JOIN)
> > > +		oldstyle_perm |= KEY_NEED_SEARCH;
For JOIN tranlation this should be:
oldstyle_perm |= KEY_NEED_LINK;

I know a bit late but just got around to writing some 'keys' tests for
the selinux-testsuite and found the above.

> > > +	if (perm & KEY_NEED_CLEAR)
> > > +		oldstyle_perm |= KEY_NEED_WRITE;
> > > +
> > >   	sid = cred_sid(cred);
> > >     	key = key_ref_to_ptr(key_ref);
> > >   	ksec = key->security;
> > >     	return avc_has_perm(&selinux_state,
> > > -			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
> > > +			    sid, ksec->sid, SECCLASS_KEY,
> > > oldstyle_perm, NULL);
> > 
> > This might be ok temporarily for compatibility but we'll want to
> > ultimately
> > define the new permissions in SELinux and switch over to using them
> > if a new
> > policy capability bit is set to indicate that the policy supports
> > them.  We
> > should probably decouple the SELinux permission bits from the
> > KEY_NEED_*
> > values and explicitly map them all at the same time.
> 
> Sounds reasonable.  I should probably detach the first two ACL
> patches from
> the set and push them separately.
> 
> David
