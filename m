From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 16 Sep 2017 07:05:48 +0000
Subject: Re: [PATCH] security: keys: switch big_key encryption to AES in CTR mode
Message-Id: <CAKv+Gu-RMRT+H=jnQaYT0DkgMDmTfBVfXSvb83Cmr9wi=DEqsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170915223723.20789-1-ard.biesheuvel@linaro.org>
	<20170916024753.GA6901@zzz.localdomain>
In-Reply-To: <20170916024753.GA6901@zzz.localdomain>
To: linux-security-module@vger.kernel.org

On 15 September 2017 at 19:47, Eric Biggers <ebiggers3@gmail.com> wrote:
> [Added Jason Donenfeld to Cc]
>
> Hi Ard,
>
> On Fri, Sep 15, 2017 at 03:37:23PM -0700, Ard Biesheuvel wrote:
>> The ECB chaining mode only supports inputs that are a multiple of the
>> blocksize. Furthermore, it is not recommended for direct use, given
>> that it may reveal recurring patterns in the plaintext, due to the
>> lack of feedback between input blocks. So let's solve both issues at
>> once, and switch to AES in CTR mode.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> The choice of ECB here is definitely a mistake, but it really should use an
> authenticated encryption mode such as GCM rather than plain CTR.  There was a
> patch a few months ago that implemented this and fixed a couple other problems,
> but it hasn't been merged; maybe someone wants to take over that patch instead?
> Link: http://lkml.kernel.org/r/20170607101209.7603-1-Jason@zx2c4.com
>

Ah right, fair enough. I just happened to be standing next to David
when Ilhan brought up the issue, so I had no idea that a patch had
been proposed already.
