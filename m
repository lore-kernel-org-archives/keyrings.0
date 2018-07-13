From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Jul 2018 23:55:48 +0000
Subject: Re: [PATCH v4 10/11] nfit_test: add test support for Intel nvdimm security DSMs
Message-Id: <CAPcyv4jzZ9Gi=MZxmYD08vpJYKKrwBHWwZQqa=VJfzQfSksH2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153142840572.27297.8070233763007198738.stgit@djiang5-desk3.ch.intel.com>
 <153142856380.27297.8637660094319867960.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153142856380.27297.8637660094319867960.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: David Howells <dhowells@redhat.com>, "Schofield, Alison  <alison.schofield@intel.com>, keyrings@vger.kernel.org, Kees Cook" <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>

On Thu, Jul 12, 2018 at 1:49 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> Add nfit_test support for DSM functions "Get Security State",
> "Set Passphrase", "Disable Passphrase", "Unlock Unit", "Freeze Lock",
> and "Secure Erase" for the fake DIMMs.
>
> Also adding a sysfs knob in order to put the DIMMs in "locked" state. The
> order of testing DIMM unlocking would be.
> 1a. Set Passphrase to DIMM X.
> 1b. Disable DIMM X.
> 2. Write to
> /sys/devices/platform/nfit_test.0/nfit_test_dimm/test_dimmX/lock_dimm
> 3. Renable DIMM X
> 4. Check DIMM X state via sysfs "security" attribute for nmemX.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/nvdimm/Kbuild      |    1
>  tools/testing/nvdimm/test/nfit.c |  186 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 187 insertions(+)

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
