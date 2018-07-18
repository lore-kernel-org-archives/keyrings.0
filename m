From: Dave Jiang <dave.jiang@intel.com>
Date: Wed, 18 Jul 2018 20:47:32 +0000
Subject: Re: [PATCH v5 06/12] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <083e4bba-1c90-ebc6-8e6f-39a2fc3bebd5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <89742c32-e6f0-72d9-b1c8-140d67b57e9f@intel.com>
 <153186087803.27463.7423668214880824595.stgit@djiang5-desk3.ch.intel.com>
 <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
 <9360.1531912457@warthog.procyon.org.uk>
 <52ca4099-2816-4a42-9109-22b199975821@intel.com>
 <17731.1531946474@warthog.procyon.org.uk>
In-Reply-To: <17731.1531946474@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: alison.schofield@intel.com, keyrings@vger.kernel.org, keescook@chromium.org, linux-nvdimm@lists.01.org



On 07/18/2018 01:41 PM, David Howells wrote:
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> A thought occurred to me. For password update, would it make sense to do
>> this instead:
>> 1. get the existing key by: request_key("nvdimm:xxxxxxxx")
>> 2. get the new key by: request_key("nvdimm.update:xxxxxxxx")
>> 3. verify key with hardware
>> 	on success, copy new payload to existing key payload
>> 4. invalidate "nvdimm.update" key
>>
>> This way then we won't have to mess with needing the invalidated key to
>> be garbage collected. Thoughts?
> 
> Can you tell me at what points you actually access the key?

When we unlock the DIMM, disable security, update/enable passphrase, and
secure erase.

Unlock is called by the kernel during initialization of NVDIMMs.
The rest are triggered through a knob in sysfs. i.e. echo "erase" >
/sys/devices/..../nmem0/security
