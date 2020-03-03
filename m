From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 03 Mar 2020 19:24:26 +0000
Subject: Re: [PATCH v6 2/6] oid_registry: Add TCG defined OIDS for TPM keys
Message-Id: <20200303192426.GB5775@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
 <20200302122759.5204-3-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200302122759.5204-3-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, Mar 02, 2020 at 07:27:55AM -0500, James Bottomley wrote:
> The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
> key uses.  We've defined three of the available numbers:
> 
> 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
> 		RSA2048 or Elliptic Curve) which can be imported by a
> 		TPM2_Load() operation.
> 
> 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
> 		RSA2048 or Elliptic Curve) which can be imported by a
> 		TPM2_Import() operation.
> 
> Both loadable and importable keys are specific to a given TPM, the
> difference is that a loadable key is wrapped with the symmetric
> secret, so must have been created by the TPM itself.  An importable
> key is wrapped with a DH shared secret, and may be created without
> access to the TPM provided you know the public part of the parent key.
> 
> 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
> 		bytes) which is sealed by the TPM.  It usually
> 		represents a symmetric key and must be unsealed before
> 		use.
> 
> The ASN.1 binary key form starts of with this OID as the first element
> of a sequence, giving the binary form a unique recognizable identity
> marker regardless of encoding.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Didn't I ack already this?

Anyway

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
