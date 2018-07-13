From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Jul 2018 23:29:29 +0000
Subject: Re: [PATCH v4 06/11] nfit/libnvdimm: add disable passphrase support to Intel nvdimm.
Message-Id: <CAPcyv4htT0VLdNYARu4ikCrGgi-7wpBkUCEK=YkiZo-bp2RB4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153142840572.27297.8070233763007198738.stgit@djiang5-desk3.ch.intel.com>
 <153142854151.27297.13334610782251992543.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153142854151.27297.13334610782251992543.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: David Howells <dhowells@redhat.com>, "Schofield, Alison  <alison.schofield@intel.com>, keyrings@vger.kernel.org, Kees Cook" <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>

On Thu, Jul 12, 2018 at 1:49 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> Add support to disable passphrase (security) for the Intel nvdimm. The
> passphrase used for disabling is pulled from userspace via the kernel
> key management. The action is triggered by writing "disable" to the sysfs
> attribute "security". libnvdimm will support the generic disable API call.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/nfit/intel.c  |   52 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvdimm/dimm_devs.c |   41 +++++++++++++++++++++++++++++++++++
>  include/linux/libnvdimm.h  |    2 ++
>  3 files changed, 95 insertions(+)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
