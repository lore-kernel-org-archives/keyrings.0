From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 11 Sep 2020 04:24:42 +0000
Subject: Re: [PATCH v6 0/8] crpyto: introduce OSCCA certificate and SM2 asymmetric algorithm
Message-Id: <20200911042442.GA5420@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200903131242.128665-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200903131242.128665-1-tianjia.zhang@linux.alibaba.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Stephan Mueller <smueller@chronox.de>, Brendan Higgins <brendanhiggins@google.com>, Jia Zhang <zhang.jia@linux.alibaba.com>, Mimi Zohar <zohar@linux.ibm.com>, Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Masahiro Yamada <masahiroy@kernel.org>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, Waiman Long <longman@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Alexandre Torgue <alexandre.torgue@st.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-arm-kernel@lists.infradead.org, David Howells <dhowells@redhat.com>, Pascal van Leeuwen <pvanleeuwen@rambus.com>, linux-kernel@vger.kernel.org, Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>, linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Sep 03, 2020 at 09:12:34PM +0800, Tianjia Zhang wrote:
>
> ---
> v6 changes:
>   1. remove mpi_sub_ui function from mpi library.
>   2. rebase on mainline.

This series is still missing acks for patches 6-8.  Without them
it cannot proceed.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
