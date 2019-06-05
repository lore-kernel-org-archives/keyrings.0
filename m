From: Casey Schaufler <casey@schaufler-ca.com>
Date: Wed, 05 Jun 2019 17:40:28 +0000
Subject: Re: Rational model for UID based controls
Message-Id: <f19dcdb4-f934-34c2-f625-95c2c928d576@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
 <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <20192.1559724094@warthog.procyon.org.uk>
 <18357.1559753807@warthog.procyon.org.uk>
In-Reply-To: <18357.1559753807@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-block@vger.kernel.org, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, casey@schaufler-ca.com

On 6/5/2019 9:56 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> YES!
> I'm trying to decide if that's fervour or irritation at this point ;-)

I think I finally got the point that the underlying mechanism,
direct or indirect, isn't the issue. It's the end result that
matters. That makes me happier.

>> And it would be really great if you put some thought into what
>> a rational model would be for UID based controls, too.
> I have put some thought into it, but I don't see a single rational model.  It
> depends very much on the situation.

Right. You're mixing the kind of things that can generate events,
and that makes having a single policy difficult.

> In any case, that's what I was referring to when I said I might need to call
> inode_permission().  But UIDs don't exist for all filesystems, for example,
> and there are no UIDs on superblocks, mount objects or hardware events.

If you open() or stat() a file on those filesystems the UID
used in the access control comes from somewhere. Setting a watch
on things with UIDs should use the access mode on the file,
just like any other filesystem operation.

Things like superblocks are sticker because we don't generally
think of them as objects. If you can do statfs(), you should be
able to set a watch on the filesystem metadata.

How would you specify a watch for a hardware event? If you say
you have to open /dev/mumble to sent a watch for mumbles, you're
good there, too.

> Now, I could see that you ignore UIDs on things like keys and
> hardware-triggered events, but how does this interact with things like mount
> watches that see directories that have UIDs?
>
> Are you advocating making it such that process B can only see events triggered
> by process A if they have the same UID, for example?

It's always seemed arbitrary to me that you can't open
your process up to get signals from other users. What about
putting mode bits on your ring buffer? By default you could
only accept your own events, but you could do a rb_chmod(0222)
and let all events through. Subject to LSM addition restrictions,
of course. That would require the cred of the process that
triggered the event or a system cred for "hardware" events.
If you don't like mode bits you could use an ACL for fine
granularity or a single "let'em all in" bit for coarse.

I'm not against access, I'm against uncontrolled access
in conflict with basic system policy.

> David
