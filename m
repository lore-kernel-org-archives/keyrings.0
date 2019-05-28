From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Tue, 28 May 2019 19:09:55 +0000
Subject: Re: [PATCH v10 11/12] ima: Define ima-modsig template
Message-Id: <874l5e75vg.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190418035120.2354-1-bauerman@linux.ibm.com> <20190418035120.2354-12-bauerman@linux.ibm.com> <1557442889.10635.88.camel@linux.ibm.com>
In-Reply-To: <1557442889.10635.88.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>


Mimi Zohar <zohar@linux.ibm.com> writes:

> On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
>> Define new "d-modsig" template field which holds the digest that is
>> expected to match the one contained in the modsig, and also new "modsig"
>> template field which holds the appended file signature.
>>
>> Add a new "ima-modsig" defined template descriptor with the new fields as
>> well as the ones from the "ima-sig" descriptor.
>>
>> Change ima_store_measurement() to accept a struct modsig * argument so that
>> it can be passed along to the templates via struct ima_event_data.
>>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> Thanks, Roberto. Just some thoughts inline below.
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks!

>> +/*
>> + * Validating the appended signature included in the measurement list requires
>> + * the file hash calculated without the appended signature (i.e., the 'd-modsig'
>> + * field). Therefore, notify the user if they have the 'modsig' field but not
>> + * the 'd-modsig' field in the template.
>> + */
>> +static void check_current_template_modsig(void)
>> +{
>> +#define MSG "template with 'modsig' field also needs 'd-modsig' field\n"
>> +	struct ima_template_desc *template;
>> +	bool has_modsig, has_dmodsig;
>> +	static bool checked;
>> +	int i;
>> +
>> +	/* We only need to notify the user once. */
>> +	if (checked)
>> +		return;
>> +
>> +	has_modsig = has_dmodsig = false;
>> +	template = ima_template_desc_current();
>> +	for (i = 0; i < template->num_fields; i++) {
>> +		if (!strcmp(template->fields[i]->field_id, "modsig"))
>> +			has_modsig = true;
>> +		else if (!strcmp(template->fields[i]->field_id, "d-modsig"))
>> +			has_dmodsig = true;
>> +	}
>> +
>> +	if (has_modsig && !has_dmodsig)
>> +		pr_notice(MSG);
>> +
>> +	checked = true;
>> +#undef MSG
>> +}
>> +
>
> There was some recent discussion about supporting per IMA policy rule
> template formats. This feature will allow just the kexec kernel image
> to require ima-modsig. When per policy rule template formats support
> is upstreamed, this function will need to be updated.

Indeed. Thanks for the clarification. For the next iteration I rebased
on top of Matthew Garret's "IMA: Allow profiles to define the desired
IMA template" patch. I'm currently adapting this check accordingly.

>> @@ -389,3 +425,25 @@ int ima_eventsig_init(struct ima_event_data *event_data,
>>  	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
>>  					     DATA_FMT_HEX, field_data);
>>  }
>> +
>> +int ima_eventmodsig_init(struct ima_event_data *event_data,
>> +			 struct ima_field_data *field_data)
>> +{
>> +	const void *data;
>> +	u32 data_len;
>> +	int rc;
>> +
>> +	if (!event_data->modsig)
>> +		return 0;
>> +
>> +	/*
>> +	 * The xattr_value for IMA_MODSIG is a runtime structure containing
>> +	 * pointers. Get its raw data instead.
>> +	 */
>
> "xattr_value"? The comment needs some clarification.

Oops, forgot to update this comment. This is the new version:

	/*
	 * modsig is a runtime structure containing pointers. Get its raw data
	 * instead.
	 */

--
Thiago Jung Bauermann
IBM Linux Technology Center
