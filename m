From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Mon, 07 Oct 2019 10:33:11 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <CAE=NcrY3BTvD-L2XP6bsO=9oAJLtSD0wYpUymVkAGAnYObsPzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190926171601.30404-1-jarkko.sakkinen@linux.intel.com>
 <1570024819.4999.119.camel@linux.ibm.com> <20191003114119.GF8933@linux.intel.com>
In-Reply-To: <20191003114119.GF8933@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Oct 3, 2019 at 2:41 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:

> > At what point during boot is the kernel random pool available?  Does
> > this imply that you're planning on changing trusted keys as well?
>
> Well trusted keys *must* be changed to use it. It is not a choice
> because using a proprietary random number generator instead of defacto
> one in the kernel can be categorized as a *regression*.
>
> Also, TEE trusted keys cannot use the TPM option.
>
> If it was not initialized early enough we would need fix that too.

Note that especially IMA and fs encryptions are pretty annoying in
this sense. You probably want to keep your keys device specific and
you really need the keys around the time when the filesystems mount
for the first time. This is very early on..


--
Janne
