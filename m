From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 03 Aug 2018 00:28:32 +0000
Subject: Re: [PATCH v6 05/11] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <00b10de9-1349-491c-8277-8d71536dd1a6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153255233932.51274.17371670672074459834.stgit@djiang5-desk3.ch.intel.com>
 <153255001863.51274.11308713958786222873.stgit@djiang5-desk3.ch.intel.com>
 <20101.1533211253@warthog.procyon.org.uk>
 <465ca753-ad2c-6888-b139-8cb9c4472290@intel.com>
In-Reply-To: <465ca753-ad2c-6888-b139-8cb9c4472290@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, keyrings@vger.kernel.org

On 08/02/2018 03:29 PM, Dave Jiang wrote:
> 
> 
> On 08/02/2018 05:00 AM, David Howells wrote:
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> +	/* request new key from userspace */
>>> +	key = nvdimm_request_key(dev, update);
>>> +	if (!key) {
>>> +		dev_dbg(dev, "%s: failed to acquire new key\n", __func__);
>>> +		rc = -ENXIO;
>>> +		goto out;
>>> +	}
>>
>> I still think you're better taking two explicit key IDs as part of the command
>> rather than using request_key() to *hopefully* pick the right target.
> 
> In order to do this, I would need to do a key_add() in userspace to add
> a new key with the new payload before I can initiate update correct? So
> for an update it would look something like:
> 1. (user) add key with new payload
> 2. (user) lookup old key
> 3. (user) write to sysfs update attrib: "update:<old id>:<new id>"
> 4. (kernel) check old_id against cached key and make sure they match
> 5. (kernel) check new key desc against old key and make sure they match
> 6. (kernel) update to hardware
> 6. (kernel) when success, link the new key to the kernel keyring and
> it'll replace the old key?

I think I'm a little confused on what to do once I pass in the new key
id through update. How do I retrieve the new key in kernel that I added
from userspace and not use key_lookup()? request_key() or something
else? Wouldn't request_key come up with the old key since it has the
same description?


