From: David Howells <dhowells@redhat.com>
Date: Thu, 15 Feb 2018 21:36:01 +0000
Subject: Re: [RFC PATCH] KEYS: Use individual pages in big_key for crypto buffers
Message-Id: <13335.1518730561@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180215204528.GA49445@gmail.com> <151871006638.2759.15708879200455370908.stgit@warthog.procyon.org.uk>
In-Reply-To: <20180215204528.GA49445@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, Jason@zx2c4.com, herbert@gondor.apana.org.au, k.marinushkin@gmail.com, linux-crypto@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> If big_key_alloc_buffer() fails to allocate one of the pages then some of
> the pages may still be NULL here, causing __free_page() to crash.  You need
> to check for NULL first.

Ah, yes.  I incorrectly used free_page() first - and that does check for a
NULL pointer.  Applied your other changes also.

David
