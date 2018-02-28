From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 28 Feb 2018 02:34:19 +0000
Subject: Re: [PATCH] KEYS: DNS: limit the length of option strings
Message-Id: <1519785259.7296.13.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228014905.68153-1-ebiggers3@gmail.com>
In-Reply-To: <20180228014905.68153-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Eric Biggers <ebiggers@google.com>

On Tue, 2018-02-27 at 17:49 -0800, Eric Biggers wrote:
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
> Reproducer:
> 
>     perl -e 'print "#", "A" x 1000000, "\x00"' | keyctl padd dns_resolver desc @s
> 
> This bug was found using syzkaller.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
> Cc: <stable@vger.kernel.org> # v2.6.36+
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  net/dns_resolver/dns_key.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index e1d4d898a007..7c0aae2e512d 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -91,9 +91,9 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>  
>  			next_opt = memchr(opt, '#', end - opt) ?: end;
>  			opt_len = next_opt - opt;
> -			if (!opt_len) {
> -				printk(KERN_WARNING
> -				       "Empty option to dns_resolver key\n");
> +			if (opt_len <= 0 || opt_len > 128) {
> +				pr_warn("Invalid option length (%d) for dns_resolver key\n",
> +					opt_len);

If a bot can harass us here, then pr_warn_ratelimited would be nice ?


