From: Dave Jiang <dave.jiang@intel.com>
Date: Wed, 18 Jul 2018 19:47:12 +0000
Subject: Re: [PATCH v5 06/12] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <89742c32-e6f0-72d9-b1c8-140d67b57e9f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153186087803.27463.7423668214880824595.stgit@djiang5-desk3.ch.intel.com>
 <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
 <9360.1531912457@warthog.procyon.org.uk>
 <52ca4099-2816-4a42-9109-22b199975821@intel.com>
In-Reply-To: <52ca4099-2816-4a42-9109-22b199975821@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: alison.schofield@intel.com, keyrings@vger.kernel.org, keescook@chromium.org, linux-nvdimm@lists.01.org



On 07/18/2018 09:05 AM, Dave Jiang wrote:
> 
> 
> On 07/18/2018 04:14 AM, David Howells wrote:
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> Add support for setting and/or updating passphrase on the Intel nvdimms.
>>> The passphrase is pulled from userspace through the kernel key management.
>>> We trigger the update via writing "update" to the sysfs attribute
>>> "security". The state of the security can also be read via the "security"
>>> attribute. libnvdimm will generically support the key_change API call.
>>
>> Btw, could you use a logon-type key rather than spinning your own?  Do you
>> specifically not want it to be updateable?
> 
> Thanks for reviewing this David. I'll take a look and see if I can.
> Basically the code is acting as the proxy for the hardware and passing
> through the passphrase. What would be the best way to update the
> passphrase if I need to retrieve the new passphrase from the userspace?
> The hardware still needs the old passphrase in order to verify. There
> has to be a nice way to do this but I'm not familiar with key management
> API to know better.

A thought occurred to me. For password update, would it make sense to do
this instead:
1. get the existing key by: request_key("nvdimm:xxxxxxxx")
2. get the new key by: request_key("nvdimm.update:xxxxxxxx")
3. verify key with hardware
	on success, copy new payload to existing key payload
4. invalidate "nvdimm.update" key

This way then we won't have to mess with needing the invalidated key to
be garbage collected. Thoughts?


> 
>>
>>> +static int intel_dimm_security_update_passphrase(
>>> +		struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
>>> +		struct nvdimm_key_data *old_data,
>>> +		struct nvdimm_key_data *new_data)
>>
>> You might want to mark old_data and new_data as const here.  At least, they
>> don't appear to be changed.  Also, can you stick a banner comment on the
>> function to say what it actually does?  Is it changing the key stored in h/w
>> or is it meant to be changing what's stored in the key payload?
>>
>>> +	/* request new key from userspace */
>>> +	key = nvdimm_request_key(dev);
>>> +	if (!key) {
>>> +		dev_dbg(dev, "%s: failed to acquire new key\n", __func__);
>>> +		return -ENXIO;
>>> +	}
>>> +
>>> +	dev_dbg(dev, "%s: new key: %#x\n", __func__, key->serial);
>>> +
>>> +	if (key->datalen = NVDIMM_PASSPHRASE_LEN) {
>>> +		old_data = NULL;
>>> +		new_data = key->payload.data[0];
>>> +	} else if (key->datalen = (NVDIMM_PASSPHRASE_LEN * 2)) {
>>> +		new_data = key->payload.data[0];
>>> +		old_data = new_data + NVDIMM_PASSPHRASE_LEN;
>>> +	} else {
>>> +		key_invalidate(key);
>>> +		key_put(key);
>>> +		dev_warn(dev, "Incorrect key payload size for update: %u\n",
>>> +				key->datalen);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	down_read(&key->sem);
>>> +	rc = nvdimm->security_ops->change_key(nvdimm_bus, nvdimm, old_data,
>>> +			new_data);
>>
>> Why do you need to get a read lock on key->sem and not a write-lock?
>>
>>> +	if (rc = 0 && key->datalen = (NVDIMM_PASSPHRASE_LEN * 2))
>>> +		memcpy(old_data, new_data, NVDIMM_PASSPHRASE_LEN);
>>
>> You appear to be changing the key content here.  If that's the case, don't you
>> need to write-lock key->sem?
>>
>>> +	up_read(&key->sem);
>>
>> David
>>
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
> 
