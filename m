From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 04 Dec 2018 09:21:45 +0000
Subject: Re: [RFC v2 11/13] keys/mktme: Program memory encryption keys on a system wide basis
Message-Id: <20181204092145.GR11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Mon, Dec 03, 2018 at 11:39:58PM -0800, Alison Schofield wrote:

> +struct mktme_hw_program_info {
> +	struct mktme_key_program *key_program;
> +	unsigned long status;
> +};
> +
> +/* Program a KeyID on a single package. */
> +static void mktme_program_package(void *hw_program_info)
> +{
> +	struct mktme_hw_program_info *info = hw_program_info;
> +	int ret;
> +
> +	ret = mktme_key_program(info->key_program);
> +	if (ret != MKTME_PROG_SUCCESS)
> +		WRITE_ONCE(info->status, ret);

What's the purpose of that WRITE_ONCE()?

> +}
> +
> +/* Program a KeyID across the entire system. */
> +static int mktme_program_system(struct mktme_key_program *key_program,
> +				cpumask_var_t mktme_cpumask)
> +{
> +	struct mktme_hw_program_info info = {
> +		.key_program = key_program,
> +		.status = MKTME_PROG_SUCCESS,
> +	};
> +	get_online_cpus();
> +	on_each_cpu_mask(mktme_cpumask, mktme_program_package, &info, 1);
> +	put_online_cpus();
> +
> +	return info.status;
> +}
> +
>  /* Copy the payload to the HW programming structure and program this KeyID */
>  static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
>  {
> @@ -84,7 +116,7 @@ static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
>  			kprog->key_field_2[i] ^= kern_entropy[i];
>  		}
>  	}
> -	ret = mktme_key_program(kprog);
> +	ret = mktme_program_system(kprog, mktme_leadcpus);
>  	kmem_cache_free(mktme_prog_cache, kprog);
>  	return ret;
>  }
> @@ -299,6 +331,28 @@ struct key_type key_type_mktme = {
>  	.destroy	= mktme_destroy_key,
>  };
>  
> +static int mktme_build_leadcpus_mask(void)
> +{
> +	int online_cpu, mktme_cpu;
> +	int online_pkgid, mktme_pkgid = -1;
> +
> +	if (!zalloc_cpumask_var(&mktme_leadcpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	for_each_online_cpu(online_cpu) {
> +		online_pkgid = topology_physical_package_id(online_cpu);
> +
> +		for_each_cpu(mktme_cpu, mktme_leadcpus) {
> +			mktme_pkgid = topology_physical_package_id(mktme_cpu);
> +			if (mktme_pkgid = online_pkgid)
> +				break;
> +		}
> +		if (mktme_pkgid != online_pkgid)
> +			cpumask_set_cpu(online_cpu, mktme_leadcpus);

Do you really need LOCK prefixed bit set here?

> +	}
> +	return 0;
> +}

How is that serialized and kept relevant in the face of hotplug?

Also, do you really need O(n^2) to find the first occurence of a value
in an array?
