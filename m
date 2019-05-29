From: Casey Schaufler <casey@schaufler-ca.com>
Date: Wed, 29 May 2019 17:46:23 +0000
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
Message-Id: <058f227c-71ab-a6f4-00bf-b8782b3b2956@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <14347.1559127657@warthog.procyon.org.uk>
 <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
 <4552118F-BE9B-4905-BF0F-A53DC13D5A82@amacapital.net>
In-Reply-To: <4552118F-BE9B-4905-BF0F-A53DC13D5A82@amacapital.net>
To: Andy Lutomirski <luto@amacapital.net>
Cc: David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-block@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module <linux-security-module@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, casey@schaufler-ca.com

On 5/29/2019 10:13 AM, Andy Lutomirski wrote:
>
>> On May 29, 2019, at 8:53 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>>> On 5/29/2019 4:00 AM, David Howells wrote:
>>> Jann Horn <jannh@google.com> wrote:
>>>
>>>>> +void post_mount_notification(struct mount *changed,
>>>>> +                            struct mount_notification *notify)
>>>>> +{
>>>>> +       const struct cred *cred = current_cred();
>>>> This current_cred() looks bogus to me. Can't mount topology changes
>>>> come from all sorts of places? For example, umount_mnt() from
>>>> umount_tree() from dissolve_on_fput() from __fput(), which could
>>>> happen pretty much anywhere depending on where the last reference gets
>>>> dropped?
>>> IIRC, that's what Casey argued is the right thing to do from a security PoV.
>>> Casey?
>> You need to identify the credential of the subject that triggered
>> the event. If it isn't current_cred(), the cred needs to be passed
>> in to post_mount_notification(), or derived by some other means.
> Taking a step back, why do we care who triggered the event?  It seems to me that we should care whether the event happened and whether the *receiver* is permitted to know that.

There are two filesystems, "dot" and "dash". I am not allowed
to communicate with Fred on the system, and all precautions have
been taken to ensure I cannot. Fred asks for notifications on
all mount activity. I perform actions that result in notifications
on "dot" and "dash". Fred receives notifications and interprets
them using Morse code. This is not OK. If Wilma, who *is* allowed
to communicate with Fred, does the same actions, he should be
allowed to get the messages via Morse.

The event is information. The information is generated as a
result of my or Wilma's action. Fred is passive in this access.
Fred is not "reading" the event. The event is being written to
Fred. My process is the subject, and Fred's the object.

Other security modelers may disagree. The models they produce
are going to be *very* complicated and will introduce agents and
intermediate objects to justify Fred's reception of an event as
a read operation.

> (And receiver means whoever subscribed, presumably, not whoever called read() or mmap().)

The receiver is the process that gets the event. There may
be more than one receiver, and the receivers may have different
credentials. Each needs to be checked separately.

Isn't this starting to sound like the discussions on kdbus?
I'm not sure if that deserves a :) or a :( but probably one of the two.
