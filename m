From: David Howells <dhowells@redhat.com>
Date: Tue, 28 May 2019 23:04:46 +0000
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
Message-Id: <10418.1559084686@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
To: Jann Horn <jannh@google.com>
Cc: dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-block@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module <linux-security-module@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>

Jann Horn <jannh@google.com> wrote:

> It might make sense to redesign this stuff so that watches don't hold
> references on the object being watched.

I explicitly made it hold a reference so that if you place a watch on an
automounted mount it stops it from expiring.

Further, if I create a watch on something, *should* it be unmountable, just as
if I had a file open there or had chdir'd into there?

David
