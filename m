From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 07 Nov 2019 18:16:13 +0000
Subject: Re: [RFC PATCH 04/14] pipe: Add O_NOTIFICATION_PIPE [ver #2]
Message-Id: <CALCETrUka9KaOKFbNKUXcA6XvoFxiXPftctSHtN4DL35Cay61w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
 <157313375678.29677.15875689548927466028.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313375678.29677.15875689548927466028.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Nov 7, 2019 at 5:39 AM David Howells <dhowells@redhat.com> wrote:
>
> Add an O_NOTIFICATION_PIPE flag that can be passed to pipe2() to indicate
> that the pipe being created is going to be used for notifications.  This
> suppresses the use of splice(), vmsplice(), tee() and sendfile() on the
> pipe as calling iov_iter_revert() on a pipe when a kernel notification
> message has been inserted into the middle of a multi-buffer splice will be
> messy.

How messy?  And is there some way to make it impossible for this to
happen?  Adding a new flag to pipe2() to avoid messy kernel code seems
like a poor tradeoff.
