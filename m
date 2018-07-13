From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Jul 2018 23:19:54 +0000
Subject: Re: [PATCH v4 04/11] nfit/libnvdimm: add unlock of nvdimm support for Intel DIMMs
Message-Id: <CAPcyv4jgx7LGJEYBCBYcne4r=-7OuJe60eCkxy6xObT4emnARw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153142840572.27297.8070233763007198738.stgit@djiang5-desk3.ch.intel.com>
 <153142853054.27297.9216630614864051441.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153142853054.27297.9216630614864051441.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: David Howells <dhowells@redhat.com>, "Schofield, Alison  <alison.schofield@intel.com>, keyrings@vger.kernel.org, Kees Cook" <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>

On Thu, Jul 12, 2018 at 1:48 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> Add support to allow query the security status of the Intel nvdimms and
> also unlock the dimm via the kernel key management APIs. The passphrase is
> expected to be pulled from userspace through keyutils. Moving the Intel
> related bits to its own source file as well.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/nfit/Makefile |    1
>  drivers/acpi/nfit/core.c   |    3 +
>  drivers/acpi/nfit/intel.c  |  151 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/nfit/intel.h  |   16 +++++
>  drivers/nvdimm/dimm.c      |    7 ++
>  drivers/nvdimm/dimm_devs.c |  108 +++++++++++++++++++++++++++++++
>  drivers/nvdimm/nd-core.h   |    2 +
>  drivers/nvdimm/nd.h        |    2 +
>  include/linux/libnvdimm.h  |   23 ++++++-
>  9 files changed, 310 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/acpi/nfit/intel.c

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
