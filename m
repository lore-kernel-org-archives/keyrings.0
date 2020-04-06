From: Waiman Long <longman@redhat.com>
Date: Mon, 06 Apr 2020 02:38:42 +0000
Subject: Re: [GIT PULL] keys: Fix key->sem vs mmap_sem issue when reading key
Message-Id: <7c868f6a-593d-b9aa-9c0b-a2cd9b763f83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1437197.1585570598@warthog.procyon.org.uk>
 <CAHk-=wgWnZCvTFDfiYAy=uMUf2F1Yy1r9ur5ARcmtqLjX8Tz4Q@mail.gmail.com>
 <78ff6e5d-9643-8798-09cb-65b1415140be@redhat.com>
 <3567369.1586077430@warthog.procyon.org.uk>
 <CAHk-=wg-6906+D68VHWv_SCvWUSG8R9w=js7kExmTum90Evu4g@mail.gmail.com>
In-Reply-To: <CAHk-=wg-6906+D68VHWv_SCvWUSG8R9w=js7kExmTum90Evu4g@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 4/5/20 1:31 PM, Linus Torvalds wrote:
> On Sun, Apr 5, 2020 at 2:04 AM David Howells <dhowells@redhat.com> wrote:
>> Should this be moved into core code, rather than being squirrelled away in
>> security/keys/?
> Yes. I do think that that __kvzfree() function makes sense in general
> (the same way that kzfree does).
>
> I just happen to despise the name, and think that the implementation
> isn't great.
>
> It also probably makes no sense to make it an inline function. It's
> not like that function is done for performance reasons, and it might
> only get worse if we then end up making it cause barriers or something
> for CPU data leakage issues or whatever.
>
>            Linus
>
I have just posted a patch that modify the API as suggested. Please let
me know if further change is needed.

Cheers,
Longman
