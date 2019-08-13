From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 13 Aug 2019 07:59:40 +0000
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
Message-Id: <CAFA6WYNqBH9aAM-uke6jFTCeLB2GG7UYyrYEPHgyVy8p_q+Pww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org> <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
 <CAFA6WYN-6MpP2TZQEz49BmjSQiMSqghVFWRZCCY0o1UVad1AFw@mail.gmail.com> <20190808151500.ypfcqowklalu76uq@linux.intel.com>
In-Reply-To: <20190808151500.ypfcqowklalu76uq@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Thu, 8 Aug 2019 at 20:46, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Aug 08, 2019 at 06:51:38PM +0530, Sumit Garg wrote:
> > It seems to be a functional change which I think requires proper unit
> > testing. I am afraid that I don't posses a TPM device to test this and
> > also very less conversant with tpm_buf code.
> >
> > So what I have done here is to rename existing TPM 1.x trusted keys
> > code to use tpm1_buf.
> >
> > And I would be happy to integrate a tested patch if anyone familiar
> > could work on this.
>
> I can test it on TPM 1.2.
>

I have posted v4 with changes as you requested. I hope they work well
with a real TPM 1.x or TPM 2.0 device.

-Sumit

> /Jarkko
