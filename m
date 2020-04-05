From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 05 Apr 2020 17:31:41 +0000
Subject: Re: [GIT PULL] keys: Fix key->sem vs mmap_sem issue when reading key
Message-Id: <CAHk-=wg-6906+D68VHWv_SCvWUSG8R9w=js7kExmTum90Evu4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1437197.1585570598@warthog.procyon.org.uk> <CAHk-=wgWnZCvTFDfiYAy=uMUf2F1Yy1r9ur5ARcmtqLjX8Tz4Q@mail.gmail.com>
 <78ff6e5d-9643-8798-09cb-65b1415140be@redhat.com> <3567369.1586077430@warthog.procyon.org.uk>
In-Reply-To: <3567369.1586077430@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Apr 5, 2020 at 2:04 AM David Howells <dhowells@redhat.com> wrote:
>
> Should this be moved into core code, rather than being squirrelled away in
> security/keys/?

Yes. I do think that that __kvzfree() function makes sense in general
(the same way that kzfree does).

I just happen to despise the name, and think that the implementation
isn't great.

It also probably makes no sense to make it an inline function. It's
not like that function is done for performance reasons, and it might
only get worse if we then end up making it cause barriers or something
for CPU data leakage issues or whatever.

           Linus
