From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 03 Jul 2018 01:04:54 +0000
Subject: Re: [PATCH 03/11] nfit/libnvdimm: store dimm id as a member to struct nvdimm
Message-Id: <CAPcyv4i9H6NWd_0gS1ix-aiKq5vmrZ8f2wQLTyyi8AJJ=g6tDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153057423804.38125.15912575101400055843.stgit@djiang5-desk3.ch.intel.com>
 <153057476366.38125.8727725325138198236.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153057476366.38125.8727725325138198236.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: David Howells <dhowells@redhat.com>, "Schofield, Alison  <alison.schofield@intel.com>, keyrings@vger.kernel.org, Kees Cook" <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>

On Mon, Jul 2, 2018 at 4:39 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> The generated dimm id is needed for the sysfs attribute as well as being
> used as the identifier/description for the security key. Since it's
> constant and should never change, store it as a member of struct nvdimm.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/nfit/core.c   |   33 ++++++++++++++++++++++-----------
>  drivers/nvdimm/dimm_devs.c |    4 +++-
>  drivers/nvdimm/nd-core.h   |    1 +
>  include/linux/libnvdimm.h  |    2 +-
>  4 files changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 70351b610b3d..a6fb336da79d 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
[..]
> +static int acpi_nfit_get_dimm_id(struct acpi_nfit_control_region *dcr,
> +               char *buf)
> +{
> +       if (dcr->valid_fields & ACPI_NFIT_CONTROL_MFG_INFO_VALID)
> +               return sprintf(buf, "%04x-%02x-%04x-%08x",
> +                               be16_to_cpu(dcr->vendor_id),
> +                               dcr->manufacturing_location,
> +                               be16_to_cpu(dcr->manufacturing_date),
> +                               be32_to_cpu(dcr->serial_number));
> +       else
> +               return sprintf(buf, "%04x-%08x",
> +                               be16_to_cpu(dcr->vendor_id),
> +                               be32_to_cpu(dcr->serial_number));
> +}

Let's just add a 24-byte string to 'struct nfit_mem' to house the id.
It's static data, so no need to do another sprintf() once it is
initialized.
