From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sat, 16 Sep 2017 12:40:24 +0000
Subject: Re: [PATCH] security: keys: switch big_key encryption to AES in CTR mode
Message-Id: <CAHmME9pP72SSFiEPmH4VhQcoVyWcHK2p402+EbzEd0WepnA1qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170915223723.20789-1-ard.biesheuvel@linaro.org>
	<20170916024753.GA6901@zzz.localdomain>
In-Reply-To: <20170916024753.GA6901@zzz.localdomain>
To: linux-security-module@vger.kernel.org

Hey Eric,

Thanks for adding me to the CC.

On Sep 16, 2017 05:14, "Eric Biggers" <ebiggers3@gmail.com> wrote:
> There was a
> patch a few months ago that implemented this and fixed a couple other problems,
> but it hasn't been merged; maybe someone wants to take over that patch instead?
> Link: http://lkml.kernel.org/r/20170607101209.7603-1-Jason@zx2c4.com

I didn't realize this patch wasn't merged and was eventually
neglected. (I wonder how many other of my patches have met this
fate...) I'll take another look at it this week and resubmit (and
possibly tweek if needed).

Regards,
Jason
