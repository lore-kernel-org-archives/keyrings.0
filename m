From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Fri, 18 Oct 2019 07:32:23 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <CAE=NcrbSrqNUF_Jhe4cL=BSmY=p45nS8axkSJC6HWeGo2NnXDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A22E@ALPMBAPA12.e2k.ad.ge.com>
 <20191004182711.GC6945@linux.intel.com> <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com>
 <20191007000520.GA17116@linux.intel.com> <59b88042-9c56-c891-f75e-7c0719eb5ff9@linux.ibm.com>
 <20191008234935.GA13926@linux.intel.com> <20191008235339.GB13926@linux.intel.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2B995@ALPMBAPA12.e2k.ad.ge.com>
 <20191014190033.GA15552@linux.intel.com> <1571081397.3728.9.camel@HansenPartnership.com>
 <20191016110031.GE10184@linux.intel.com> <1571229252.3477.7.camel@HansenPartnership.com>
In-Reply-To: <1571229252.3477.7.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "Safford, David (GE Global Research, US)" <david.safford@ge.com>, Ken Goldman <kgold@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wed, Oct 16, 2019 at 6:35 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> > The documentation says that krng is suitable for key generation.
> > Should the documentation changed to state that it is unsuitable?
>
> How do you get that from the argument above?  The krng is about the
> best we have in terms of unpredictable key generation, so of course it
> is suitable ... provided you give the entropy enough time to have
> sufficient entropy.

Yes, so it can be both the safest and the least safe option available.
By default it's the worst one, but use it wisely and it can be the
best source. Hence I was proposing that kconfig option + boot time
printout to make this clear for everyone..


--
Janne
