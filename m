From: David Howells <dhowells@redhat.com>
Date: Fri, 07 Jul 2017 08:19:40 +0000
Subject: Re: [PATCH] KEYS: DH: validate __spare field
Message-Id: <13537.1499415580@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170703205041.15788-1-ebiggers3@gmail.com>
In-Reply-To: <20170703205041.15788-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, Stephan Mueller <smueller@chronox.de>, stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>

Eric Biggers <ebiggers3@gmail.com> wrote:

> Syscalls must validate that their reserved arguments are zero and return
> EINVAL otherwise.  Otherwise, it will be impossible to actually use them
> for anything in the future because existing programs may be passing
> garbage in.  This is standard practice when adding new APIs.

Fine by me.  Mat?

David
