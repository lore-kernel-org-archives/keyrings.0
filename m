From: David Howells <dhowells@redhat.com>
Date: Wed, 16 Jan 2019 16:19:11 +0000
Subject: Re: [RFC PATCH 2/4] akcipher: Introduce verify2 for public key algorithms
Message-Id: <21754.1547655551@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190106133608.820-3-vt@altlinux.org> <20190106133608.820-1-vt@altlinux.org>
In-Reply-To: <20190106133608.820-3-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Vitaly Chikunov <vt@altlinux.org> wrote:

> Current akcipher .verify() just decrypts signature to uncover message
> hash, which is then verified in upper level public_key_verify_signature
> by memcmp with the expected signature value, which is never passed into
> verify().

I think it would be better to make ->verify() take the data hash we've been
given rather than returning the expected hash for the caller to compare.  That
way the callers don't have to do two different things, depending on how the
crypto algo works.

David
