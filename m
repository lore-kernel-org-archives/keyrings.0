From: David Miller <davem@davemloft.net>
Date: Mon, 16 Jul 2018 18:22:44 +0000
Subject: Re: [PATCH net v2] KEYS: DNS: fix parsing multiple options
Message-Id: <20180716.112244.1951972852539445443.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180711174629.2700-1-ebiggers3@gmail.com>
In-Reply-To: <20180711174629.2700-1-ebiggers3@gmail.com>
To: ebiggers3@gmail.com
Cc: netdev@vger.kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com, wang840925@gmail.com, ebiggers@google.com

From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 11 Jul 2018 10:46:29 -0700

> From: Eric Biggers <ebiggers@google.com>
> 
> My recent fix for dns_resolver_preparse() printing very long strings was
> incomplete, as shown by syzbot which still managed to hit the
> WARN_ONCE() in set_precision() by adding a crafted "dns_resolver" key:
> 
>     precision 50001 too large
>     WARNING: CPU: 7 PID: 864 at lib/vsprintf.c:2164 vsnprintf+0x48a/0x5a0
> 
> The bug this time isn't just a printing bug, but also a logical error
> when multiple options ("#"-separated strings) are given in the key
> payload.  Specifically, when separating an option string into name and
> value, if there is no value then the name is incorrectly considered to
> end at the end of the key payload, rather than the end of the current
> option.  This bypasses validation of the option length, and also means
> that specifying multiple options is broken -- which presumably has gone
> unnoticed as there is currently only one valid option anyway.
> 
> A similar problem also applied to option values, as the kstrtoul() when
> parsing the "dnserror" option will read past the end of the current
> option and into the next option.
> 
> Fix these bugs by correctly computing the length of the option name and
> by copying the option value, null-terminated, into a temporary buffer.
> 
> Reproducer for the WARN_ONCE() that syzbot hit:
> 
>     perl -e 'print "#A#", "\0" x 50000' | keyctl padd dns_resolver desc @s
> 
> Reproducer for "dnserror" option being parsed incorrectly (expected
> behavior is to fail when seeing the unknown option "foo", actual
> behavior was to read the dnserror value as "1#foo" and fail there):
> 
>     perl -e 'print "#dnserror=1#foo\0"' | keyctl padd dns_resolver desc @s
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> Changed since v1:
>     - Also fix parsing the option values, not just option names.

Applied and queued up for -stable.
