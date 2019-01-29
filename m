From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 29 Jan 2019 20:14:05 +0000
Subject: Re: [PATCH v8 4/7] tpm: retrieve digest size of unknown algorithms with PCR read
Message-Id: <20190129201405.GC11615@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-5-roberto.sassu@huawei.com>
In-Reply-To: <20190124154910.29948-5-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, silviu.vlasceanu@huawei.com

On Thu, Jan 24, 2019 at 04:49:07PM +0100, Roberto Sassu wrote:
> Currently, the TPM driver retrieves the digest size from a table mapping
> TPM algorithms identifiers to identifiers defined by the crypto subsystem.
> If the algorithm is not defined by the latter, the digest size can be
> retrieved from the output of the PCR read command.
> 
> The patch modifies the definition of tpm_pcr_read() and tpm2_pcr_read() to
> pass the desired hash algorithm and obtain the digest size at TPM startup.
> Algorithms and corresponding digest sizes are stored in the new structure
> tpm_bank_info, member of tpm_chip, so that the information can be used by
> other kernel subsystems.
> 
> tpm_bank_info contains: the TPM algorithm identifier, necessary to generate
> the event log as defined by Trusted Computing Group (TCG); the digest size,
> to pad/truncate a digest calculated with a different algorithm; the crypto
> subsystem identifier, to calculate the digest of event data.
> 
> This patch also protects against data corruption that could happen in the
> bus, by checking that the digest size returned by the TPM during a PCR read
> matches the size of the algorithm passed to tpm2_pcr_read().
> 
> For the initial PCR read, when digest sizes are not yet available, this
> patch ensures that the amount of data copied from the output returned by
> the TPM does not exceed the size of the array data are copied to.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
