From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 30 Sep 2020 03:43:11 +0000
Subject: Re: [PATCH v13 0/5] TPM 2.0 trusted key rework
Message-Id: <20200930034311.GA881524@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Mon, Sep 21, 2020 at 07:28:04PM -0700, James Bottomley wrote:
> Updated to fix compile problem identified by 0day
> 
> General cover letter minus policy bit:
> 
> This patch updates the trusted key code to export keys in the ASN.1
> format used by current TPM key tools (openssl_tpm2_engine and
> openconnect).  The current code will try to load keys containing
> policy, but being unable to formulate the policy commands necessary to
> load them, the unseal will always fail unless the policy is executed
> in user space and a pre-formed policy session passed in.
> 
> The key format is designed to be compatible with our two openssl
> engine implementations as well as with the format used by openconnect.
> I've added seal/unseal to my engine so I can use it for
> interoperability testing and I'll later use this for sealed symmetric
> keys via engine:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/
> 
> James

I started a kernel build for GLK NUC that I have. I'm hopeful that
tpm2-scripts fix will sort out this patch set. Will report the results
once I have them. I have a hunch that things will finally work out.

Using my master branch without the trusted keys fixes that I did.

/Jarkko
