From: David Howells <dhowells@redhat.com>
Date: Wed, 07 Mar 2018 15:54:37 +0000
Subject: Re: [PATCH v2] KEYS: DNS: limit the length of option strings
Message-Id: <31292.1520438077@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228190510.215801-1-ebiggers3@gmail.com>
In-Reply-To: <20180228190510.215801-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, netdev@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Eric Biggers <ebiggers@google.com>

Eric Biggers <ebiggers3@gmail.com> wrote:

> Fix it by limiting option strings (combined name + value) to a much more
> reasonable 128 bytes.  The exact limit is arbitrary, but currently the
> only recognized option is formatted as "dnserror=%lu" which fits well
> within this limit.

There will be more options coming ("ipv4", "ipv6") but they shouldn't overrun
this limit and we can always extend the limit if need be.

David
