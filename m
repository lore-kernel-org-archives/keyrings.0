From: David Howells <dhowells@redhat.com>
Date: Thu, 31 Oct 2019 15:21:22 +0000
Subject: Re: [RFC PATCH 07/10] pipe: Conditionalise wakeup in pipe_read() [ver #2]
Message-Id: <18022.1572535282@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <fe167a90-1503-7ca2-4150-eeffd5cb1378@yandex-team.ru> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <157186189069.3995.10292601951655075484.stgit@warthog.procyon.org.uk>
In-Reply-To: <fe167a90-1503-7ca2-4150-eeffd5cb1378@yandex-team.ru>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> > Only do a wakeup in pipe_read() if we made space in a completely full
> > buffer.  The producer shouldn't be waiting on pipe->wait otherwise.
> 
> We could go further and wakeup writer only when at least half of buffer is
> empty.  This gives better batching and reduces rate of context switches.
> 
> https://lore.kernel.org/lkml/157219118016.7078.16223055699799396042.stgit@buzz/T/#u

Yeah, I saw that.  I suspect that where you put the slider may depend on the
context.

David
