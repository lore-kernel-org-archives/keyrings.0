From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 09 Aug 2019 15:50:50 +0000
Subject: Re: [PATCH v3] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <20190809155050.5n7dbmabysdlra4m@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190805164427.17408-1-roberto.sassu@huawei.com>
In-Reply-To: <20190805164427.17408-1-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca, tyhicks@canonical.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On Mon, Aug 05, 2019 at 06:44:27PM +0200, Roberto Sassu wrote:
> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
> TPM") allows the trusted module to be loaded even if a TPM is not found, to
> avoid module dependency problems.
> 
> However, trusted module initialization can still fail if the TPM is
> inactive or deactivated. tpm_get_random() returns an error.
> 
> This patch removes the call to tpm_get_random() and instead extends the PCR
> specified by the user with zeros. The security of this alternative is
> equivalent to the previous one, as either option prevents with a PCR update
> unsealing and misuse of sealed data by a user space process.
> 
> Even if a PCR is extended with zeros, instead of random data, it is still
> computationally infeasible to find a value as input for a new PCR extend
> operation, to obtain again the PCR value that would allow unsealing.
> 
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>

OK so this has been now applied. I'm going to do a PR over
the weekend, which means that the fix will land to 5.3.

/Jarkko
