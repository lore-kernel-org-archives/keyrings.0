From: David Howells <dhowells@redhat.com>
Date: Thu, 28 Feb 2019 19:02:09 +0000
Subject: Re: [PATCH v5 04/10] crypto: akcipher - new verify API for public key algorithms
Message-Id: <17533.1551380529@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190228183923.5klzwli5zmeew54j@altlinux.org> <20190224060828.2527-5-vt@altlinux.org> <20190224060828.2527-1-vt@altlinux.org> <14843.1551377934@warthog.procyon.org.uk>
In-Reply-To: <20190228183923.5klzwli5zmeew54j@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

| > It's not clear that sig->digest is guaranteed to be kmalloc memory.

Well, public_key_signature_free() will go bang if it's not kfree'able.

David
