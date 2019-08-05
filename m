From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 05 Aug 2019 20:59:15 +0000
Subject: Re: [RFC/RFT v2 1/2] KEYS: trusted: create trusted keys subsystem
Message-Id: <20190805205915.k5enrfob2cocqyff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
 <1563449086-13183-2-git-send-email-sumit.garg@linaro.org>
 <20190801172310.cldcftfdoh5vyfjg@linux.intel.com>
 <CAFA6WYM+FQuXA9Saj5+ffOGsc-shhiF5Uos4g14Qndvu6w97Sg@mail.gmail.com>
 <20190802193802.jn56jhoz5crebggt@linux.intel.com>
 <CAFA6WYOMXc2y=vXOwRv+PYyF8oBV70G7CrJ81jvD5yJT41zLZw@mail.gmail.com>
In-Reply-To: <CAFA6WYOMXc2y=vXOwRv+PYyF8oBV70G7CrJ81jvD5yJT41zLZw@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Mon, Aug 05, 2019 at 10:32:59AM +0530, Sumit Garg wrote:
> Okay, I will try to move TPM2 trusted keys code also.

I'm definitely for extending trusted keys beyond TPMs. Before that can be
done, however, the current mess needs to be cleaned up.

I did a lot of work recently [1] to clean up TPM transmit code to better
suited to be used outside of the TPM drivers (remove recursive calls,
put the whole stack use tpm_buf for everything).

What still needs to be done is to move tpm_buf stuff to include/linux in
order to be usable in the keyring code. Also for TPM 2.0 trusted keys,
TPM2 constants need to be moved to include/linux. For the latter, I'd
suggest to move all protocol constants there and not just what is
required for trusted keys. Better to have them in one place.

[1] https://lkml.org/lkml/2019/2/13/176

/Jarkko
