From: Casey Schaufler <casey@schaufler-ca.com>
Date: Wed, 25 Jul 2018 15:48:46 +0000
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
Message-Id: <55bb8ed3-59b4-ca6e-5741-a7d5e4489a7c@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
 <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
 <23894.1532448035@warthog.procyon.org.uk>
 <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com>
 <1532497196.2688.65.camel@themaw.net>
In-Reply-To: <1532497196.2688.65.camel@themaw.net>
To: Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On 7/24/2018 10:39 PM, Ian Kent wrote:
> On Tue, 2018-07-24 at 11:57 -0700, Casey Schaufler wrote:
>> On 7/24/2018 9:00 AM, David Howells wrote:
>>> Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>
>>>>>  (1) Mount topology and reconfiguration change events.
>>>> With the possibility of unprivileged mounting you're going to have to
>>>> address access control on events.  If root in a user namespace mounts a
>>>> filesystem you may have a case where the "real" user wouldn't want the
>>>> listener to receive a notification.
>>> Can you clarify who the listener is in this case?
>> That would be anyone with a watchpoint set.
> And that process would have had the privilege to do so ...

Which isn't the point. The access control isn't on the watchpoint,
it's on delivering the event to the watchpoint. The access control
needs to be based on the process that created the event and the
process receiving the event.

>
>>> Note that mount topology events don't leak outside of the mount namespace
>>> they're generated in.
>>>
>>> That said, if you, a random user, put a watchpoint on "/" you can see the
>>> mount events triggered by another random user in the same mount
>>> namespace.  I
>>> don't see a way to control this except by resorting to the LSM since UNIX
>>> doesn't have 'notify' permission bits.
>> I would call that a write operation from the process that triggered
>> the watchpoint to the one watching it. Like a signal. Signals have a
>> rudimentary DAC policy (write only to the same UID) that could be
>> your model.
> I'm not sure signals are a good comparison.

In both cases you have one process sending information
to another. If you use killpg() instead of kill() you can
send to a number of processes without knowing them individually.
A process can chose what to do with (most) signals, including
ignore them.


> They can affect a process in significant ways whereas triggering
> a notification is less invasive so the security requirements
> should take that into consideration.

I'm looking at this from a security model viewpoint. If process
A sends information to process B that's a write operation with
A as the subject and B as the object. 

> But there is a problem here I think.
>
> How about the case where a user name space is created or entered
> without a newly created mount name space and mounts and umounts
> are done, the user name space necessarily expects the table of
> mounts it sees to be up to date.
>
> But, if the methods here are used by user space, say libmount
> was updated to use it, to gain the efficiency of not constantly
> re-reading the proc mount table then restrictions on notifications
> would mean the mount table seen in the user name space might not
> be updated and would no longer be correct.

Hey, I'm not the one saying that containers don't need/want kernel
manifestation. Of course you may have troubles with access consistency
if you go around changing the access control attributes with namespaces.
One of the problems with signals is that you can't chmod() your process
to allow signals from other specified users. If you don't design an
access control scheme into the watchpoint mechanism you aren't going to
be able to deal with situations like this.

> The converse is more interesting, where the user name space does
> create or enter a new mount name space, then libmount would see ???,
> probably not the updated mount information ... unless it opens a
> new file handle to get mount update information ... a long running
> daemon that uses libmount and dispenses or uses mount information
> would very likely have a problem ...
>
> The current proc file system method or providing the mount table
> forces a new file handle to be opened whenever getting the mount
> table so it always sees only the current mount name space mount
> table.
>
> At the very least I need to think more about this ...
>
>>> But for each event, I can associate an object label, derived from the
>>> source,
>>> and use f_cred on the notification queue to provide a subject label.
>> ... or UID or groups.
>>
>>>>>  (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).
>>>> Here, too. If SELinux (for example) policy says you can't see
>>>> anything on a filesystem you shouldn't get notifications about
>>>> things that happen to that filesystem.
>>> Yep.  Sounds like I need to refer that to the LSM as above.
>>>
>>> It's a bit easier for specifically nominated sb sources since you might only
>>> need to do the check once at sb_notify() time.  If there's a general queue
>>> that all sbs contribute to, however, then things become more complicated as
>>> the checks have to be done at do-we-write-into-this-queue? time.
>>>
>>>>>  (3) Key/keyring changes events
>>>> And again, I should only get notifications about keys and
>>>> keyrings I have access to.
>>> Currently, you can only watch keys that grant you View permission, which
>>> might
>>> suffice.
>> That seems appropriate.
>>
>>>> I expect that you intentionally left off
>>>>
>>>>    (4) User injected events
>>>>
>>>> at this point, but it's an obvious extension. That is going
>>>> to require access controls (remember kdbus) so I think you'd
>>>> do well to design them in now rather than have some security
>>>> module hack like me come along later and "fix" it. 
>>> Yeah - the thought had occurred to me, but there needs to be some way to
>>> define a 'source' and a way to connect them.  Also, would you want a general
>>> source that anyone can contribute through, specific sources where you have
>>> to
>>> directly connect or namespace-restricted sources?
>> My guess is that the consensus would be "Yes" to all the above.
>>
>>> David
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

