From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 17 Sep 2019 18:15:07 +0000
Subject: Re: [Patch v6 4/4] KEYS: trusted: Move TPM2 trusted keys code
Message-Id: <20190917181507.GB8472@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1568630064-14887-1-git-send-email-sumit.garg@linaro.org>
 <1568630064-14887-5-git-send-email-sumit.garg@linaro.org>
 <20190917181415.GA8472@linux.intel.com>
In-Reply-To: <20190917181415.GA8472@linux.intel.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, jsnitsel@redhat.com, linux-kernel@vger.kernel.org, daniel.thompson@linaro.org

On Tue, Sep 17, 2019 at 09:14:15PM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 16, 2019 at 04:04:24PM +0530, Sumit Garg wrote:
> > Move TPM2 trusted keys code to trusted keys subsystem. The reason
> > being it's better to consolidate all the trusted keys code to a single
> > location so that it can be maintained sanely.
> > 
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> This commit has couple of issues that I only noticed when looking into
> bug reported by Mimi.
> 
> Right now tpm_send() is the exported function that is used by other
> subsystems. tpm_transmit_cmd() is an internal function. This commit adds
> two unrelated code paths to send TPM commands, which is unacceptable.
> 
> You should make tpm2 functionality to use tpm_send() instead and remove
> tpm_seal_trusted() and tpm_unseal_trusted() completely in this commit.

The consequence is that the result needs unfortunately re-review. Sorry
about that, just took this time to notice this glitch.

/Jarkko
