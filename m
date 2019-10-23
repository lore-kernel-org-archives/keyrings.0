From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 23 Oct 2019 13:21:24 +0000
Subject: Re: [PATCH v1 2/6] KEYS: ima: Refactored process_buffer_measurement function so that it can measure 
Message-Id: <1571836884.5104.94.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
         <20191023001818.3684-3-nramas@linux.microsoft.com>
In-Reply-To: <20191023001818.3684-3-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Tue, 2019-10-22 at 17:18 -0700, Lakshmi Ramasubramanian wrote:

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 584019728660..8e965d18fb21 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -610,14 +610,14 @@ int ima_load_data(enum kernel_load_data_id id)
>   * @buf: pointer to the buffer that needs to be added to the log.
>   * @size: size of buffer(in bytes).
>   * @eventname: event name to be used for the buffer entry.
> - * @cred: a pointer to a credentials structure for user validation.
> - * @secid: the secid of the task to be validated.
> + * @pcr: pcr to extend the measurement
> + * @template_desc: template description
>   *
>   * Based on policy, the buffer is measured into the ima log.
>   */
> -static void process_buffer_measurement(const void *buf, int size,
> -				       const char *eventname,
> -				       const struct cred *cred, u32 secid)
> +void process_buffer_measurement(const void *buf, int size,
> +				const char *eventname, int pcr,
> +				struct ima_template_desc *template_desc)
>  {
>  	int ret = 0;
>  	struct ima_template_entry *entry = NULL;
> @@ -626,19 +626,11 @@ static void process_buffer_measurement(const void *buf, int size,
>  					    .filename = eventname,
>  					    .buf = buf,
>  					    .buf_len = size};
> -	struct ima_template_desc *template_desc = NULL;
>  	struct {
>  		struct ima_digest_data hdr;
>  		char digest[IMA_MAX_DIGEST_SIZE];
>  	} hash = {};
>  	int violation = 0;
> -	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> -	int action = 0;
> -
> -	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
> -				&template_desc);
> -	if (!(action & IMA_MEASURE))
> -		return;
>  
>  	iint.ima_hash = &hash.hdr;
>  	iint.ima_hash->algo = ima_hash_algo;


This patch is based on Nayna's version of this change, without any
acknowledgment.  Moving this code out of process_buffer_measurement is
going to result in code duplication.  Nayna has posted a newer version
of this patch without the code duplication.  As soon as she posts the
patch with an updated patch description, I plan on picking up that
version.

Mimi


> @@ -670,12 +662,19 @@ static void process_buffer_measurement(const void *buf, int size,
>   */
>  void ima_kexec_cmdline(const void *buf, int size)
>  {
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +	struct ima_template_desc *template_desc = ima_template_desc_current();
> +	int action;
>  	u32 secid;
>  
>  	if (buf && size != 0) {
>  		security_task_getsecid(current, &secid);
> -		process_buffer_measurement(buf, size, "kexec-cmdline",
> -					   current_cred(), secid);
> +		action = ima_get_action(NULL, current_cred(), secid, 0,
> +					KEXEC_CMDLINE, &pcr, &template_desc);
> +		if (!(action & IMA_MEASURE))
> +			return;
> +		process_buffer_measurement(buf, size, "kexec-cmdline", pcr,
> +					   template_desc);
>  	}
>  }
>  
