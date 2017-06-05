From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Date: Mon, 05 Jun 2017 21:51:32 +0000
Subject: Re: [PATCH v2] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API
Message-Id: <26272836.b4vH9V8tES@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1638.1496419102@warthog.procyon.org.uk>
In-Reply-To: <1638.1496419102@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org

Am Montag, 5. Juni 2017, 05:41:32 CEST schrieb Eric Biggers:

Hi Eric,
> 
> Also, Stephan, what is the purpose of the "__spare" field in
> keyctl_kdf_params? How is it ever supposed to be used for anything if the
> kernel doesn't even validate that it contains 0's?  Some flag hacked into
> the 'otherinfolen' field...?

The idea in the very first patch set was the presence of a "flags" field. We 
have a proliferation of system calls in the last few years which just add a 
"flags" parameter compared to an identical older system call.

To prevent falling into this trap, I wanted to have a flags field. The core 
reason is that there are multiple options allowed and possible how to derive a 
key. The current approach is the easiest and smallest one, i.e. using the 
SP800-108 counter KDF. Other KDFs are possible too. To allow such openness, we 
decided to leave some room.

See https://patchwork.kernel.org/patch/9224837/ and search for __spare[8] in 
the answer from Mat.

Ciao
Stephan
