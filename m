From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 11 Sep 2020 15:04:24 +0000
Subject: Re: [PATCH] security: keys: Use kvfree_sensitive in a few places
Message-Id: <1599836664.4041.21.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200911114400.82207-1-alex.dewar90@gmail.com>
In-Reply-To: <20200911114400.82207-1-alex.dewar90@gmail.com>
To: Alex Dewar <alex.dewar90@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2020-09-11 at 12:44 +0100, Alex Dewar wrote:
> In big_key.c, there are a few places where memzero_explicit + kvfree
> is used. It is better to use kvfree_sensitive instead, which is more
> readable and also prevents the compiler from eliding the call to
> memzero_explicit. Fix this.

That last bit is untrue: the compiler can't elide memzero_explicit ...
that's why it has the explicit suffix.

The original problem was a lot of people do memset(.., 0, ..); kfree()
which the compiler can elide if it understands the memory is going out
of scope.  Or the even more problematic memset(..., 0, ...) on a stack
variable before it goes out of scope.

We can argue about readability but there's no secret leak here.

James
