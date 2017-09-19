From: David Howells <dhowells@redhat.com>
Date: Tue, 19 Sep 2017 16:22:28 +0000
Subject: Re: [PATCH] KEYS: fix race between updating and finding negative key
Message-Id: <31182.1505838148@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170918204808.119855-1-ebiggers3@gmail.com>
In-Reply-To: <20170918204808.119855-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Fix the bug by moving ->reject_error out of the union with ->payload,
> then using nonzero ->reject_error to mean that the key is negative.
> 
> This eliminates the need for KEY_FLAG_NEGATIVE, which we remove as well
> so that we don't have to handle memory ordering between
> KEY_FLAG_NEGATIVE and ->reject_error.  We *do* still need to handle
> memory ordering between KEY_FLAG_INSTANTIATED and ->reject_error, but
> that was needed before (and for KEY_FLAG_NEGATIVE as well --- though it
> wasn't done correctly, which was another bug).

Hmmm...  My only objection is that it extends struct key still further, but
you do have a point.

If we're going to do this, can we eliminate KEY_FLAG_INSTANTIATED also and
make ->reject_error into ->status?

	0	-> uninstantiated
	1	-> instantiated
	<0	-> negatively instantiated/rejected

Also, can we make it a short int please?

Also, can setting this field be done with a release barrier rather than a
write barrier?

David
