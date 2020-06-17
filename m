From: Jerry Snitselaar <jsnitsel@redhat.com>
Date: Wed, 17 Jun 2020 21:42:37 +0000
Subject: Re: [PATCH v10 2/8] oid_registry: Add TCG defined OIDS for TPM keys
Message-Id: <20200617214237.dlvfnx2s7aw4sfng@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-3-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200616160229.8018-3-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Tue Jun 16 20, James Bottomley wrote:
>The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
>key uses.  We've defined three of the available numbers:
>
>2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
>		RSA2048 or Elliptic Curve) which can be imported by a
>		TPM2_Load() operation.
>
>2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
>		RSA2048 or Elliptic Curve) which can be imported by a
>		TPM2_Import() operation.
>
>Both loadable and importable keys are specific to a given TPM, the
>difference is that a loadable key is wrapped with the symmetric
>secret, so must have been created by the TPM itself.  An importable
>key is wrapped with a DH shared secret, and may be created without
>access to the TPM provided you know the public part of the parent key.
>
>2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
>		bytes) which is sealed by the TPM.  It usually
>		represents a symmetric key and must be unsealed before
>		use.
>

James, which document are these defined in? I was searching last night,
and couldn't find it.

>The ASN.1 binary key form starts of with this OID as the first element
>of a sequence, giving the binary form a unique recognizable identity
>marker regardless of encoding.
>
>Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Reviewed-by: David Howells <dhowells@redhat.com>
>
>---
>
>v3: correct OID_TPMImportableKey name
>v7: add ack
>v9: add review
>---
> include/linux/oid_registry.h | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
>index 657d6bf2c064..f6e2276e5f30 100644
>--- a/include/linux/oid_registry.h
>+++ b/include/linux/oid_registry.h
>@@ -107,6 +107,11 @@ enum OID {
> 	OID_gostTC26Sign512B,		/* 1.2.643.7.1.2.1.2.2 */
> 	OID_gostTC26Sign512C,		/* 1.2.643.7.1.2.1.2.3 */
>
>+	/* TCG defined OIDS for TPM based keys */
>+	OID_TPMLoadableKey,		/* 2.23.133.10.1.3 */
>+	OID_TPMImportableKey,		/* 2.23.133.10.1.4 */
>+	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
>+
> 	OID__NR
> };
>
>-- 
>2.26.2
>
