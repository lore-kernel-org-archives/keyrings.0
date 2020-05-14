From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 14 May 2020 14:31:02 +0000
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-Id: <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Thu, 2020-05-07 at 16:11 -0700, James Bottomley wrote:
> This is a respin on v8 to make the encoder selectable and address
> David's comments.  The trusted key part hasn't changed except to add a
> now necessary select for ASN1_ENCODER to patch 4 and the changelog of
> patch 6 has been updated to correct the cut and paste error in the
> keyctl statement.
> 
> General cover letter:
> 
> This patch updates the trusted key code to export keys in the ASN.1
> format used by current TPM key tools (openssl_tpm2_engine and
> openconnect).  It also simplifies the use of policy with keys because
> the ASN.1 format is designed to carry a description of how to
> construct the policy, with the result that simple policies (like
> authorization and PCR locking) can now be constructed and used in the
> kernel, bringing the TPM 2.0 policy use into line with how TPM 1.2
> works.
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

I'm compiling now kernel with all series included.

Kind of checking if I could just take the whole series. Let see.

In all cases I want the style errors in 3/8 to be fixes with a helper
but maybe better to hold before sending anything. Possibly that is all
needed I'll just carve that patch myself.

Please don't do anything for the moment.

/Jarkko
