From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Sep 2018 00:33:07 +0000
Subject: Re: [PATCH v9 05/12] nfit/libnvdimm: add unlock of nvdimm support for Intel DIMMs
Message-Id: <CAPcyv4jH3WyZtnEBQiKy48NtwmG001N-=Qf2iD5LOcM345mawA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153791805740.70158.12896535066689316343.stgit@djiang5-desk3.ch.intel.com>
 <153791869334.70158.4241586057931564295.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153791869334.70158.4241586057931564295.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>, Kees Cook <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Eric Biggers <ebiggers3@gmail.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Tue, Sep 25, 2018 at 4:39 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Add support to allow query the security status of the Intel nvdimms and
> also unlock the dimm via the kernel key management APIs. The passphrase is
> expected to be pulled from userspace through keyutils. Moving the Intel
> related bits to its own source file as well.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

The series is looking great, just a minor comment here...

[..]
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index f414ed346215..b7e22e6b80db 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
[..]
> +int nvdimm_security_unlock_dimm(struct device *dev)
> +{
[..]
> +       if (rc = 0) {
> +               if (!cached_key) {
> +                       key_link(nvdimm_keyring, key);
> +                       nvdimm->key = key;
> +               }
> +               nvdimm->state = NVDIMM_SECURITY_UNLOCKED;
> +               dev_info(dev, "DIMM %s unlocked\n", dev_name(dev));

I predict the noise from this print will necessitate a dev_dbg()
conversion down the road. Let's go ahead and make it dev_dbg() now.

> +       } else {
> +               key_unlink(nvdimm_keyring, key);
> +               key_invalidate(key);
> +               nvdimm->key = NULL;
> +               dev_warn(dev, "Failed to unlock dimm: %s\n", dev_name(dev));

This looks good, let's only spam the logs when things go bad.
