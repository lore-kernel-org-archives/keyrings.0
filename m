From: Florian Weimer <fweimer@redhat.com>
Date: Wed, 15 Apr 2020 09:44:29 +0000
Subject: Re: What's a good default TTL for DNS keys in the kernel
Message-Id: <874ktl2ide.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <3865908.1586874010@warthog.procyon.org.uk>
In-Reply-To: <3865908.1586874010@warthog.procyon.org.uk> (David Howells's
        message of "Tue, 14 Apr 2020 15:20:10 +0100")
To: David Howells <dhowells@redhat.com>
Cc: linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

* David Howells:

> Since key.dns_resolver isn't given a TTL for the address information obtained
> for getaddrinfo(), no expiry is set on dns_resolver keys in the kernel for
> NFS, CIFS or Ceph.  AFS gets one if it looks up a cell SRV or AFSDB record
> because that is looked up in the DNS directly, but it doesn't look up A or
> AAAA records, so doesn't get an expiry for the addresses themselves.
>
> I've previously asked the libc folks if there's a way to get this information
> exposed in struct addrinfo, but I don't think that ended up going anywhere -
> and, in any case, would take a few years to work through the system.
>
> For the moment, I think I should put a default on any dns_resolver keys and
> have it applied either by the kernel (configurable with a /proc/sys/ setting)
> or by the key.dnf_resolver program (configurable with an /etc file).
>
> Any suggestion as to the preferred default TTL?  10 minutes?

You can get the real TTL if you do a DNS resolution on the name and
match the addresses against what you get out of the NSS functions.  If
they match, you can use the TTL from DNS.  Hackish, but it does give you
*some* TTL value.

The question remains what the expected impact of TTL expiry is.  Will
the kernel just perform a new DNS query if it needs one?  Or would you
expect that (say) the NFS client rechecks the addresses after TTL expiry
and if they change, reconnect to a new NFS server?

If a TTL expiration does not trigger anything, than it seems purely an
optimization to avoid kernel → userspace callbacks.  I think you can do
with a very short TTL in this case, on the order of seconds (or no
caching at all).

Negative caching is also worthy of consideration and can be considerably
more tricky.

Thanks,
Florian
