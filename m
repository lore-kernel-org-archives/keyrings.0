From: David Howells <dhowells@redhat.com>
Date: Sun, 05 Apr 2020 09:03:50 +0000
Subject: Re: [GIT PULL] keys: Fix key->sem vs mmap_sem issue when reading key
Message-Id: <3567369.1586077430@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <78ff6e5d-9643-8798-09cb-65b1415140be@redhat.com> <1437197.1585570598@warthog.procyon.org.uk> <CAHk-=wgWnZCvTFDfiYAy=uMUf2F1Yy1r9ur5ARcmtqLjX8Tz4Q@mail.gmail.com>
In-Reply-To: <78ff6e5d-9643-8798-09cb-65b1415140be@redhat.com>
To: Waiman Long <longman@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Johannes Weiner <hannes@cmpxchg.org>, Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Waiman Long <longman@redhat.com> wrote:

> > And yes, kzfree() isn't a good name either, and had that same
> > memset(), but at least it doesn't do the dual-underscore mistake.
> >
> > Including some kzfree()/crypto people explicitly - I hope we can get
> > away from this incorrect and actively wrong pattern of thinking that
> > "sensitive data should be memset(), and then we should add a random
> > 'z' in the name somewhere to 'document' that".
> >
> >                Linus
> >
> Thanks for the suggestion, I will post a patch to rename the function to
> kvzfree_explicit() and use memzero_explicit() for clearing memory.

Should this be moved into core code, rather than being squirrelled away in
security/keys/?

David
