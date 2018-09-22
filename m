From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 22 Sep 2018 00:19:20 +0000
Subject: Re: [PATCH v8 02/12] libnvdimm: create keyring to store security keys
Message-Id: <CAPcyv4j02Ts5J8CFHFVVioBYjHwr7cbsqrz3yTCm4Yoxf1CTOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153549632073.4089.3609134467249378610.stgit@djiang5-desk3.ch.intel.com>
 <153549644916.4089.12258485183075906901.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153549644916.4089.12258485183075906901.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>, Kees Cook <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Eric Biggers <ebiggers3@gmail.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Tue, Aug 28, 2018 at 3:47 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Prepping the libnvdimm to support security management by adding a keyring
> in order to provide passphrase management through the kernel key management
> APIs.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/core.c      |    7 ++++++-
>  drivers/nvdimm/dimm_devs.c |   29 ++++++++++++++++++++++++++++-
>  drivers/nvdimm/nd-core.h   |    1 +
>  include/linux/libnvdimm.h  |    3 +++
>  kernel/cred.c              |    1 +
>  5 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
> index acce050856a8..3cd33d5c7cf0 100644
> --- a/drivers/nvdimm/core.c
> +++ b/drivers/nvdimm/core.c
> @@ -437,9 +437,12 @@ static __init int libnvdimm_init(void)
>  {
>         int rc;
>
> -       rc = nvdimm_bus_init();
> +       rc = nvdimm_devs_init();
>         if (rc)
>                 return rc;
> +       rc = nvdimm_bus_init();
> +       if (rc)
> +               goto err_bus;
>         rc = nvdimm_init();
>         if (rc)
>                 goto err_dimm;
> @@ -454,6 +457,8 @@ static __init int libnvdimm_init(void)
>         nvdimm_exit();
>   err_dimm:
>         nvdimm_bus_exit();
> + err_bus:
> +       nvdimm_devs_exit();
>         return rc;
>  }
>
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 8d348b22ba45..586432450c82 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -18,12 +18,15 @@
>  #include <linux/io.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
> +#include <linux/key.h>
> +#include <linux/init_task.h>
>  #include "nd-core.h"
>  #include "label.h"
>  #include "pmem.h"
>  #include "nd.h"
>
>  static DEFINE_IDA(dimm_ida);
> +static struct key *nvdimm_keyring;
>
>  /*
>   * Retrieve bus and dimm handle and return if this bus supports
> @@ -668,7 +671,31 @@ int nvdimm_bus_check_dimm_count(struct nvdimm_bus *nvdimm_bus, int dimm_count)
>  }
>  EXPORT_SYMBOL_GPL(nvdimm_bus_check_dimm_count);
>
> -void __exit nvdimm_devs_exit(void)
> +static int nvdimm_register_keyring(void)
>  {
> +       nvdimm_keyring = keyring_alloc(".nvdimm",
> +                       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, &init_cred,
[..]
> diff --git a/kernel/cred.c b/kernel/cred.c
> index ecf03657e71c..3a161b78a0a4 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -64,6 +64,7 @@ struct cred init_cred = {
>         .user_ns                = &init_user_ns,
>         .group_info             = &init_groups,
>  };
> +EXPORT_SYMBOL(init_cred);

I think you want to use prepare_kernel_cred(), not export init_cred.
