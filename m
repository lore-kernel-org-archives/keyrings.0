From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Jul 2018 23:05:49 +0000
Subject: Re: [PATCH v4 02/11] libnvdimm: create keyring to store security keys
Message-Id: <CAPcyv4i=N+4Rx3zKOYxrwjPXeKfp5NCT+E+sY8NxGoUVJ83Dgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153142840572.27297.8070233763007198738.stgit@djiang5-desk3.ch.intel.com>
 <153142851854.27297.8356860633862959932.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153142851854.27297.8356860633862959932.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: David Howells <dhowells@redhat.com>, "Schofield, Alison  <alison.schofield@intel.com>, keyrings@vger.kernel.org, Kees Cook" <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>

On Thu, Jul 12, 2018 at 1:48 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> Prepping the libnvdimm to support security management by adding a keyring
> in order to provide passphrase management through the kernel key management
> APIs.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/nvdimm/core.c      |    7 +++
>  drivers/nvdimm/dimm_devs.c |   96 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvdimm/nd-core.h   |    1
>  include/linux/libnvdimm.h  |    5 ++
>  4 files changed, 107 insertions(+), 2 deletions(-)
>

Looks good to me,

You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
