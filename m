From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Jul 2018 20:41:14 +0000
Subject: Re: [PATCH v5 06/12] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <17731.1531946474@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <89742c32-e6f0-72d9-b1c8-140d67b57e9f@intel.com>
 <153186087803.27463.7423668214880824595.stgit@djiang5-desk3.ch.intel.com>
 <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
 <9360.1531912457@warthog.procyon.org.uk>
 <52ca4099-2816-4a42-9109-22b199975821@intel.com>
In-Reply-To: <89742c32-e6f0-72d9-b1c8-140d67b57e9f@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dhowells@redhat.com, alison.schofield@intel.com, keyrings@vger.kernel.org, keescook@chromium.org, linux-nvdimm@lists.01.org

Dave Jiang <dave.jiang@intel.com> wrote:

> A thought occurred to me. For password update, would it make sense to do
> this instead:
> 1. get the existing key by: request_key("nvdimm:xxxxxxxx")
> 2. get the new key by: request_key("nvdimm.update:xxxxxxxx")
> 3. verify key with hardware
> 	on success, copy new payload to existing key payload
> 4. invalidate "nvdimm.update" key
> 
> This way then we won't have to mess with needing the invalidated key to
> be garbage collected. Thoughts?

Can you tell me at what points you actually access the key?

David
