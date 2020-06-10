From: Karel Zak <kzak@redhat.com>
Date: Wed, 10 Jun 2020 11:12:56 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1503686.1591113304@warthog.procyon.org.uk>
In-Reply-To: <1503686.1591113304@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk, dray@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com, raven@themaw.net, andres@anarazel.de, christian.brauner@ubuntu.com, jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org


 Hi Linus,

On Tue, Jun 02, 2020 at 04:55:04PM +0100, David Howells wrote:
> Can you pull this, please?  It adds a general notification queue concept

I'm trying to use David's notification stuff in userspace, and I guess
feedback is welcome :-)

The notification stuff looks pretty promising, but I do not understand
why we need to use pipe for this purpose, see typical userspace use-case:

        int pipefd[2], fd;

        if (pipe2(pipefd, O_NOTIFICATION_PIPE) = -1)
                err(EXIT_FAILURE, "pipe2 failed");

        fd = pipefd[0];

All the next operations are done with "fd". It's nowhere used as a
pipe, and nothing uses pipefd[1]. The first impression from this code
is "oh, this is strange; why?".

Is it because we need to create a new file descriptor from nothing?
Why O_NOTIFICATION_PIPE is better than introduce a new syscall
notifyfd()?

(We have signalfd(), no O_SIGNAL_PIPE, etc.) 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
