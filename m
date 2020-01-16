From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 16 Jan 2020 12:56:50 +0000
Subject: Re: [PATCH] IMA: pre-allocate keyrings string
Message-Id: <1579179410.5857.21.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200116031508.3481-1-nramas@linux.microsoft.com>
In-Reply-To: <20200116031508.3481-1-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: sashal@kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Hi Laskhmi,

On Wed, 2020-01-15 at 19:15 -0800, Lakshmi Ramasubramanian wrote:
> ima_match_keyring() is called while holding rcu read lock.
> Since this function executes in atmomic context, it should
> not call any function that can sleep (such as kstrdup()).

Good catch!

> This patch pre-allocates a buffer to hold the keyrings
> string read from the IMA policy and uses that to check
> the given keyring in ima_match_keyring().

(Reminder: this patch description line length is a bit short.
 According to  Documentation/process/submitting-patches.rst, the patch
description line length should be line wrapped at 75 columns.)

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Fixes: e9085e0ad38a ("IMA: Add support to limit measuring keys")
> ---

 
> @@ -1120,8 +1117,17 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				result = -EINVAL;
>  				break;
>  			}
> +
> +			ima_keyrings = kstrdup(args[0].from, GFP_KERNEL);
> +			if (!ima_keyrings) {
> +				result = -ENOMEM;
> +				break;
> +			}


This would work for a single "key" measurement rule, but not for
multiple rules, where the last "keyrings" string is shorter than the
previous ones.  For example, in addition to the builtin trusted
keyrings, another rule could measure a keyring owned by a user.

measure func=KEY_CHECK template=ima-buf keyrings=.ima|.builtin_trusted_keys
measure func=KEY_CHECK uid00 template=ima-buf keyrings=_foo

Mimi

>  			entry->keyrings = kstrdup(args[0].from, GFP_KERNEL);
>  			if (!entry->keyrings) {
> +				kfree(ima_keyrings);
> +				ima_keyrings = NULL;
>  				result = -ENOMEM;
>  				break;
>  			}
