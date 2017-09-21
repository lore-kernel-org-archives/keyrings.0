From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 21 Sep 2017 23:34:16 +0000
Subject: Re: [PATCH] KEYS: prevent KEYCTL_READ on negative key
Message-Id: <20170921233416.GC89627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170918183723.114253-1-ebiggers3@gmail.com>
	<30124.1505837342@warthog.procyon.org.uk>
In-Reply-To: <30124.1505837342@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Tue, Sep 19, 2017 at 05:09:02PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > +	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
> > +		ret = -ENOKEY;
> > +		goto error2;
> > +	}
> 
> It might be better to do this check in key_validate().  Also, it should
> perhaps take the error from key->reject_error.
> 
> David

Putting the check in key_validate() would make lookups with KEY_LOOKUP_PARTIAL
stop returning negative keys, which would break keyctl_describe(),
keyctl_chown(), keyctl_setperm(), keyctl_set_timeout(), keyctl_get_security() on
negative keys.  I presume those are supposed to work?

Another solution would be to remove the special case from lookup_user_key()
where it can return a negative/revoked/invalidated/expired key if
KEY_LOOKUP_PARTIAL is not specified and the 'perm' mask is 0.  The only callers
it would affect are the case in question here which is clearly a bug, and the
root-only exceptions for keyctl_invalidate() and keyctl_clear().  And I suspect
the latter two are unintentional as well.  (Is root *supposed* to be able to
invalidate a negative/revoked/invalidated/expired key, or clear a
revoked/invalidated/expired keyring?)

Eric
