From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Date: Tue, 03 Jul 2018 01:45:43 +0000
Subject: RE: [PATCH 04/11] nfit/libnvdimm: add unlock of nvdimm support for Intel DIMMs
Message-Id: <AT5PR8401MB1169BD7B3DE8CDA8BA5AE658AB420@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153057423804.38125.15912575101400055843.stgit@djiang5-desk3.ch.intel.com>
 <153057476931.38125.15448927598576316449.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153057476931.38125.15448927598576316449.stgit@djiang5-desk3.ch.intel.com>
To: 'Dave Jiang' <dave.jiang@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc: "dhowells@redhat.com" <dhowells@redhat.com>, "alison.schofield@intel.com" <alison.schofield@intel.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "keescook@chromium.org" <keescook@chromium.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>



> -----Original Message-----
> From: Linux-nvdimm [mailto:linux-nvdimm-bounces@lists.01.org] On Behalf Of Dave Jiang
> Sent: Monday, July 2, 2018 6:39 PM
> To: dan.j.williams@intel.com
> Cc: dhowells@redhat.com; alison.schofield@intel.com; keyrings@vger.kernel.org; keescook@chromium.org;
> linux-nvdimm@lists.01.org
> Subject: [PATCH 04/11] nfit/libnvdimm: add unlock of nvdimm support for Intel DIMMs
> 
> Adding support to allow query the security status of the Intel nvdimms and
> also unlock the dimm via the kernel key management APIs. The passphrase is
> expected to be pulled from userspace through keyutils. Moving the Intel
> related bits to its own source file as well.
> 
...
> +static int intel_dimm_security_unlock(struct nvdimm_bus *nvdimm_bus,
> +		struct nvdimm *nvdimm, const char *passphrase)
> +{
+	struct nd_intel_unlock_unit *cmd;
+	struct nd_cmd_pkg *pkg;
...
> +	pkg_size = sizeof(*pkg) + sizeof(*cmd);
> +	pkg = kzalloc(pkg_size, GFP_KERNEL);
> +	if (!pkg)
> +		return -ENOMEM;
> +
> +	pkg->nd_command = NVDIMM_INTEL_UNLOCK_UNIT;
> +	pkg->nd_family = NVDIMM_FAMILY_INTEL;
> +	pkg->nd_size_in = ND_INTEL_PASSPHRASE_SIZE;
> +	pkg->nd_size_out = ND_INTEL_STATUS_SIZE;
> +	pkg->nd_fw_size = ND_INTEL_STATUS_SIZE;
> +	cmd = (struct nd_intel_unlock_unit *)&pkg->nd_payload;
> +	memcpy(cmd->passphrase, passphrase, ND_INTEL_PASSPHRASE_SIZE);
> +	rc = nd_desc->ndctl(nd_desc, nvdimm, ND_CMD_CALL, pkg,
> +			sizeof(pkg_size), &cmd_rc);
...
> +	kfree(pkg);

Since it contains a high-value password, I recommend zeroing cmd->passphrase
before calling kfree() so that data isn't seen by a subsequent kmalloc()
caller (and make sure the compiler cannot optimize away the clearing code).
clear)

Also, check if the ndctl() call chain makes any copies of cmd->passphrase
and ensure they are cleared.

---
Robert Elliott, HPE Persistent Memory



