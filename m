From: David Howells <dhowells@redhat.com>
Date: Mon, 24 Sep 2018 21:02:12 +0000
Subject: Re: [PATCH v8 02/12] libnvdimm: create keyring to store security keys
Message-Id: <29481.1537822932@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153549644916.4089.12258485183075906901.stgit@djiang5-desk3.ch.intel.com>
 <153549632073.4089.3609134467249378610.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153549644916.4089.12258485183075906901.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, &init_cred,

Hmmm...  I wonder if current_cred() would suffice since you must be called
from something that has the ability to load modules.  Further, I wonder if
module loading should be wrapped in an override with init_cred in the core.

> +			(KEY_USR_ALL & ~KEY_USR_SETATTR),

Did you really want to give the user write access, btw?

David
