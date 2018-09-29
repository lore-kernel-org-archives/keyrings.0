From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 29 Sep 2018 00:41:04 +0000
Subject: Re: [PATCH v11 04/12] nfit/libnvdimm: add unlock of nvdimm support for Intel DIMMs
Message-Id: <CAPcyv4irD-d=U9Y9hvyqg-6=8ST8dPnK1apviuOJ5bt2oX-Oew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153817140052.17152.8594371908103118425.stgit@djiang5-desk3.ch.intel.com>
 <153817162922.17152.3222889638018212575.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153817162922.17152.3222889638018212575.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>, Kees Cook <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Eric Biggers <ebiggers3@gmail.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Fri, Sep 28, 2018 at 2:54 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Add support to allow query the security status of the Intel nvdimms and
> also unlock the dimm via the kernel key management APIs. The passphrase is
> expected to be pulled from userspace through keyutils. Moving the Intel
> related bits to its own source file as well.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
> index 6c8fb7590838..b6381ddbd6c1 100644
> --- a/drivers/nvdimm/dimm.c
> +++ b/drivers/nvdimm/dimm.c
[..]
> @@ -25,6 +28,119 @@
>
>  static DEFINE_IDA(dimm_ida);
>
> +/*
> + * Find key that's cached with nvdimm
> + */
> +static struct key *nvdimm_get_key(struct device *dev)
> +{
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +
> +       if (!nvdimm->key)
> +               return NULL;
> +
> +       if (key_validate(nvdimm->key) < 0)
> +               return NULL;
> +
> +       key_get(nvdimm->key);

I look at this and the double key_put() in nvdimm_release() and wonder
if this can be simplified by making the rule be that nvdimm->key, if
it is not NULL, is a valid key and the final put is done by
nvdimm_release(). Whenever the key becomes invalid that operation also
marks nvdimm->key NULL. This does mean we need some extra locking. but
we likely need that anyway because what's to stop the key going
invalid immediately after the key_validate() check above?
