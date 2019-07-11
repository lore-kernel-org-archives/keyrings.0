From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 11 Jul 2019 19:48:11 +0000
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
In-Reply-To: <20190705163735.11539-1-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, tyhicks@canonical.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On Fri, Jul 05, 2019 at 06:37:35PM +0200, Roberto Sassu wrote:
> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
> TPM") allows the trusted module to be loaded even a TPM is not found to
> avoid module dependency problems.
> 
> Unfortunately, this does not completely solve the issue, as there could be
> a case where a TPM is found but is not functional (the TPM commands return
> an error). Specifically, after the tpm_chip structure is returned by
> tpm_default_chip() in init_trusted(), the execution terminates after
> init_digests() returns -EFAULT (due to the fact that tpm_get_random()
> returns a positive value, but less than TPM_MAX_DIGEST_SIZE).
> 
> This patch fixes the issue by ignoring the TPM_ERR_DEACTIVATED and
> TPM_ERR_DISABLED errors.

Why allow trusted module to initialize if TPM is not functional?

Also:

err = tpm_transmit_cmd(chip, &buf,
		       offsetof(struct tpm2_get_random_out,
				buffer),
		       "attempting get random");
if (err) {
	if (err > 0)
		err = -EIO;
	goto out;
}

/Jarkko
