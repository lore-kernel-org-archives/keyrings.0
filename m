From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 17 Apr 2018 18:23:40 +0000
Subject: Re: [PATCH RESEND net-next v2] KEYS: DNS: limit the length of option strings
Message-Id: <20180417182340.GB9237@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180416212922.233194-1-ebiggers3@gmail.com>
 <20180417.134316.1413649044013070735.davem@davemloft.net>
In-Reply-To: <20180417.134316.1413649044013070735.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, keyrings@vger.kernel.org, mark.rutland@arm.com, ebiggers@google.com

On Tue, Apr 17, 2018 at 01:43:16PM -0400, David Miller wrote:
> From: Eric Biggers <ebiggers3@gmail.com>
> Date: Mon, 16 Apr 2018 14:29:22 -0700
> 
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Adding a dns_resolver key whose payload contains a very long option name
> > resulted in that string being printed in full.  This hit the WARN_ONCE()
> > in set_precision() during the printk(), because printk() only supports a
> > precision of up to 32767 bytes:
> > 
> >     precision 1000000 too large
> >     WARNING: CPU: 0 PID: 752 at lib/vsprintf.c:2189 vsnprintf+0x4bc/0x5b0
> > 
> > Fix it by limiting option strings (combined name + value) to a much more
> > reasonable 128 bytes.  The exact limit is arbitrary, but currently the
> > only recognized option is formatted as "dnserror=%lu" which fits well
> > within this limit.
> > 
> > Also ratelimit the printks.
> > 
> > Reproducer:
> > 
> >     perl -e 'print "#", "A" x 1000000, "\x00"' | keyctl padd dns_resolver desc @s
> > 
> > This bug was found using syzkaller.
> > 
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Applied, thanks.

Can you queue this up for stable too?  syzbot has been hitting this on older
kernel versions.

Eric
