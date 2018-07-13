From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Jul 2018 23:34:14 +0000
Subject: Re: [PATCH v4 07/11] nfit/libnvdimm: add freeze security support to Intel nvdimm
Message-Id: <CAPcyv4iw0mPVvX2ijMGqyfxOqyecpGx7wfzHdaOkG6w5sSvX-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153142840572.27297.8070233763007198738.stgit@djiang5-desk3.ch.intel.com>
 <153142854714.27297.10145290341563367334.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153142854714.27297.10145290341563367334.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: David Howells <dhowells@redhat.com>, "Schofield, Alison  <alison.schofield@intel.com>, keyrings@vger.kernel.org, Kees Cook" <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>

On Thu, Jul 12, 2018 at 1:49 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> Add support for freeze security on Intel nvdimm. This locks out any
> changes to security for the DIMM unless a reboot is done. This is triggered
> by writing "freeze" to the "security" sysfs attribute. libnvdimm will
> support the generic freeze_lock API call.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/nfit/intel.c  |   51 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvdimm/dimm_devs.c |   22 +++++++++++++++++++
>  include/linux/libnvdimm.h  |    2 ++
>  3 files changed, 75 insertions(+)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
