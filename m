From: David Howells <dhowells@redhat.com>
Date: Tue, 28 Nov 2017 10:55:40 +0000
Subject: Re: [PATCH] crypto: rsa - fix buffer overread when stripping leading zeroes
Message-Id: <9950.1511866540@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171127071649.25800-1-ebiggers3@gmail.com>
In-Reply-To: <20171127071649.25800-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, Alexander Potapenko <glider@google.com>, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org, Tudor Ambarus <tudor-dan.ambarus@nxp.com>

Eric Biggers <ebiggers3@gmail.com> wrote:

> In rsa_get_n(), if the buffer contained all 0's and "FIPS mode" is
> enabled, we would read one byte past the end of the buffer while
> scanning the leading zeroes.  Fix it by checking 'n_sz' before '!*ptr'.

Reviewed-by: David Howells <dhowells@redhat.com>
