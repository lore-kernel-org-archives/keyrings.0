From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 16 Apr 2018 21:31:00 +0000
Subject: Re: [PATCH v2] KEYS: DNS: limit the length of option strings
Message-Id: <20180416213100.GB10051@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228190510.215801-1-ebiggers3@gmail.com>
 <31292.1520438077@warthog.procyon.org.uk>
 <20180312175707.GA230165@gmail.com>
 <20180323202122.GB16350@gmail.com>
 <20180402192035.GC59810@gmail.com>
In-Reply-To: <20180402192035.GC59810@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, netdev@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Eric Biggers <ebiggers@google.com>

On Mon, Apr 02, 2018 at 12:20:35PM -0700, Eric Biggers wrote:
> On Fri, Mar 23, 2018 at 01:21:22PM -0700, Eric Biggers wrote:
> > On Mon, Mar 12, 2018 at 10:57:07AM -0700, Eric Biggers wrote:
> > > On Wed, Mar 07, 2018 at 03:54:37PM +0000, David Howells wrote:
> > > > Eric Biggers <ebiggers3@gmail.com> wrote:
> > > > 
> > > > > Fix it by limiting option strings (combined name + value) to a much more
> > > > > reasonable 128 bytes.  The exact limit is arbitrary, but currently the
> > > > > only recognized option is formatted as "dnserror=%lu" which fits well
> > > > > within this limit.
> > > > 
> > > > There will be more options coming ("ipv4", "ipv6") but they shouldn't overrun
> > > > this limit and we can always extend the limit if need be.
> > > > 
> > > > David
> > > 
> > > David (Howells) do you want to take this patch through the keyrings tree or
> > > should I ask David Miller to take it through net-next?
> > > 
> > > Eric
> > 
> > Ping.
> 
> Ping again.

Times up.  I'll resend for net-next.

Eric
