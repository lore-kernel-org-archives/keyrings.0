From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Sep 2018 22:12:27 +0000
Subject: Re: [PATCH v11 00/12] Adding security support for nvdimm
Message-Id: <CAPcyv4hUk9v6+j811QYmOJvJ6MVXH-bF=ikXdMu8EpF9ppk=Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153817140052.17152.8594371908103118425.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153817140052.17152.8594371908103118425.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>, Kees Cook <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Eric Biggers <ebiggers3@gmail.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Fri, Sep 28, 2018 at 2:58 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> The following series implements security support for nvdimm. Mostly adding
> new security DSM support from the Intel NVDIMM DSM spec v1.7, but also
> adding generic support libnvdimm for other vendors. The most important
> security features are unlocking locked nvdimms, and updating/setting security
> passphrase to nvdimms.
>
> v11:
> - Dropped keyring usage. (David)
> - Fixed up scanf handling. (David)
> - Removed callout info for request_key(). (David)
> - Included Dan's patches and folded in some changes from Dan. (Dan)
> - Made security_show a weak function to allow test override. (Dan)

Looks good.

> Dan Williams (2):
>       libnvdimm: Drop nvdimm_bus from security_ops interface
>       acpi, nfit: Move acpi_nfit_get_security_ops() to generic location

I'll fold these into the other patches, no need to commit the cleanups
separately at this point.
