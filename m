From: Dave Jiang <dave.jiang@intel.com>
Date: Wed, 18 Jul 2018 19:40:48 +0000
Subject: Re: [PATCH v5 02/12] libnvdimm: create keyring to store security keys
Message-Id: <a3bce7ee-96b0-bafc-3194-52b4fcc08f84@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153186085546.27463.5501870662513432986.stgit@djiang5-desk3.ch.intel.com>
 <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
 <7121.1531911057@warthog.procyon.org.uk>
In-Reply-To: <7121.1531911057@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-nvdimm@lists.01.org, keyrings@vger.kernel.org, alison.schofield@intel.com, keescook@chromium.org



On 07/18/2018 03:50 AM, David Howells wrote:
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> +static int nvdimm_key_instantiate(struct key *key,
>> +		struct key_preparsed_payload *prep)
> 
> Please use ->preparse() if you can rather than doing this in ->instantiate().
> Ideally ->instantiate() should not return an error, particularly not -EINVAL
> or -ENOMEM.
> 
>> +{
>> +	char *payload;
>> +
>> +	payload = kzalloc(nvdimm_key_type.def_datalen, GFP_KERNEL);
>> +	if (!payload)
>> +		return -ENOMEM;
> 
> Ummm...  Why not just kmemdup()?  Why not use use prep->datalen here rather
> than def_datalen?
> 
>> +
>> +	key->datalen = min(nvdimm_key_type.def_datalen, prep->datalen);
>> +	memcpy(payload, prep->data, key->datalen);
>> +	key->payload.data[0] = payload;
>> +	return 0;
>> +}
> 
> I would recommend, firstly, that you use generic_key_instantiate() if you can;
> if not, you might want to use rcu_assign_keypointer().
> 
>> +	cred = prepare_kernel_cred(NULL);
>> +	if (!cred) {
>> +		rc = -ENOMEM;
>> +		goto failed_cred;
>> +	}
> 
> I wonder if you could just use &init_cred instead.

You mean also instead of a dedicated keyring, just use the existing ones
that comes with init_cred as well?

> 
> David
> 
