From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 31 Dec 2019 16:05:51 +0000
Subject: Re: [PATCH v4 0/9] TPM 2.0 trusted keys with attached policy
Message-Id: <20191231160539.GB4790@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, Dec 30, 2019 at 09:37:53AM -0800, James Bottomley wrote:
> This is basically a respin to update the ASN.1 interface to pass
> pointers in and out instead of updating in place.  The remainder of
> the patches haven't changed in substance, but have changed to support
> the new ASN.1 encoder API.
> 
> General Cover letter description:
> 
> I've changed the output format to use the standardised ASN.1 coding
> for TPM2 keys, meaning they should interoperate with userspace TPM2
> key implementations.  Apart from interoperability, another advantage
> of the existing key format is that it carries all parameters like
> parent and hash with it and it is capable of carrying policy
> directives in a way that mean they're tied permanently to the key (no
> having to try to remember what the policy was and reconstruct it from
> userspace).  This actually allows us to support the TPM 1.2 commands
> like pcrinfo easily in 2.0.
> 
> Using the TPM2_PolicyPassword trick, this series now combines
> authorization with policy in a flexible way that would allow us to
> move to HMAC based authorizations later for TPM security.  In getting
> passwords to work, I fixed the tpm2 password format in a separate
> patch.  TPM 1.2 only allows fixed length authorizations, but TPM 2.0
> allows for variable length passphrases, so we should support that in
> the keys.
> 
> James

I'll finally go deep with this as soon as we land the fixes for

https://bugzilla.kernel.org/show_bug.cgi?id 5935.

I'm sorry for ignorance but there's been multiple factors that have
delayed the review (the bug mentioned, kind of sudden steep ramp up to
keyring maintenance as David had to focus on other things, SGX
upstreaming and generally time seems to dissappear somewhere towards the
end of the year).

This week is a bit catching up but I'm sure that next week I have space
to give the focus the patch set requires (and deserves).

/Jarkko
