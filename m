From: David Howells <dhowells@redhat.com>
Date: Tue, 11 Sep 2018 22:03:15 +0000
Subject: Re: [RFC 11/12] keys/mktme: Add a new key service type for memory encryption keys
Message-Id: <27768.1536703395@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1a14a6feb02f968c5e6b98360f6f16106b633b58.1536356108.git.alison.schofield@intel.com> <cover.1536356108.git.alison.schofield@intel.com>
In-Reply-To: <1a14a6feb02f968c5e6b98360f6f16106b633b58.1536356108.git.alison.schofield@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, Kai Huang <kai.huang@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, Kirill Shutemov <kirill.shutemov@intel.com>, Dave Hansen <dave.hansen@intel.com>, Jarkko Sakkinen <jarkko.sakkinen@intel.com>, jmorris@namei.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-mm@kvack.org

Alison Schofield <alison.schofield@intel.com> wrote:

> +/* Key Service Command: Creates a software key and programs hardware */
> +int mktme_instantiate(struct key *key, struct key_preparsed_payload *prep)
> +{
> +	struct mktme_key_program *kprog = NULL;
> +	size_t datalen = prep->datalen;
> +	char *options;
> +	int ret = 0;
> +
> +	if (!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +
> +	if (datalen <= 0 || datalen > 1024 || !prep->data)
> +		return -EINVAL;
> +
> +	options = kmemdup(prep->data, datalen + 1, GFP_KERNEL);
> +	if (!options)
> +		return -ENOMEM;
> +
> +	options[datalen] = '\0';
> +
> +	kprog = kmem_cache_zalloc(mktme_prog_cache, GFP_KERNEL);
> +	if (!kprog) {
> +		kzfree(options);
> +		return -ENOMEM;
> +	}
> +	ret = mktme_get_options(options, kprog);
> +	if (ret < 0)
> +		goto out;

Everything prior to here looks like it should be in the ->preparse() routine.
I really should get round to making that mandatory.

> +
> +	mktme_map_lock();
> +	ret = mktme_program_key(key->serial, kprog);
> +	mktme_map_unlock();
> +out:
> +	kzfree(options);
> +	kmem_cache_free(mktme_prog_cache, kprog);
> +	return ret;
> +}

David
