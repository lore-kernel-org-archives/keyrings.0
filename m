From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Jul 2018 23:54:54 +0000
Subject: Re: [PATCH v4 09/11] nfit_test: add context to dimm_dev for nfit_test
Message-Id: <CAPcyv4hFBir+xwj-2czQD0ZSbWcQEGVbg_AGaYt7-v8Q_aLP3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153142840572.27297.8070233763007198738.stgit@djiang5-desk3.ch.intel.com>
 <153142855815.27297.740336926832022321.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153142855815.27297.740336926832022321.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: David Howells <dhowells@redhat.com>, "Schofield, Alison  <alison.schofield@intel.com>, keyrings@vger.kernel.org, Kees Cook" <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>

On Thu, Jul 12, 2018 at 1:49 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> In order to access the nfit_test context via sideband sysfs knobs, the
> dimm_dev needs to be more than struct device in order to point back to
> struct nfit_test. Wrapping the original struct device with a struct
> nfit_dimm_dev and saving the nfit_test as private driver data. Also
> changing the nfit_mem to be a member of struct nfit_dimm_dev instead of
> saving as private driver data of that device. This is in preparation for
> adding security DSM support and allowing the locking of DIMMs for testing
> via sideband.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/nvdimm/test/nfit.c |   41 +++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 14 deletions(-)

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
