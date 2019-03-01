From: Vitaly Chikunov <vt@altlinux.org>
Date: Fri, 01 Mar 2019 16:06:38 +0000
Subject: Re: [RFC PATCH 1/4] X.509: Parse public key parameters from x509 for akcipher
Message-Id: <20190301160638.z266z767m4ky3ohk@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190210184628.yupsxgjlaicwbxg6@altlinux.org>
 <20190219043732.x3sbwzqlz4ikntxo@gondor.apana.org.au>
 <20190224064840.hii4ccjksjdnewae@altlinux.org>
 <20190228061444.3escryzoit3idtwg@gondor.apana.org.au>
 <20190228070449.gjwoq4c2b3x5grie@altlinux.org>
 <20190228075141.s6mftb44yuylbzys@gondor.apana.org.au>
 <20190228082801.2aofw23r2shzwy4n@altlinux.org>
 <20190228090125.6n62v4oxpwl5yzv4@gondor.apana.org.au>
 <20190228103337.sbjujn27qkkgxqt2@altlinux.org>
 <20190228103715.ijvimcfysiguiwty@gondor.apana.org.au>
In-Reply-To: <20190228103715.ijvimcfysiguiwty@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Herbert,

On Thu, Feb 28, 2019 at 06:37:15PM +0800, Herbert Xu wrote:
> On Thu, Feb 28, 2019 at 01:33:37PM +0300, Vitaly Chikunov wrote:
> >
> > To make the same for set_{pub,priv}_key it will require patching RSA
> > drivers anyway, since length of the key is stored just once as keylen
> > argument.
> 
> No we don't need to use the same format for different algorithms.
> RSA should stay as is.

I will rework as you suggest. But, just want to state that I disagree
with this approach of implicitly appending parameters data to the key
stream without any argument signifying it or length covering it. This
fitting into the old API is also somewhat disagree to your words that
we could change internal API:

On Thu, Feb 28, 2019 at 02:14:44PM +0800, Herbert Xu wrote:
> On Sun, Feb 24, 2019 at 09:48:40AM +0300, Vitaly Chikunov wrote:
> ...
> This compatibility does not matter.  We can always add translating
> layers into the crypto API to deal with this.  The only ABI that
> matters is the one to user-space.
