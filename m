From: David Howells <dhowells@redhat.com>
Date: Fri, 28 Sep 2018 08:17:40 +0000
Subject: Re: [PATCH v10 02/12] libnvdimm: create keyring to store security keys
Message-Id: <24620.1538122660@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153799481498.71621.12671693381009469035.stgit@djiang5-desk3.ch.intel.com>
 <153799466529.71621.10728628542331983376.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153799481498.71621.12671693381009469035.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +static void nvdimm_unregister_keyring(void)
> +{
> +	key_put(nvdimm_keyring);
> +	key_revoke(nvdimm_keyring);

oops. ;-)

David
