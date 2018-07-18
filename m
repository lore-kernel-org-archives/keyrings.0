From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Jul 2018 11:20:19 +0000
Subject: Re: [PATCH v5 06/12] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <10006.1531912819@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153186087803.27463.7423668214880824595.stgit@djiang5-desk3.ch.intel.com>
 <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153186087803.27463.7423668214880824595.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +	/* look for a key from keyring if exists and remove */
> +	old_key = nvdimm_search_key(dev);
> +	if (old_key) {
> +		dev_dbg(dev, "%s: killing old key: %#x\n",
> +				__func__, old_key->serial);
> +		key_invalidate(old_key);
> +		key_put_sync(old_key);
> +	}

Why don't you unlink the key from the .nvdimm keyring here?

David
