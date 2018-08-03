From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 03 Aug 2018 16:07:49 +0000
Subject: Re: [PATCH v6 05/11] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <417cc448-c147-f7e9-0895-01988d228ac3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <00b10de9-1349-491c-8277-8d71536dd1a6@intel.com>
 <153255233932.51274.17371670672074459834.stgit@djiang5-desk3.ch.intel.com>
 <153255001863.51274.11308713958786222873.stgit@djiang5-desk3.ch.intel.com>
 <20101.1533211253@warthog.procyon.org.uk>
 <465ca753-ad2c-6888-b139-8cb9c4472290@intel.com>
 <25304.1533285169@warthog.procyon.org.uk>
In-Reply-To: <25304.1533285169@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, keyrings@vger.kernel.org



On 08/03/2018 01:32 AM, David Howells wrote:
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> I think I'm a little confused on what to do once I pass in the new key
>> id through update. How do I retrieve the new key in kernel that I added
>> from userspace and not use key_lookup()? request_key() or something
>> else? Wouldn't request_key come up with the old key since it has the
>> same description?
> 
> As I keep saying, you need to use lookup_user_key():
> 
> 	key = lookup_user_key(keyid, 0, KEY_NEED_SEARCH);
> 
> You need to add it to linux/key.h and export it.

Thanks! I got confused with key_user_lookup() and got stuck there.
