From: Florian Weimer <fweimer@redhat.com>
Date: Thu, 16 Apr 2020 10:33:34 +0000
Subject: Re: What's a good default TTL for DNS keys in the kernel
Message-Id: <87v9lzu3cx.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <874ktl2ide.fsf@oldenburg2.str.redhat.com>
        <3865908.1586874010@warthog.procyon.org.uk>
        <128769.1587032833@warthog.procyon.org.uk>
In-Reply-To: <128769.1587032833@warthog.procyon.org.uk> (David Howells's
        message of "Thu, 16 Apr 2020 11:27:13 +0100")
To: David Howells <dhowells@redhat.com>
Cc: linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

* David Howells:

> Florian Weimer <fweimer@redhat.com> wrote:
>
>> You can get the real TTL if you do a DNS resolution on the name and
>> match the addresses against what you get out of the NSS functions.  If
>> they match, you can use the TTL from DNS.  Hackish, but it does give you
>> *some* TTL value.
>
> I guess I'd have to do that in parallel.

Not necessary.  You can do the getaddrinfo lookup first and then perform
the query.

> Would calling something like res_mkquery() use local DNS caching?

Yes (but res_mkquery builds a packet, it does not send it).

>> The question remains what the expected impact of TTL expiry is.  Will
>> the kernel just perform a new DNS query if it needs one?  Or would you
>> expect that (say) the NFS client rechecks the addresses after TTL expiry
>> and if they change, reconnect to a new NFS server?
>
> It depends on the filesystem.
>
> AFS keeps track of the expiration on the record and will issue a new lookup
> when the data expires, but NFS doesn't make use of this information.

And it will switch servers at that point?  Or only if the existing
server association fails/times out?

> The keyring subsystem will itself dispose of dns_resolver keys that
> expire and request_key() will only upcall again if the key has
> expired.

What's are higher-level effects of that?

I'm still not convinced that the kernel *needs* accurate TTL
information.  The benefit from upcall avoidance likely vanishes quickly
after the in-kernel TTL increases beyond 5 or so.  That's just my guess,
though.

Thanks,
Florian
