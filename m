From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 14 Dec 2019 20:37:12 +0000
Subject: Re: [PATCH v2 0/8] Fix TPM 2.0 trusted keys
Message-Id: <1576355832.4035.10.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1575936272.31378.50.camel@HansenPartnership.com>
In-Reply-To: <1575936272.31378.50.camel@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, 2019-12-09 at 16:04 -0800, James Bottomley wrote:
[...]
> The big problem with this patch is still that we can't yet combine
> policy with authorization because that requires proper session
> handling, but at least with this rewrite it becomes possible (whereas
> it was never possible with the old external policy session code). 
> Thus, when we have the TPM 2.0 security patch upstream, we'll be able
> to use the session logic from that patch to imlement authorizations.

I had a discussion with Ken Goldman on Friday where he told me this
wasn't true: we can actually persuade a policy session to do a non-HMAC 
authorization (for the interested, the trick is to use
TPM2_PolicyPassword in place of TPM2_PolicyAuthValue.  It hashes to the
same policy but the former sets the session up for non-HMAC and the
latter for HMAC) so I'll add password based authorization to policies
when I respin the patch set.

James
