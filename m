From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 02 Jul 2018 23:49:36 +0000
Subject: Re: [PATCH 01/11] nfit: adding support for Intel DSM 1.7 commands
Message-Id: <CAPcyv4hA39=Ub=01x6engjb8ObzRSxC+rHNMRFjMrLBv8yDFkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153057423804.38125.15912575101400055843.stgit@djiang5-desk3.ch.intel.com>
 <153057475267.38125.573190510224930543.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153057475267.38125.573190510224930543.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: David Howells <dhowells@redhat.com>, "Schofield, Alison  <alison.schofield@intel.com>, keyrings@vger.kernel.org, Kees Cook" <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>

On Mon, Jul 2, 2018 at 4:39 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> Adding command definition for security commands defined in Intel DSM
> specification v1.7. This includes "get security state", "set passphrase",
> "unlock unit", "freeze lock", "secure erase", "ovewrite", and
> "overwrite query". Since we are adding a lot of Intel definitions, moving
> the relevant bits to its own header. Also, we don't want those commands
> to be issued from user space through ioctls. Reason being some of the
> security commands require kernel involvement to flush all CPU caches that
> can't be done in userspace and the result can cause system crash. So
> blocking security commands in the ioctl path.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

Looks good, one nit.

[..]
> diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
> index 7d15856a739f..3b3f59828632 100644
> --- a/drivers/acpi/nfit/nfit.h
> +++ b/drivers/acpi/nfit/nfit.h
> @@ -20,6 +20,7 @@
>  #include <linux/types.h>
>  #include <linux/acpi.h>
>  #include <acpi/acuuid.h>
> +#include "intel.h"

Since nothing in nfit.h requires intel.h this include should move to
core.c directly.
