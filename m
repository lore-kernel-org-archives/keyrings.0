From: Vitaly Chikunov <vt@altlinux.org>
Date: Thu, 28 Feb 2019 19:07:42 +0000
Subject: Re: [PATCH v5 04/10] crypto: akcipher - new verify API for public key algorithms
Message-Id: <20190228190741.fv2qxwwtlpdffhwq@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190228183923.5klzwli5zmeew54j@altlinux.org>
 <20190224060828.2527-5-vt@altlinux.org>
 <20190224060828.2527-1-vt@altlinux.org>
 <14843.1551377934@warthog.procyon.org.uk>
 <17533.1551380529@warthog.procyon.org.uk>
In-Reply-To: <17533.1551380529@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

David,

On Thu, Feb 28, 2019 at 07:02:09PM +0000, David Howells wrote:
> | > It's not clear that sig->digest is guaranteed to be kmalloc memory.
> 
> Well, public_key_signature_free() will go bang if it's not kfree'able.

Well, I had similar argument, FYI:

| On Fri, Feb 01, 2019 at 10:09:23AM +0300, Vitaly Chikunov wrote:
| > On Fri, Feb 01, 2019 at 02:26:55PM +0800, Herbert Xu wrote:
| > >
| > > It's not clear that sig->digest is guaranteed to be kmalloc memory.
| > > In any case, it's best not to mix unrelated changes in a single
| > > patch.  So please keep the kmalloc on output and then copy
| > > sig->digest into it and put output into the SG list.
| >
| > It is not guaranteed that sig->s will be kmalloc memory either. (Except
| > we know it for sure like we know the same about sig->digest).
| >
| > You can see in public_key_signature_free() that both fields are kfree'd
| > together.
| >
| > So, I don't understand why we should treat sig->digest differently than
| > sig->s.
| >
| > I was just removing kmalloc'ed output as crypto_akcipher_verify() does
| > not need any output anymore. So, it's not some sort of mixing unrelated
| > changes, from my point of view.

But then I thought Herbert knows better and implemented his suggestion.

Now I have contradictory requests from two maintainers.
