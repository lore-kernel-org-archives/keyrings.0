From: Stuart Yoder <stuart.yoder@arm.com>
Date: Thu, 08 Aug 2019 22:26:58 +0000
Subject: Re: [Tee-dev] [RFC v2 2/6] tee: enable support to register kernel memory
Message-Id: <99777010-db74-096a-ce1a-da30539d6fb5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <1564489420-677-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1564489420-677-3-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: corbet@lwn.net, daniel.thompson@linaro.org, ard.biesheuvel@linaro.org, jejb@linux.ibm.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, tee-dev@lists.linaro.org, jarkko.sakkinen@linux.intel.com, dhowells@redhat.com, casey@schaufler-ca.com, linux-arm-kernel@lists.infradead.org, serge@hallyn.com



On 7/30/19 7:23 AM, Sumit Garg wrote:

> @@ -264,7 +266,17 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>   		goto err;
>   	}
>   
> -	rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
> +	if (flags & TEE_SHM_USER_MAPPED) {
> +		rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
> +					 shm->pages);
> +	} else {
> +		const struct kvec kiov = {
> +			.iov_base = (void *)start,
> +			.iov_len = PAGE_SIZE
> +		};
> +
> +		rc = get_kernel_pages(&kiov, num_pages, 0, shm->pages);

Passing a single kvec struct is temporary I assume?  Because as currently
written this will only work with num_pages=1.

Stuart
