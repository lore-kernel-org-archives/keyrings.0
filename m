From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 19 Mar 2019 16:46:23 +0000
Subject: Re: [PATCH 3/6] libnvdimm/security: Drop direct dependency on key_type_encrypted
Message-Id: <85a59ce3-c2c5-7127-8da7-637509adb830@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155297559082.2276575.2158004875457450595.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155297559082.2276575.2158004875457450595.stgit@dwillia2-desk3.amr.corp.intel.com>
To: Dan Williams <dan.j.williams@intel.com>, keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org



On 3/18/19 11:06 PM, Dan Williams wrote:
> Lookup the key type by name and protect libnvdimm from encrypted_keys.ko
> module load failures.
> 
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/nvdimm/security.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index f8bb746a549f..7f9e412f743a 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -48,12 +48,17 @@ static void nvdimm_put_key(struct key *key)
>  static struct key *nvdimm_request_key(struct nvdimm *nvdimm)
>  {
>  	struct key *key = NULL;
> +	struct key_type *type;
>  	static const char NVDIMM_PREFIX[] = "nvdimm:";
>  	char desc[NVDIMM_KEY_DESC_LEN + sizeof(NVDIMM_PREFIX)];
>  	struct device *dev = &nvdimm->dev;
>  
>  	sprintf(desc, "%s%s", NVDIMM_PREFIX, nvdimm->dimm_id);
> -	key = request_key(&key_type_encrypted, desc, "");
> +	type = key_type_lookup("encrypted");
> +	if (IS_ERR(type))
> +		return (struct key *) type;
> +
> +	key = request_key(type, desc, "");
>  	if (IS_ERR(key)) {
>  		if (PTR_ERR(key) = -ENOKEY)
>  			dev_dbg(dev, "request_key() found no key\n");
> @@ -88,7 +93,7 @@ static struct key *nvdimm_lookup_user_key(struct nvdimm *nvdimm,
>  		return NULL;
>  
>  	key = key_ref_to_ptr(keyref);
> -	if (key->type != &key_type_encrypted) {
> +	if (strcmp(key->type->name, "encrypted") != 0) {
>  		key_put(key);
>  		return NULL;
>  	}
> @@ -452,3 +457,5 @@ void nvdimm_security_overwrite_query(struct work_struct *work)
>  	__nvdimm_security_overwrite_query(nvdimm);
>  	nvdimm_bus_unlock(&nvdimm->dev);
>  }
> +
> +MODULE_SOFTDEP("pre: encrypted_keys");
> 
