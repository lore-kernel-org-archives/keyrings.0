From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 11 Dec 2019 17:59:14 +0000
Subject: Re: [PATCH v2 0/8] Fix TPM 2.0 trusted keys
Message-Id: <20191211175914.GM4516@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1575936272.31378.50.camel@HansenPartnership.com>
In-Reply-To: <1575936272.31378.50.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, Dec 09, 2019 at 04:04:32PM -0800, James Bottomley wrote:
> This fixes a wide array of problems with the current TPM 2.0
> implementation of trusted keys.  Since policy based trusted keys never
> worked in the current implementation, I've rewritten the policy
> implementation to make it easier to use and so the trusted key handler
> can understand what elements of a policy are failing and why.
> 
> Apart from fixing bugs like volatile object leakage, I've changed the
> output format to use the standardised ASN.1 coding for TPM2 keys,
> meaning they should interoperate with userspace TPM2 key
> implementations.  Apart from interoperability, another advantage of the
> existing key format is that it carries all parameters like parent and
> hash with it and it is capable of carrying policy directives in a way
> that mean they're tied permanently to the key (no having to try to
> remember what the policy was and reconstruct it from userspace).  This
> actually allows us to support the TPM 1.2 commands like pcrinfo easily
> in 2.0.
> 
> The big problem with this patch is still that we can't yet combine
> policy with authorization because that requires proper session
> handling, but at least with this rewrite it becomes possible (whereas
> it was never possible with the old external policy session code). 
> Thus, when we have the TPM 2.0 security patch upstream, we'll be able
> to use the session logic from that patch to imlement authorizations.

Testing as soon as we have more urgent issues out of the table.

/Jarkko
