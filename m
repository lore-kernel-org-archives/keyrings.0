From: Casey Schaufler <casey@schaufler-ca.com>
Date: Tue, 24 Jul 2018 18:57:37 +0000
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
Message-Id: <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
 <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
 <23894.1532448035@warthog.procyon.org.uk>
In-Reply-To: <23894.1532448035@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On 7/24/2018 9:00 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>>  (1) Mount topology and reconfiguration change events.
>> With the possibility of unprivileged mounting you're going to have to
>> address access control on events.  If root in a user namespace mounts a
>> filesystem you may have a case where the "real" user wouldn't want the
>> listener to receive a notification.
> Can you clarify who the listener is in this case?

That would be anyone with a watchpoint set.

> Note that mount topology events don't leak outside of the mount namespace
> they're generated in.
>
> That said, if you, a random user, put a watchpoint on "/" you can see the
> mount events triggered by another random user in the same mount namespace.  I
> don't see a way to control this except by resorting to the LSM since UNIX
> doesn't have 'notify' permission bits.

I would call that a write operation from the process that triggered
the watchpoint to the one watching it. Like a signal. Signals have a
rudimentary DAC policy (write only to the same UID) that could be
your model.

> But for each event, I can associate an object label, derived from the source,
> and use f_cred on the notification queue to provide a subject label.

... or UID or groups.

>
>>>  (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).
>> Here, too. If SELinux (for example) policy says you can't see
>> anything on a filesystem you shouldn't get notifications about
>> things that happen to that filesystem.
> Yep.  Sounds like I need to refer that to the LSM as above.
>
> It's a bit easier for specifically nominated sb sources since you might only
> need to do the check once at sb_notify() time.  If there's a general queue
> that all sbs contribute to, however, then things become more complicated as
> the checks have to be done at do-we-write-into-this-queue? time.
>
>>>  (3) Key/keyring changes events
>> And again, I should only get notifications about keys and
>> keyrings I have access to.
> Currently, you can only watch keys that grant you View permission, which might
> suffice.

That seems appropriate.

>> I expect that you intentionally left off
>>
>>    (4) User injected events
>>
>> at this point, but it's an obvious extension. That is going
>> to require access controls (remember kdbus) so I think you'd
>> do well to design them in now rather than have some security
>> module hack like me come along later and "fix" it. 
> Yeah - the thought had occurred to me, but there needs to be some way to
> define a 'source' and a way to connect them.  Also, would you want a general
> source that anyone can contribute through, specific sources where you have to
> directly connect or namespace-restricted sources?

My guess is that the consensus would be "Yes" to all the above.

>
> David
>

