From: David Howells <dhowells@redhat.com>
Date: Mon, 25 Sep 2017 11:54:20 +0000
Subject: Re: [PATCH] KEYS: prevent creating a different user's keyrings
Message-Id: <26475.1506340460@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170921220029.GB89627@gmail.com>
	<20170918183703.114134-1-ebiggers3@gmail.com>
	<29684.1505837120@warthog.procyon.org.uk>
In-Reply-To: <20170921220029.GB89627@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Well, maybe.  Whitelists are hard to get right, and it would be a bit ugly
> having to check the name in both add_key() and join_session_keyring().  And
> hopefully that would be everything?

Actually, having thought about it some more, I think your way is better.

> I think there's also a more fundamental problem with how keyring names work.
> If you try to join a keyring with a certain name, how are you supposed to
> know which one you're joining?  There can be many keyrings that have the
> same name; and any unprivileged user can create a keyring with the name, and
> they can grant everyone SEARCH permission so that their keyring can be
> joined.  So it can be the case that a user is wanting to join a particular
> keyring, but they actually get a keyring that a malicious user has crafted
> for them...

Yeah.  With hindsight, I think that firstly, joinable keyrings really need
enablement and, secondly, thread, process, session, user and user-session need
to have to be non-manually-creatable.

However, I'm not sure they can be renamed, since they're searchable and
joinable by name and fixing this might break something in userspace (though I
should hope that this is unlikely).

> Also, if period ('.') is meant to be the reserved character in keyring names,
> why do most of the special names actually start with underscore ('_')?

'.' wasn't a reserved char originally.

David
