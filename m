From: David Howells <dhowells@redhat.com>
Date: Fri, 28 Sep 2018 08:24:28 +0000
Subject: Re: [PATCH v10 05/12] nfit/libnvdimm: add unlock of nvdimm support for Intel DIMMs
Message-Id: <24969.1538123068@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153799483234.71621.9184634994174583985.stgit@djiang5-desk3.ch.intel.com>
 <153799466529.71621.10728628542331983376.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153799483234.71621.9184634994174583985.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +/*
> + * Find key in kernel keyring
> + */
> +static struct key *nvdimm_get_key(struct device *dev)

Note that the comment is no longer correct.

> +static struct key *nvdimm_request_key(struct device *dev)
> +{
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +	struct key *key = NULL;
> +	char desc[NVDIMM_KEY_DESC_LEN + sizeof(NVDIMM_PREFIX)];
> +
> +	sprintf(desc, "%s%s", NVDIMM_PREFIX, nvdimm->dimm_id);
> +	key = request_key(&key_type_logon, desc, desc);

I would suggest passing "" as the callout_info rather than duplicating the
description.  The description is available to the upcall program anyway.

> +			key_link(nvdimm_keyring, key);
> +			nvdimm->key = key;

Since you're attaching the key to the nvdimm struct, do you actually need a
kernel keyring also?  You only ever link things into it and unlink things from
it; you never actually search it that I can see.  I would suggest, therefore,
just getting rid of the nvdimm_keyring entirely.  The keys are retained by the
nvdimm struct, so that shouldn't be a problem.

David
