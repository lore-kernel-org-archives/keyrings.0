From: David Howells <dhowells@redhat.com>
Date: Thu, 28 Feb 2019 18:18:54 +0000
Subject: Re: [PATCH v5 04/10] crypto: akcipher - new verify API for public key algorithms
Message-Id: <14843.1551377934@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190224060828.2527-5-vt@altlinux.org> <20190224060828.2527-1-vt@altlinux.org>
In-Reply-To: <20190224060828.2527-5-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Vitaly Chikunov <vt@altlinux.org> wrote:

> +	digest = kmemdup(sig->digest, sig->digest_size, GFP_KERNEL);
> +	if (!digest)

You shouldn't need to copy the digest.  It's being passed in to the crypto
algorithm, not extracted out.

> +		if (memcmp(c, outbuf_enc, c_size)) {

Please use = 0 and != 0 with memcmp() and strcmp().  Their return values are
kind of inverted in sense if you treat them as boolean.

David
