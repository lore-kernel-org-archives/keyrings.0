From: David Howells <dhowells@redhat.com>
Date: Mon, 16 Oct 2017 22:09:31 +0000
Subject: Re: [RFC][PATCH 00/15] KEYS: Fixes
Message-Id: <15166.1508191771@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171016183141.GD121701@gmail.com>
	<20171012185612.GA11577@gmail.com>
	<150782504738.1655.12882942775980793687.stgit@warthog.procyon.org.uk>
	<2176.1507909168@warthog.procyon.org.uk>
In-Reply-To: <20171016183141.GD121701@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> > -		if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
> > +		if (state = KEY_IS_INSTANTIATED)
> >  			atomic_dec(&key->user->nikeys);
> 
> This changes the behavior.  Previously ->nikeys counted both negatively and
> positively instantiated keys, while this change implies that it now will only
> count positively instantiated keys.  I think you meant 'state !> KEY_IS_UNINSTANTIATED'?  Renaming KEY_IS_INSTANTIATED to KEY_IS_POSITIVE or
> KEY_IS_POSITIVELY_INSTANTIATED also might help reduce this confusion.

Yeah - I think I'm confusing myself by overloading 'instantiated' in my mind.

David
