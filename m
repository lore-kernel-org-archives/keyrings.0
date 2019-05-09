From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 09 May 2019 15:42:13 +0000
Subject: Re: [PATCH v10 03/12] PKCS#7: Introduce pkcs7_get_digest()
Message-Id: <1557416533.10635.63.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
         <20190418035120.2354-4-bauerman@linux.ibm.com>
In-Reply-To: <20190418035120.2354-4-bauerman@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>

On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
> IMA will need to access the digest of the PKCS7 message (as calculated by
> the kernel) before the signature is verified, so introduce
> pkcs7_get_digest() for that purpose.
> 
> Also, modify pkcs7_digest() to detect when the digest was already
> calculated so that it doesn't have to do redundant work. Verifying that
> sinfo->sig->digest isn't NULL is sufficient because both places which
> allocate sinfo->sig (pkcs7_parse_message() and pkcs7_note_signed_info())
> use kzalloc() so sig->digest is always initialized to zero.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
