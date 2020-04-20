From: Paulo Alcantara <pc@cjr.nz>
Date: Mon, 20 Apr 2020 18:21:23 +0000
Subject: Re: What's a good default TTL for DNS keys in the kernel
Message-Id: <878siq587w.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <87imhvj7m6.fsf@cjr.nz>
 <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com>
 <3865908.1586874010@warthog.procyon.org.uk>
 <927453.1587285472@warthog.procyon.org.uk>
 <1136024.1587388420@warthog.procyon.org.uk>
In-Reply-To: <1136024.1587388420@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>, linux-nfs <linux-nfs@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, fweimer@redhat.com

David Howells <dhowells@redhat.com> writes:

> Paulo Alcantara <pc@cjr.nz> wrote:
>
>> >> For SMB3/CIFS mounts, Paulo added support last year for automatic
>> >> reconnect if the IP address of the server changes.  It also is helpful
>> >> when DFS (global name space) addresses change.
>> >
>> > What happens if the IP address the superblock is going to changes, then
>> > another mount is made back to the original IP address?  Does the second mount
>> > just pick the original superblock?
>> 
>> It is going to transparently reconnect to the new ip address, SMB share,
>> and cifs superblock is kept unchanged.  We, however, update internal
>> TCP_Server_Info structure to reflect new destination ip address.
>> 
>> For the second mount, since the hostname (extracted out of the UNC path
>> at mount time) resolves to a new ip address and that address was saved earlier
>> in TCP_Server_Info structure during reconnect, we will end up
>> reusing same cifs superblock as per fs/cifs/connect.c:cifs_match_super().
>
> Would that be a bug?

Probably.

I'm not sure how that code is supposed to work, TBH.
