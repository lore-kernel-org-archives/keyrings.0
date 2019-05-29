From: David Howells <dhowells@redhat.com>
Date: Wed, 29 May 2019 11:16:27 +0000
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
Message-Id: <15839.1559128587@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG48ez2SAKbPeChAf06GMazMPPThFM+OR00abRZafAP7v+ptKw@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk> <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <10418.1559084686@warthog.procyon.org.uk>
In-Reply-To: <CAG48ez2SAKbPeChAf06GMazMPPThFM+OR00abRZafAP7v+ptKw@mail.gmail.com>
To: Jann Horn <jannh@google.com>
Cc: dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-block@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module <linux-security-module@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>

Jann Horn <jannh@google.com> wrote:

> I don't really know. I guess it depends on how it's being used? If
> someone decides to e.g. make a file browser that installs watches for
> a bunch of mountpoints for some fancy sidebar showing the device
> mounts on the system, or something like that, that probably shouldn't
> inhibit unmounting... I don't know if that's a realistic use case.

In such a use case, I would envision the browser putting a watch on "/".  A
watch sees all events in the subtree rooted at that point and you must apply a
filter that filters them out if you're not interested (filter on
WATCH_INFO_IN_SUBTREE using info_filter and info_mask).

David
