From: David Howells <dhowells@redhat.com>
Date: Thu, 31 Oct 2019 15:15:53 +0000
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
Message-Id: <17311.1572534953@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <c6e044cc-5596-90b7-4418-6ad7009d6d79@yandex-team.ru> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <30394.1571936252@warthog.procyon.org.uk>
In-Reply-To: <c6e044cc-5596-90b7-4418-6ad7009d6d79@yandex-team.ru>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> Similar synchronization is required for reusing memory after vmsplice()?
> I don't see other way how sender could safely change these pages.

Sounds like a point - if you have multiple parallel contributors to the pipe
via vmsplice(), then FIONREAD is of no use.  To use use FIONREAD, you have to
let the pipe become empty before you can be sure.

David
