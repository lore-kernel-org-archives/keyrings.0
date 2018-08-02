From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Aug 2018 12:00:53 +0000
Subject: Re: [PATCH v6 05/11] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <20101.1533211253@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153255233932.51274.17371670672074459834.stgit@djiang5-desk3.ch.intel.com>
 <153255001863.51274.11308713958786222873.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153255233932.51274.17371670672074459834.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +	/* request new key from userspace */
> +	key = nvdimm_request_key(dev, update);
> +	if (!key) {
> +		dev_dbg(dev, "%s: failed to acquire new key\n", __func__);
> +		rc = -ENXIO;
> +		goto out;
> +	}

I still think you're better taking two explicit key IDs as part of the command
rather than using request_key() to *hopefully* pick the right target.

David
