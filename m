From: David Howells <dhowells@redhat.com>
Date: Fri, 21 Sep 2018 23:20:50 +0000
Subject: Re: [PATCH v8 05/12] nfit/libnvdimm: add unlock of nvdimm support for Intel DIMMs
Message-Id: <17433.1537572050@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153549646600.4089.2626014553500613547.stgit@djiang5-desk3.ch.intel.com>
 <153549632073.4089.3609134467249378610.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153549646600.4089.2626014553500613547.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +	depends on KEYS

That needs to be in patch 2 where you create a keyring.

> +	char desc[NVDIMM_KEY_DESC_LEN + strlen(NVDIMM_PREFIX)];

You should be using sizeof() not strlen() and do you need + 1 for the NUL
char?

> +	sprintf(desc, "%s%s", NVDIMM_PREFIX, nvdimm->dimm_id);

NVDIMM_PREFIX is a constant string.  I would recommend either declaring it as
a const char[] or just sticking it in the format string in place of the %s:

	sprintf(desc, NVDIMM_PREFIX "%s", nvdimm->dimm_id);

> +		if (!cached_key) {
> +			key_link(nvdimm_keyring, key);
> +			nvdimm->key = key;
> +			key->perm |= KEY_USR_SEARCH;
> +		}

Ummm...  You're altering the key permission?  That's not really yours to
change.

> +static int nvdimm_check_key_len(unsigned short len, bool update)
> +{
> +	if (len = (NVDIMM_PASSPHRASE_LEN * 2) && update)
> +		return 0;

In the cover you said:

	- Modified "update" to take two key ids and and use lookup_user_key()
	  in order to improve security.  (David)

is this a holdover?

David
