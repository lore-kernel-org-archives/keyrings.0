From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Nov 2019 14:53:21 +0000
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring, not cursor and length [ver #2]
Message-Id: <23658.1572620001@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAOi1vP9GAmy5NXJisrDssspoRcc+UHum+cyBsJTMNTjz_jieoQ@mail.gmail.com> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk> <CAOi1vP97DMX8zweOLfBDOFstrjC78=6RgxK3PPj_mehCOSeoaw@mail.gmail.com> <4892d186-8eb0-a282-e7e6-e79958431a54@rasmusvillemoes.dk> <16620.1572534687@warthog.procyon.org.uk>
In-Reply-To: <CAOi1vP9GAmy5NXJisrDssspoRcc+UHum+cyBsJTMNTjz_jieoQ@mail.gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block <linux-block@vger.kernel.org>, linux-security-module@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Ilya Dryomov <idryomov@gmail.com> wrote:

> >  * This means there isn't a dead spot in the buffer, but the ring
> >  * size has to be a power of two and <= 2^31.

I'll go with that, thanks.

David
