From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Wed, 16 Sep 2020 08:01:34 +0000
Subject: Re: [PATCH v6 7/8] X.509: support OSCCA sm2-with-sm3 certificate verification
Message-Id: <CAOtvUMdxeYxztajMG=XDzV-G8cB2GLaVnNBSAxLkwuZwqPxr2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200903131242.128665-1-tianjia.zhang@linux.alibaba.com>
 <20200903131242.128665-8-tianjia.zhang@linux.alibaba.com>
 <CAOtvUMfT5zgv=e9nCgz8-1r7LuYSRZ8Zdx2xc0JwckUJZufcvg@mail.gmail.com>
 <6f251e1e-42a0-7e6c-e0cd-51fba3150d17@linux.alibaba.com>
In-Reply-To: <6f251e1e-42a0-7e6c-e0cd-51fba3150d17@linux.alibaba.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Stephan Mueller <smueller@chronox.de>, Brendan Higgins <brendanhiggins@google.com>, Jia Zhang <zhang.jia@linux.alibaba.com>, Mimi Zohar <zohar@linux.ibm.com>, Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Herbert Xu <herbert@gondor.apana.org.au>, Masahiro Yamada <masahiroy@kernel.org>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, Waiman Long <longman@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Alexandre Torgue <alexandre.torgue@st.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, David Howells <dhowells@redhat.com>, Pascal van Leeuwen <pvanleeuwen@rambus.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>, linux-security-module@vger.kernel.org, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Sep 14, 2020 at 9:34 AM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> Hi Gilad,
>
> On 9/13/20 3:12 PM, Gilad Ben-Yossef wrote:
> > Hi,
> >
> >
> > On Thu, Sep 3, 2020 at 4:13 PM Tianjia Zhang
> > <tianjia.zhang@linux.alibaba.com> wrote:
> >>
> >> The digital certificate format based on SM2 crypto algorithm as
> >> specified in GM/T 0015-2012. It was published by State Encryption
> >> Management Bureau, China.
> >>
> >> The method of generating Other User Information is defined as
> >> ZA=H256(ENTLA || IDA || a || b || xG || yG || xA || yA), it also
> >> specified in https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02.
> >>
> >> The x509 certificate supports sm2-with-sm3 type certificate
> >> verification.  Because certificate verification requires ZA
> >> in addition to tbs data, ZA also depends on elliptic curve
> >> parameters and public key data, so you need to access tbs in sig
> >> and calculate ZA. Finally calculate the digest of the
> >> signature and complete the verification work. The calculation
> >> process of ZA is declared in specifications GM/T 0009-2012
> >> and GM/T 0003.2-2012.
> >>
> >> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> >> Tested-by: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
> >> ---
> >>   crypto/asymmetric_keys/Makefile          |  1 +
> >>   crypto/asymmetric_keys/public_key.c      |  6 +++
> >>   crypto/asymmetric_keys/public_key_sm2.c  | 61 ++++++++++++++++++++++++
> >>   crypto/asymmetric_keys/x509_public_key.c |  3 ++
> >>   include/crypto/public_key.h              | 15 ++++++
> >>   5 files changed, 86 insertions(+)
> >>   create mode 100644 crypto/asymmetric_keys/public_key_sm2.c
> >>
> >> diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
> >> index 28b91adba2ae..1a99ea5acb6b 100644
> >> --- a/crypto/asymmetric_keys/Makefile
> >> +++ b/crypto/asymmetric_keys/Makefile
> >> @@ -11,6 +11,7 @@ asymmetric_keys-y := \
> >>          signature.o
> >>
> >>   obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
> >> +obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key_sm2.o
> >>   obj-$(CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE) += asym_tpm.o
> >>
> >>   #
> >> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> >> index d8410ffd7f12..1d0492098bbd 100644
> >> --- a/crypto/asymmetric_keys/public_key.c
> >> +++ b/crypto/asymmetric_keys/public_key.c
> >> @@ -299,6 +299,12 @@ int public_key_verify_signature(const struct public_key *pkey,
> >>          if (ret)
> >>                  goto error_free_key;
> >>
> >> +       if (strcmp(sig->pkey_algo, "sm2") == 0 && sig->data_size) {
> >> +               ret = cert_sig_digest_update(sig, tfm);
> >> +               if (ret)
> >> +                       goto error_free_key;
> >> +       }
> >> +
> >>          sg_init_table(src_sg, 2);
> >>          sg_set_buf(&src_sg[0], sig->s, sig->s_size);
> >>          sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
> >> diff --git a/crypto/asymmetric_keys/public_key_sm2.c b/crypto/asymmetric_keys/public_key_sm2.c
> >> new file mode 100644
> >> index 000000000000..7325cf21dbb4
> >> --- /dev/null
> >> +++ b/crypto/asymmetric_keys/public_key_sm2.c
> >> @@ -0,0 +1,61 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +/*
> >> + * asymmetric public-key algorithm for SM2-with-SM3 certificate
> >> + * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
> >> + * described at https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
> >> + *
> >> + * Copyright (c) 2020, Alibaba Group.
> >> + * Authors: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> >> + */
> >> +
> >> +#include <crypto/sm3_base.h>
> >> +#include <crypto/sm2.h>
> >> +#include <crypto/public_key.h>
> >> +
> >> +#if IS_REACHABLE(CONFIG_CRYPTO_SM2)
> >> +
> >> +int cert_sig_digest_update(const struct public_key_signature *sig,
> >> +                               struct crypto_akcipher *tfm_pkey)
> >> +{
> >> +       struct crypto_shash *tfm;
> >> +       struct shash_desc *desc;
> >> +       size_t desc_size;
> >> +       unsigned char dgst[SM3_DIGEST_SIZE];
> >> +       int ret;
> >> +
> >> +       BUG_ON(!sig->data);
> >> +
> >> +       ret = sm2_compute_z_digest(tfm_pkey, SM2_DEFAULT_USERID,
> >> +                                       SM2_DEFAULT_USERID_LEN, dgst);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
> >> +       if (IS_ERR(tfm))
> >> +               return PTR_ERR(tfm);
> >> +
> >> +       desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
> >> +       desc = kzalloc(desc_size, GFP_KERNEL);
> >> +       if (!desc)
> >> +               goto error_free_tfm;
> >> +
> >> +       desc->tfm = tfm;
> >> +
> >> +       ret = crypto_shash_init(desc);
> >> +       if (ret < 0)
> >> +               goto error_free_desc;
> >> +
> >> +       ret = crypto_shash_update(desc, dgst, SM3_DIGEST_SIZE);
> >> +       if (ret < 0)
> >> +               goto error_free_desc;
> >> +
> >> +       ret = crypto_shash_finup(desc, sig->data, sig->data_size, sig->digest);
> >
> > It looks like you are doing a separate init, update, finup every time
> > - I would consider using crypto_shash_digest() in one go.
> >
> > In fact, considering the fact that you are allocating a tfm just for
> > this use and then releasing it, I would consider switching to
> > crypto_shash_tfm_digest() and dropping the kzalloc all together.
> >
> > This should simplify the code a bit.
> >
> > Other than that I don't have anything smart to say :-)
> >
> > Gilad
> >
>
> The hash calculation here includes two parts of data, 'dgst' and
> 'sig->data'. The last call is 'finup()' not 'final()'. I understand that
> it should not be possible to use 'crypto_shash_tfm_digest()' This kind
> of function is simplified.
>
> If a new scope is added, the assignment of desc can be optimized, as
> follows:
> ```
> do {
>      SHASH_DESC_ON_STACK(desc, tfm);
>      desc->tfm = tfm;
>
>      /* ... */
> } while (0);
> ```
> However, the kernel code may not accept this style. What is your opinion?

No, you are right. I've indeed missed that it's a finup() and not a
final(). If the size of data was big enough it might have been worth
going to the async. hash interface and creating a scatter list for
this but I suspect it is not justified with the data sizes we are
dealing with there.

So:

Reviewed-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks,
Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

values of β will give rise to dom!
