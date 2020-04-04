From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 04 Apr 2020 20:00:08 +0000
Subject: Re: [GIT PULL] keys: Fix key->sem vs mmap_sem issue when reading key
Message-Id: <CAHk-=wgWnZCvTFDfiYAy=uMUf2F1Yy1r9ur5ARcmtqLjX8Tz4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1437197.1585570598@warthog.procyon.org.uk>
In-Reply-To: <1437197.1585570598@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Waiman Long <longman@redhat.com>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Mar 30, 2020 at 5:16 AM David Howells <dhowells@redhat.com> wrote:
>
>  security/keys/internal.h                  |  12 ++++

This isn't so much about this pull (which I have taken), as about the
fact that this code re-inforces bad behavior we already in the slub
layer, and now extends it further to kvfree.

Doing this:


   __kvzfree(const void *addr, size_t len)
  ..
                memset((void *)addr, 0, len);
                kvfree(addr);

is wrong to begin with. It's wrong because if the compiler ever knows
that kvfree is a freeing function (with something like
__attribute__((free)) - I don't think gcc is smart enough today), the
compiler might throw the memset away.

Yeah, so far we've only seen that for automatic stack clearing, but
there are very much compilers that know that alloc/free are special
(both for warning about use-after-free issues, and for "improving"
code generation by blindly removing dead writes).

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

               Linus
