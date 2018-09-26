From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Sep 2018 00:42:31 +0000
Subject: Re: [PATCH v9 06/12] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <CAPcyv4gVAvM3CPd7Z=AzuFK79RLC139F9xAvZ4G-SKLL8uEmpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153791805740.70158.12896535066689316343.stgit@djiang5-desk3.ch.intel.com>
 <153791869908.70158.3791301656095148670.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153791869908.70158.3791301656095148670.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>, Kees Cook <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Eric Biggers <ebiggers3@gmail.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Tue, Sep 25, 2018 at 4:39 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Add support for setting and/or updating passphrase on the Intel nvdimms.
> The passphrase is pulled from userspace through the kernel key management.
> We trigger the update via writing "update <old_keyid> <new_keyid>" to the
> sysfs attribute "security". If no <old_keyid> exists (for enabling security)
> then a 0 should be used. The state of the security can also be read via the
> "security" attribute. libnvdimm will generically support the key_change
> API call.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index b7e22e6b80db..e915e6de6c12 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
[..]
> +#define SEC_CMD_SIZE 128
> +static ssize_t security_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t len)
> +
> +{
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
> +       ssize_t rc = -EINVAL;
> +       unsigned int new_key = 0, old_key = 0;
> +       char cmd[SEC_CMD_SIZE];
> +
> +       if (len > SEC_CMD_SIZE)
> +               return -EINVAL;
> +
> +        wait_nvdimm_bus_probe_idle(&nvdimm_bus->dev);
> +        if (atomic_read(&nvdimm->busy))
> +                return -EBUSY;
> +
> +       sscanf(buf, "%s %u %u", cmd, &old_key, &new_key);
> +       if (strcmp(cmd, "update") = 0) {

Please use sysfs_streq() here to catch garbage at the end of the string.
