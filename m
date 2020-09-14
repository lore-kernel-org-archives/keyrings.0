From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Date: Mon, 14 Sep 2020 07:04:35 +0000
Subject: Re: [PATCH v6 0/8] crpyto: introduce OSCCA certificate and SM2 asymmetric algorithm
Message-Id: <be5f7e28-5645-3923-ceb5-d840e41ad2ed@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200903131242.128665-1-tianjia.zhang@linux.alibaba.com>
 <20200911042442.GA5420@gondor.apana.org.au>
In-Reply-To: <20200911042442.GA5420@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stephan Mueller <smueller@chronox.de>, Brendan Higgins <brendanhiggins@google.com>, Jia Zhang <zhang.jia@linux.alibaba.com>, Mimi Zohar <zohar@linux.ibm.com>, Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Masahiro Yamada <masahiroy@kernel.org>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, Waiman Long <longman@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Alexandre Torgue <alexandre.torgue@st.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-arm-kernel@lists.infradead.org, David Howells <dhowells@redhat.com>, Pascal van Leeuwen <pvanleeuwen@rambus.com>, linux-kernel@vger.kernel.org, Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>, linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

Hi，

On 9/11/20 12:24 PM, Herbert Xu wrote:
> On Thu, Sep 03, 2020 at 09:12:34PM +0800, Tianjia Zhang wrote:
>>
>> ---
>> v6 changes:
>>    1. remove mpi_sub_ui function from mpi library.
>>    2. rebase on mainline.
> 
> This series is still missing acks for patches 6-8.  Without them
> it cannot proceed.
> 
> Thanks,
> 

This series has some review suggestions for patches 6-8, but the 
maintainer of asymmetric keys David Howells <dhowells@redhat.com>, I 
can’t get in touch. The email has been sent successfully. Can you help 
ping him ?

Thanks and best,
Tianjia
