From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 17 Oct 2019 12:52:35 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <CAFA6WYNNNTWXDrp_R3M60srGJYjJdRoaNpSnP54V_BinYYXTMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com>
 <20191007000520.GA17116@linux.intel.com> <59b88042-9c56-c891-f75e-7c0719eb5ff9@linux.ibm.com>
 <20191008234935.GA13926@linux.intel.com> <20191008235339.GB13926@linux.intel.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2B995@ALPMBAPA12.e2k.ad.ge.com>
 <20191014190033.GA15552@linux.intel.com> <1571081397.3728.9.camel@HansenPartnership.com>
 <20191016110031.GE10184@linux.intel.com> <1571229252.3477.7.camel@HansenPartnership.com>
 <20191016162543.GB6279@linux.intel.com> <1571253029.17520.5.camel@HansenPartnership.com>
In-Reply-To: <1571253029.17520.5.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "Safford, David (GE Global Research, US)" <david.safford@ge.com>, Ken Goldman <kgold@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, 17 Oct 2019 at 00:40, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2019-10-16 at 19:25 +0300, Jarkko Sakkinen wrote:
> > On Wed, Oct 16, 2019 at 08:34:12AM -0400, James Bottomley wrote:
> > > reversible ciphers are generally frowned upon in random number
> > > generation, that's why the krng uses chacha20.  In general I think
> > > we shouldn't try to code our own mixing and instead should get the
> > > krng to do it for us using whatever the algorithm du jour that the
> > > crypto guys have blessed is.  That's why I proposed adding the TPM
> > > output to the krng as entropy input and then taking the output of
> > > the krng.
> >
> > It is already registered as hwrng. What else?
>
> It only contributes entropy once at start of OS.
>

Why not just configure quality parameter of TPM hwrng as follows? It
would automatically initiate a kthread during hwrng_init() to feed
entropy from TPM to kernel random numbers pool (see:
drivers/char/hw_random/core.c +142).

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 3d6d394..fcc3817 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -548,6 +548,7 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
                 "tpm-rng-%d", chip->dev_num);
        chip->hwrng.name = chip->hwrng_name;
        chip->hwrng.read = tpm_hwrng_read;
+       chip->hwrng.quality = 1024; /* Here we assume TPM provides
full entropy */
        return hwrng_register(&chip->hwrng);

 }

> >  Was the issue that it is only used as seed when the rng is init'd
> > first? I haven't at this point gone to the internals of krng.
>
> Basically it was similar to your xor patch except I got the kernel rng
> to do the mixing, so it would use the chacha20 cipher at the moment
> until they decide that's unsafe and change it to something else:
>
> https://lore.kernel.org/linux-crypto/1570227068.17537.4.camel@HansenPartnership.com/
>
> It uses add_hwgenerator_randomness() to do the mixing.  It also has an
> unmixed source so that read of the TPM hwrng device works as expected.

Above suggestion is something similar to yours but utilizing the
framework already provided via hwrng core.

-Sumit

>
> James
>
>
>
>
>
