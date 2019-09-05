From: Ray Strode <rstrode@redhat.com>
Date: Thu, 05 Sep 2019 18:51:14 +0000
Subject: Re: Why add the general notification queue and its sources
Message-Id: <CAKCoTu7ms4ckwDA_-onuJg+famnMzGZE9gGUcqqMz0kCAAECRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <11667f69-fbb5-28d2-3c31-7f865f2b93e5@redhat.com>
In-Reply-To: <11667f69-fbb5-28d2-3c31-7f865f2b93e5@redhat.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block <linux-block@vger.kernel.org>, Christian Brauner <christian@brauner.io>, LSM List <linux-security-module@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, David Lehman <dlehman@redhat.com>, Ian Kent <ikent@redhat.com>

Hi,

On Thu, Sep 5, 2019 at 2:37 PM Steven Whitehouse <swhiteho@redhat.com> wrote:
> The original reason for the mount notification mechanism was so that we
> are able to provide information to GUIs and similar filesystem and
> storage management tools, matching the state of the filesystem with the
> state of the underlying devices. This is part of a larger project
> entitled "Project Springfield" to try and provide better management
> tools for storage and filesystems. I've copied David Lehman in, since he
> can provide a wider view on this topic.
So one problem that I've heard discussed before is what happens in a thinp
setup when the disk space is overallocated and gets used up. IIRC, the
volumes just sort of eat themselves?

Getting proper notification of looming catastrophic failure to the
workstation user
before it's too late would be useful, indeed.

I don't know if this new mechanism dhowells has development can help with that,
and/or if solving that problem is part of the Project Springfield
initiative or not. Do you
know off hand?

--Ray
