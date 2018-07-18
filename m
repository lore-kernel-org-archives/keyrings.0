From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Date: Wed, 18 Jul 2018 17:02:31 +0000
Subject: RE: [PATCH v5 01/12] nfit: add support for Intel DSM 1.7 commands
Message-Id: <AT5PR8401MB1169A89CE1A16C991D958720AB530@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
 <153186084980.27463.13636864614684009370.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153186084980.27463.13636864614684009370.stgit@djiang5-desk3.ch.intel.com>
To: 'Dave Jiang' <dave.jiang@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc: "dhowells@redhat.com" <dhowells@redhat.com>, "alison.schofield@intel.com" <alison.schofield@intel.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "keescook@chromium.org" <keescook@chromium.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>

> -----Original Message-----
> From: Linux-nvdimm [mailto:linux-nvdimm-bounces@lists.01.org] On Behalf Of Dave Jiang
> Sent: Tuesday, July 17, 2018 3:54 PM
> Subject: [PATCH v5 01/12] nfit: add support for Intel DSM 1.7 commands
...
> +#ifdef CONFIG_X86
> +
> +#define ND_INTEL_STATUS_SIZE		4
> +#define ND_INTEL_PASSPHRASE_SIZE	32
> +
...
> +
> +struct nd_intel_get_security_state {
> +	u32 status;
> +	u32 reserved;
> +	u8 state;
> +	u8 reserved1[3];
> +} __packed;
> +
> +struct nd_intel_set_passphrase {
> +	u8 old_pass[32];
> +	u8 new_pass[32];
> +	u32 status;
> +} __packed;
> +
> +struct nd_intel_unlock_unit {
> +	u8 passphrase[32];
> +	u32 status;
> +} __packed;
> +
> +struct nd_intel_disable_passphrase {
> +	u8 passphrase[32];
> +	u32 status;
> +} __packed;
> +
> +struct nd_intel_freeze_lock {
> +	u32 status;
> +} __packed;
> +
> +struct nd_intel_secure_erase {
> +	u8 passphrase[32];
> +	u32 status;
> +} __packed;
> +
> +struct nd_intel_overwrite {
> +	u8 passphrase[32];
> +	u32 status;
> +} __packed;

All those should use ND_INTEL_PASSPHRASE_SIZE rather than 32,
or there should be a compile-time check that the macro is
<= 32.

In patch 06/12, there is a lot of code that uses
ND_INTEL_PASSPHRASE_SIZE like this:

> +	if (old_data)
> +		memcpy(nd_cmd.cmd.old_pass, old_data->data,
> +				ND_INTEL_PASSPHRASE_SIZE);
> +	memcpy(nd_cmd.cmd.new_pass, new_data->data, ND_INTEL_PASSPHRASE_SIZE);

I think it's safer to use sizeof the destination field:

+	if (old_data)
+		memcpy(nd_cmd.cmd.old_pass, old_data->data,
+				sizeof(nd_cmd.cmd.old_pass));
+	memcpy(nd_cmd.cmd.new_pass, new_data->data,
	       sizeof(nd_cmd.cmd.new_pass));

That helps if the macro gets out of sync with the real size of
the structure.  If it larger, this change prevents an overrun.  If
it is smaller, then memcpy copies some extra bytes, which is
harmless.


---
Robert Elliott, HPE Persistent Memory





