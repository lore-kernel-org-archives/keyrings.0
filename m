From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 24 Sep 2018 21:15:33 +0000
Subject: Re: [PATCH v8 02/12] libnvdimm: create keyring to store security keys
Message-Id: <3239afcc-eb4a-22f5-f45c-74842124cf7a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153549644916.4089.12258485183075906901.stgit@djiang5-desk3.ch.intel.com>
 <153549632073.4089.3609134467249378610.stgit@djiang5-desk3.ch.intel.com>
 <29481.1537822932@warthog.procyon.org.uk>
In-Reply-To: <29481.1537822932@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, keyrings@vger.kernel.org

On 09/24/2018 02:02 PM, David Howells wrote:
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> +			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, &init_cred,
> 
> Hmmm...  I wonder if current_cred() would suffice since you must be called
> from something that has the ability to load modules.  Further, I wonder if
> module loading should be wrapped in an override with init_cred in the core.
> 
>> +			(KEY_USR_ALL & ~KEY_USR_SETATTR),
> 
> Did you really want to give the user write access, btw?

Hmmm....maybe I don't want user access at all since this is a kernel key
ring?

> 
> David
> 
