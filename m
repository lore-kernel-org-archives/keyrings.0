From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 29 Jan 2019 19:37:38 +0000
Subject: Re: [PATCH v8 2/7] tpm: add _head suffix to tcg_efi_specid_event and tcg_pcr_event2
Message-Id: <20190129193738.GB11615@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-3-roberto.sassu@huawei.com>
In-Reply-To: <20190124154910.29948-3-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, silviu.vlasceanu@huawei.com

On Thu, Jan 24, 2019 at 04:49:05PM +0100, Roberto Sassu wrote:
> TCG defines two structures, TCG_EfiSpecIDEventStruct and TCG_PCR_EVENT2,
> which contain variable-sized arrays in the middle of the definition.
> 
> Since these structures are not suitable for type casting, this patch
> removes structure members after the variable-sized arrays and adds the
> _head suffix to the structure name, to indicate that the renamed structures
> do not contain all fields defined by TCG.
> 
> Lastly, given that variable-sized arrays are now in the last position, and
> given that the size of the arrays cannot be determined in advance, this
> patch also sets the size of those arrays to zero and removes the definition
> of TPM2_ACTIVE_PCR_BANKS.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Nayna Jain <nayna@linux.ibm.com>

OK, I applied this to my tree. Does not make to sense to hold this.

Thank you.

/Jarkko
