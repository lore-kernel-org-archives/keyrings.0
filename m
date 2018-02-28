From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 28 Feb 2018 19:05:10 +0000
Subject: [PATCH v2] KEYS: DNS: limit the length of option strings
Message-Id: <20180228190510.215801-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

Adding a dns_resolver key whose payload contains a very long option name
resulted in that string being printed in full.  This hit the WARN_ONCE()
in set_precision() during the printk(), because printk() only supports a
precision of up to 32767 bytes:

    precision 1000000 too large
    WARNING: CPU: 0 PID: 752 at lib/vsprintf.c:2189 vsnprintf+0x4bc/0x5b0

Fix it by limiting option strings (combined name + value) to a much more
reasonable 128 bytes.  The exact limit is arbitrary, but currently the
only recognized option is formatted as "dnserror=%lu" which fits well
within this limit.

Also ratelimit the printks.

Reproducer:

    perl -e 'print "#", "A" x 1000000, "\x00"' | keyctl padd dns_resolver desc @s

This bug was found using syzkaller.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
Cc: <stable@vger.kernel.org> # v2.6.36+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 net/dns_resolver/dns_key.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index e1d4d898a007..ed372d550137 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -91,9 +91,9 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 
 			next_opt = memchr(opt, '#', end - opt) ?: end;
 			opt_len = next_opt - opt;
-			if (!opt_len) {
-				printk(KERN_WARNING
-				       "Empty option to dns_resolver key\n");
+			if (opt_len <= 0 || opt_len > 128) {
+				pr_warn_ratelimited("Invalid option length (%d) for dns_resolver key\n",
+						    opt_len);
 				return -EINVAL;
 			}
 
@@ -127,10 +127,8 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 			}
 
 		bad_option_value:
-			printk(KERN_WARNING
-			       "Option '%*.*s' to dns_resolver key:"
-			       " bad/missing value\n",
-			       opt_nlen, opt_nlen, opt);
+			pr_warn_ratelimited("Option '%*.*s' to dns_resolver key: bad/missing value\n",
+					    opt_nlen, opt_nlen, opt);
 			return -EINVAL;
 		} while (opt = next_opt + 1, opt < end);
 	}
-- 
2.16.2.395.g2e18187dfd-goog

