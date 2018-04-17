From: David Miller <davem@davemloft.net>
Date: Tue, 17 Apr 2018 19:18:45 +0000
Subject: Re: [PATCH RESEND net v2] KEYS: DNS: limit the length of option strings
Message-Id: <20180417.151845.1215574870086065510.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180417190706.217384-1-ebiggers3@gmail.com>
In-Reply-To: <20180417190706.217384-1-ebiggers3@gmail.com>
To: ebiggers3@gmail.com
Cc: netdev@vger.kernel.org, keyrings@vger.kernel.org, mark.rutland@arm.com, ebiggers@google.com

From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 17 Apr 2018 12:07:06 -0700

> From: Eric Biggers <ebiggers@google.com>
> 
> Adding a dns_resolver key whose payload contains a very long option name
> resulted in that string being printed in full.  This hit the WARN_ONCE()
> in set_precision() during the printk(), because printk() only supports a
> precision of up to 32767 bytes:
> 
>     precision 1000000 too large
>     WARNING: CPU: 0 PID: 752 at lib/vsprintf.c:2189 vsnprintf+0x4bc/0x5b0
> 
> Fix it by limiting option strings (combined name + value) to a much more
> reasonable 128 bytes.  The exact limit is arbitrary, but currently the
> only recognized option is formatted as "dnserror=%lu" which fits well
> within this limit.
> 
> Also ratelimit the printks.
> 
> Reproducer:
> 
>     perl -e 'print "#", "A" x 1000000, "\x00"' | keyctl padd dns_resolver desc @s
> 
> This bug was found using syzkaller.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied and qeueud up for -stable, thanks.
