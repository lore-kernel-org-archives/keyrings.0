From: David Howells <dhowells@redhat.com>
Date: Fri, 16 Feb 2018 09:05:52 +0000
Subject: Re: [RFC PATCH] KEYS: Use individual pages in big_key for crypto buffers [ver #2]
Message-Id: <30807.1518771952@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180216015629.GA136603@gmail.com> <151873522941.16065.2576464502758911341.stgit@warthog.procyon.org.uk>
In-Reply-To: <20180216015629.GA136603@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, Jason@zx2c4.com, herbert@gondor.apana.org.au, k.marinushkin@gmail.com, linux-crypto@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> memset() after vunmap(), and also when buf->virt can be NULL?  I had suggested:
> 
>         if (buf->virt) {
>                 memset(buf->virt, 0, buf->nr_pages * PAGE_SIZE);
>                 vunmap(buf->virt);
>         }

Sorry, yes.  I don't know why the change I made doesn't oops.

David
