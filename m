From: David Howells <dhowells@redhat.com>
Date: Mon, 06 Apr 2020 16:00:40 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <319765.1586188840@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com> <20200406023700.1367-1-longman@redhat.com>
In-Reply-To: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
To: Joe Perches <joe@perches.com>
Cc: dhowells@redhat.com, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Joe Perches <joe@perches.com> wrote:

> > This patch introduces a new kvfree_sensitive() for freeing those
> > sensitive data objects allocated by kvmalloc(). The relevnat places
> > where kvfree_sensitive() can be used are modified to use it.
> 
> Why isn't this called kvzfree like the existing kzfree?

To quote Linus:

	We have a function for clearing sensitive information: it's called
	"memclear_explicit()", and it's about forced (explicit) clearing even
	if the data might look dead afterwards.

	The other problem with that function is the name: "__kvzfree()" is not
	a useful name for this function. We use the "__" format for internal
	low-level helpers, and it generally means that it does *less* than the
	full function. This does more, not less, and "__" is not following any
	sane naming model.

	So the name should probably be something like "kvfree_sensitive()" or
	similar. Or maybe it could go even further, and talk about _why_ it's
	sensitive, and call it "kvfree_cleartext()" or something like that.

	Because the clearing is really not what even matters. It might choose
	other patterns to overwrite things with, but it might do other things
	too, like putting special barriers for data leakage (or flags to tell
	return-to-user-mode to do so).

	And yes, kzfree() isn't a good name either, and had that same
	memset(), but at least it doesn't do the dual-underscore mistake.

	Including some kzfree()/crypto people explicitly - I hope we can get
	away from this incorrect and actively wrong pattern of thinking that
	"sensitive data should be memset(), and then we should add a random
	'z' in the name somewhere to 'document' that".

David
