From: Florian Weimer <fweimer@redhat.com>
Date: Tue, 19 May 2020 14:17:55 +0000
Subject: Re: [PATCH] dns: Apply a default TTL to records obtained from getaddrinfo()
Message-Id: <87blmkgga4.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158981176590.872823.11683683537698750702.stgit@warthog.procyon.org.uk>
In-Reply-To: <158981176590.872823.11683683537698750702.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Mon, 18 May 2020 15:22:45 +0100")
To: David Howells <dhowells@redhat.com>
Cc: linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

* David Howells:

> Fix this to apply a default TTL of 10mins in the event that we haven't got
> one.  This can be configured in /etc/keyutils/key.dns_resolver.conf by
> adding the line:
>
> 	default_ttl: <number-of-seconds>
>
> to the file.

If the name resolution is not needed continuously, but only for the
connection attempt, I suggest to use a much shorter TTL, like five
seconds or so.

I'm worried that if the implied TTL is too long, some system
administrators will have to figure out how to invalidate the DNS cache.

Thanks,
Florian
