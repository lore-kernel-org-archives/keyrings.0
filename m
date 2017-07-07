From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Fri, 07 Jul 2017 16:04:46 +0000
Subject: Re: [PATCH] KEYS: DH: validate __spare field
Message-Id: <alpine.OSX.2.21.1707070856060.13020@hungnguy-mobl1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170703205041.15788-1-ebiggers3@gmail.com> <13537.1499415580@warthog.procyon.org.uk>
In-Reply-To: <13537.1499415580@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers3@gmail.com>, keyrings@vger.kernel.org, Stephan Mueller <smueller@chronox.de>, stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>

On Fri, 7 Jul 2017, David Howells wrote:

> Eric Biggers <ebiggers3@gmail.com> wrote:
>
>> Syscalls must validate that their reserved arguments are zero and return
>> EINVAL otherwise.  Otherwise, it will be impossible to actually use them
>> for anything in the future because existing programs may be passing
>> garbage in.  This is standard practice when adding new APIs.
>
> Fine by me.  Mat?

Looks good, please apply the patch. Thanks for catching this, Eric.

--
Mat Martineau
Intel OTC
