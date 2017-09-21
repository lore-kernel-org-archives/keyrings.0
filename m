From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 21 Sep 2017 22:00:29 +0000
Subject: Re: [PATCH] KEYS: prevent creating a different user's keyrings
Message-Id: <20170921220029.GB89627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170918183703.114134-1-ebiggers3@gmail.com>
	<29684.1505837120@warthog.procyon.org.uk>
In-Reply-To: <29684.1505837120@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Tue, Sep 19, 2017 at 05:05:20PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > Fix it by marking user and user session keyrings with a flag
> > KEY_FLAG_UID_KEYRING.  Then, when searching for a user or user session
> > keyring by name, skip all keyrings that don't have the flag set.
> 
> I wonder if it's better just to reject attempts to manually create/join
> keyrings of such names.  PAM uses the implicit creation method of specifying
> the 'macro' key IDs for these keyrings.
> 
> David

Well, maybe.  Whitelists are hard to get right, and it would be a bit ugly
having to check the name in both add_key() and join_session_keyring().  And
hopefully that would be everything?

I think there's also a more fundamental problem with how keyring names work.  If
you try to join a keyring with a certain name, how are you supposed to know
which one you're joining?  There can be many keyrings that have the same name;
and any unprivileged user can create a keyring with the name, and they can grant
everyone SEARCH permission so that their keyring can be joined.  So it can be
the case that a user is wanting to join a particular keyring, but they actually
get a keyring that a malicious user has crafted for them...

Also, if period ('.') is meant to be the reserved character in keyring names,
why do most of the special names actually start with underscore ('_')?

Eric
