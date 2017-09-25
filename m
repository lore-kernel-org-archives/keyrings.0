From: David Howells <dhowells@redhat.com>
Date: Mon, 25 Sep 2017 13:29:56 +0000
Subject: Re: [PATCH] KEYS: prevent KEYCTL_READ on negative key
Message-Id: <28720.1506346196@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170921233416.GC89627@gmail.com>
	<20170918183723.114253-1-ebiggers3@gmail.com>
	<30124.1505837342@warthog.procyon.org.uk>
In-Reply-To: <20170921233416.GC89627@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Putting the check in key_validate() would make lookups with
> KEY_LOOKUP_PARTIAL stop returning negative keys, which would break
> keyctl_describe(), keyctl_chown(), keyctl_setperm(), keyctl_set_timeout(),
> keyctl_get_security() on negative keys.  I presume those are supposed to
> work?

Lookups with KEY_LOOKUP_PARTIAL should never return a negative key by
definition.  A negative key is instantiated with an error code, so is no longer
under construction.

key_get_instantiation_authkey() must fail if the key has been constructed - but
I guess there's a potential race in keyctl_describe_key(), keyctl_set_timeout()
and keyctl_get_security() between getting the auth token and calling
lookup_user_key() with perm of 0 in which the key could be instantiated,
revoked, or instantiated elsewhere, or simply expire.  This would allow the
instantiating process a longer access window - but they do/did have a valid
token...

It should still be possible to describe, chown, setperm and get the security on
negative keys by the normal access mechanism.  Changing the timeout should
probably be denied.

> Another solution would be to remove the special case from lookup_user_key()
> where it can return a negative/revoked/invalidated/expired key if
> KEY_LOOKUP_PARTIAL is not specified and the 'perm' mask is 0.

There are a number of circumstances in which it lookup_user_key() is called
with perm=0, and in each case, the caller is responsible for handling the
security:

 (1) keyctl_invalidate_key() will do so if the caller doesn't have permission,
     but CAP_SYS_ADMIN is set and the key is marked KEY_FLAG_ROOT_CAN_INVAL.

 (2) keyctl_keyring_clear() will do so if the caller doesn't have permission,
     but CAP_SYS_ADMIN is set and the key is marked KEY_FLAG_ROOT_CAN_CLEAR.

 (3) keyctl_keyring_unlink() will do so on the key-to-be-removed since only the
     keyring needs a perm check.

 (4) keyctl_read_key() always does so and then does the READ perm check and the
     possessor-can-SEARCH can search check itself.

 (5) keyctl_describe_key(), keyctl_set_timeout() and keyctl_get_security() will
     do so if the caller doesn't have permission, but does have a valid
     authorisation token.  The latter requires that the key be under
     construction.

Functions that use KEY_LOOKUP_PARTIAL include:

 keyctl_describe_key()
 keyctl_chown_key()
 keyctl_setperm_key()
 keyctl_set_timeout()
 keyctl_get_security()

all of which might need to be called from the upcall program.  None of these
should look at the payload.

> The only callers it would affect are the case in question here which is
> clearly a bug,

keyctl_read_key() is definitely buggy.  Actually, rather than manually testing
KEY_FLAG_NEGATIVE there, it should probably use key_validate().

> and the root-only exceptions for keyctl_invalidate() and
> keyctl_clear().  And I suspect the latter two are unintentional as well.

I'm not sure what you think is unintentional.

> (Is root *supposed* to be able to invalidate a
> negative/revoked/invalidated/expired key, or clear a
> revoked/invalidated/expired keyring?)

You should be able to invalidate or unlink negative, revoked or expired keys if
you have permission to do so.  If you're using keyrings to cache stuff, you
need to be able to invalidate negative results as well as positive ones.

Invalidation of an invalidated key doesn't really make sense, but it shouldn't
hurt.  I can't immediately automatically remove all links to the invalidated
key, but have to leave it to the garbage collector to effect.

As for clearing of revoked/invalidated/expired keyrings, I'm not sure whether
it makes sense to allow it - however, whilst keyrings are cleared upon
revocation (since we have a definite point to do that with the key sem
writelocked), they aren't automatically cleared upon expiry or invalidation, so
it might make sense to permit it still.

David
