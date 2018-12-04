From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 04 Dec 2018 09:14:34 +0000
Subject: Re: [RFC v2 04/13] x86/mm: Add helper functions for MKTME memory encryption keys
Message-Id: <20181204091434.GQ11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Mon, Dec 03, 2018 at 11:39:51PM -0800, Alison Schofield wrote:
> +int mktme_map_keyid_from_key(void *key)
> +{
> +	int i;
> +
> +	for (i = 1; i <= mktme_nr_keyids; i++)
> +		if (mktme_map->key[i] = key)
> +			return i;

CodingStyle

> +	return 0;
> +}
> +int mktme_map_get_free_keyid(void)
> +{
> +	int i;
> +
> +	if (mktme_map->mapped_keyids < mktme_nr_keyids) {
> +		for (i = 1; i <= mktme_nr_keyids; i++)
> +			if (mktme_map->key[i] = 0)
> +				return i;

CodingStyle

> +	}
> +	return 0;
> +}
