From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 09 May 2019 15:42:20 +0000
Subject: Re: [PATCH v10 02/12] PKCS#7: Refactor verify_pkcs7_signature()
Message-Id: <1557416540.10635.64.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
         <20190418035120.2354-3-bauerman@linux.ibm.com>
In-Reply-To: <20190418035120.2354-3-bauerman@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>

On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
> IMA will need to verify a PKCS#7 signature which has already been parsed.
> For this reason, factor out the code which does that from
> verify_pkcs7_signature() into a new function which takes a struct
> pkcs7_message instead of a data buffer.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
