From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Sep 2018 01:04:56 +0000
Subject: Re: [PATCH v9 09/12] nfit/libnvdimm: add support for issue secure erase DSM to Intel nvdimm
Message-Id: <CAPcyv4gdvn0=5Dcq4FhPt_fpTtAS+N4TfUQCq0WdhTCBZZZojg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153791805740.70158.12896535066689316343.stgit@djiang5-desk3.ch.intel.com>
 <153791871610.70158.9555364033543193511.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153791871610.70158.9555364033543193511.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>, Kees Cook <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Eric Biggers <ebiggers3@gmail.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Tue, Sep 25, 2018 at 4:41 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Add support to issue a secure erase DSM to the Intel nvdimm. The
> required passphrase is acquired from userspace through the kernel key
> management. To trigger the action, "erase <old_keyid>" is written to the
> "security" sysfs attribute. libnvdimm will support the erase generic API
> call. The user key provided will be verified against the cached kernel
> key. If no kernel key exists, then the user key will be attempted for the
> operation.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Guess I missed this that last time I looked...

[..]
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index ff7c6a7cddd9..1ce602561d74 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -183,6 +183,74 @@ int nvdimm_security_get_state(struct device *dev)
>                         &nvdimm->state);
>  }
>
> +static int nvdimm_security_erase(struct device *dev, unsigned int keyid)
> +{
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
> +       struct key *key;
> +       struct user_key_payload *payload;
> +       int rc = 0;
> +       bool is_userkey = false;
> +
> +       if (!nvdimm->security_ops)
> +               return -EOPNOTSUPP;
> +
> +       /* lock the device and disallow driver bind */
> +       device_lock(dev);
> +
> +       /* No driver data means dimm is disabled. Proceed if so. */
> +       if (dev_get_drvdata(dev)) {
> +               dev_warn(dev, "Unable to secure erase while DIMM active.\n");

Unfortunately this is not a foolproof method for checking if the
DIMM's capacity is active. Especially when a DIMM does not have label
support it is possible for the driver to be detached, but the DIMM's
capacity is active in a region. So, I would change this to routine to
take the nvdimm_bus_lock() and check for:

    if (atomic_read(&nvdimm->busy))

That way you know the DIMM is not participating in any active regions,
and you know that the region driver is prevented from starting up
namespaces.
