From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 18 Sep 2020 06:47:21 +0000
Subject: Re: [PATCH v6 5/8] crypto: testmgr - support test with different ciphertext per encryption
Message-Id: <20200918064721.GA9520@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200903131242.128665-1-tianjia.zhang@linux.alibaba.com>
 <20200903131242.128665-6-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200903131242.128665-6-tianjia.zhang@linux.alibaba.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Stephan Mueller <smueller@chronox.de>, Brendan Higgins <brendanhiggins@google.com>, Jia Zhang <zhang.jia@linux.alibaba.com>, Mimi Zohar <zohar@linux.ibm.com>, Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Masahiro Yamada <masahiroy@kernel.org>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, Waiman Long <longman@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Alexandre Torgue <alexandre.torgue@st.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-arm-kernel@lists.infradead.org, David Howells <dhowells@redhat.com>, Pascal van Leeuwen <pvanleeuwen@rambus.com>, linux-kernel@vger.kernel.org, Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>, linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Sep 03, 2020 at 09:12:39PM +0800, Tianjia Zhang wrote:
> Some asymmetric algorithms will get different ciphertext after
> each encryption, such as SM2, and let testmgr support the testing
> of such algorithms.
> 
> In struct akcipher_testvec, set c and c_size to be empty, skip
> the comparison of the ciphertext, and compare the decrypted
> plaintext with m to achieve the test purpose.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Tested-by: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
> ---
>  crypto/testmgr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Is there supposed to be another patch that contains test vectors?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
