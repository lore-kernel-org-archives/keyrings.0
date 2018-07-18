From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Jul 2018 10:50:57 +0000
Subject: Re: [PATCH v5 02/12] libnvdimm: create keyring to store security keys
Message-Id: <7121.1531911057@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153186085546.27463.5501870662513432986.stgit@djiang5-desk3.ch.intel.com>
 <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153186085546.27463.5501870662513432986.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +static int nvdimm_key_instantiate(struct key *key,
> +		struct key_preparsed_payload *prep)

Please use ->preparse() if you can rather than doing this in ->instantiate().
Ideally ->instantiate() should not return an error, particularly not -EINVAL
or -ENOMEM.

> +{
> +	char *payload;
> +
> +	payload = kzalloc(nvdimm_key_type.def_datalen, GFP_KERNEL);
> +	if (!payload)
> +		return -ENOMEM;

Ummm...  Why not just kmemdup()?  Why not use use prep->datalen here rather
than def_datalen?

> +
> +	key->datalen = min(nvdimm_key_type.def_datalen, prep->datalen);
> +	memcpy(payload, prep->data, key->datalen);
> +	key->payload.data[0] = payload;
> +	return 0;
> +}

I would recommend, firstly, that you use generic_key_instantiate() if you can;
if not, you might want to use rcu_assign_keypointer().

> +	cred = prepare_kernel_cred(NULL);
> +	if (!cred) {
> +		rc = -ENOMEM;
> +		goto failed_cred;
> +	}

I wonder if you could just use &init_cred instead.

David
