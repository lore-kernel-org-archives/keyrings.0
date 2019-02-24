From: Vitaly Chikunov <vt@altlinux.org>
Date: Sun, 24 Feb 2019 06:48:40 +0000
Subject: Re: [RFC PATCH 1/4] X.509: Parse public key parameters from x509 for akcipher
Message-Id: <20190224064840.hii4ccjksjdnewae@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190106133608.820-1-vt@altlinux.org>
 <20190106133608.820-2-vt@altlinux.org>
 <20190209214240.56gq7ivn3pw3bssf@altlinux.org>
 <20190210184628.yupsxgjlaicwbxg6@altlinux.org>
 <20190219043732.x3sbwzqlz4ikntxo@gondor.apana.org.au>
In-Reply-To: <20190219043732.x3sbwzqlz4ikntxo@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Herbert,

On Tue, Feb 19, 2019 at 12:37:32PM +0800, Herbert Xu wrote:
> On Sun, Feb 10, 2019 at 09:46:28PM +0300, Vitaly Chikunov wrote:
> >
> > >From the other point of view, set_params may never be called or
> > implemented. So, making it called first and move memory zeroing
> > into set_params may create more complications than simplicity.
> > 
> > Making both callbacks callable in any order also will not make
> > things simpler. (Need to be prepared to be called in different
> > order.)
> 
> How about encoding these parameters together with the public/private
> keys so that they can be set through the existing setkey functions?
> 
> You might want to have a look at how we handle this in crypto/dh.c.

Thanks. I viewed and thought about this idea. But, I think separate
set_params call will be the most simple and backward compatible approach.

[In the new patchset] I made set_params to be called before set_p*_key
call, thus set_p*_key will know everything to start processing the key
immediately. Also, I made set_params completely optional, so code that
rely on RSA can just not call it, and driver that actually needs
set_params may check if required parameters are set or return an error.

(I overthought about zeroing of memory (in previous mail) that turned
out completely non-problem as ctx in `struct crypto_akcipher' is always
zeroed and I don't need to use ctx from `struct akcipher_request').


More thoughts. Parameters are part of AlgorithmIdentifier which is
included in SubjectPublicKeyInfo together with subjectPublicKey.

This, to pass into set_params callback AlgorithmIdentifier is the same
as passing just parameters. But, passing SubjectPublicKeyInfo will
overlap with passing the key into set_pub_key. So, if we pass other
structure (SubjectPublicKeyInfo) into set_params we will logically
conflict with set_pub_key and that call will be alternative to
set_pub_key, making one of them redundant.

If we pass SubjectPublicKeyInfo into set_pub_key itself (making
set_params not needed) we will break ABI and compatibility with RSA
drivers, because whole SubjectPublicKeyInfo is not expected by the
drivers, or new set_pub_key need somehow signal to the driver that is
different parameters are going (callers should be aware of that too),
and/or we will need to change all RSA-centric code to use
SubjectPublicKeyInfo which will affect to much code (more than verify2
required I think). And this will offload work which is already done by
x509 parser into the drivers bloating their code needlessly.

Thus, I think to try to remove set_params will only increase complexity.
Now it's small, very flexible, and back compatible.

Thanks,
