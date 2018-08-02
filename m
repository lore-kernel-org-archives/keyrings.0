From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Aug 2018 11:58:11 +0000
Subject: Re: [PATCH v6 04/11] nfit/libnvdimm: add unlock of nvdimm support for Intel DIMMs
Message-Id: <19807.1533211091@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153255233354.51274.8552293701029405599.stgit@djiang5-desk3.ch.intel.com>
 <153255001863.51274.11308713958786222873.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153255233354.51274.8552293701029405599.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +	key = key_lookup(nvdimm->key_id);

You should not be using key_lookup() as the key ID doesn't pin a reference to
the key you're using.  If you're going to cache a key, either cache the key
pointer directly and check it with key_validate() before you use it or keep
the cache in a private kernel keyring and use key_search() each time you want
to use it.  The latter method allows for the key to be garbage collected
automatically if it expires or gets invalidated.

You can still follow a negative call for a cached key with a call to
nvdimm_request_key().  In the private keyring-using case, you can link the key
to the private keyring after you got it.

> +	payload = key->payload.data[0];
> +	rc = nvdimm->security_ops->unlock(nvdimm_bus, nvdimm,
> +			(void *)payload->data);

I would recommend casting to const void * if you can as you're not allowed to
change the payload data.

David
