From: David Howells <dhowells@redhat.com>
Date: Fri, 21 Sep 2018 23:07:16 +0000
Subject: Re: [PATCH v8 02/12] libnvdimm: create keyring to store security keys
Message-Id: <16648.1537571236@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153549644916.4089.12258485183075906901.stgit@djiang5-desk3.ch.intel.com>
 <153549632073.4089.3609134467249378610.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153549644916.4089.12258485183075906901.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +static void nvdimm_unregister_keyring(void)
> +{
> +	key_revoke(nvdimm_keyring);
> +}

You need key_put() as well otherwise you'll leak a ref.

David
