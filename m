From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 14 Jun 2019 05:55:38 +0000
Subject: Re: [RFC 4/7] KEYS: trusted: Introduce TEE based Trusted Keys
Message-Id: <CAFA6WYOe19cOSNUdWvwg-FaXeU5_cev=OpsFYJp020bUrxWxow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-5-git-send-email-sumit.garg@linaro.org> <20190613153202.GF18488@linux.intel.com>
In-Reply-To: <20190613153202.GF18488@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tee-dev@lists.linaro.org

On Thu, 13 Jun 2019 at 21:02, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 04:00:30PM +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key.
> >
> > Refer to Documentation/tee.txt for detailed information about TEE.
> >
> > Approach taken in this patch acts as an alternative to a TPM device in case
> > platform doesn't possess one.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> How does this interact with the trusted module? Why there is no update
> to security/keys/trusted-encrypted.txt?
>

You already found documentation patch [1].

> Somehow the existing trusted module needs to be re-architected to work
> with either. Otherwise, this will turn out to be a mess.
>

See my reply on this patch [1].

[1] [RFC 6/7] doc: keys: Document usage of TEE based Trusted Keys

-Sumit

> /Jarkko
