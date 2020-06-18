From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 18 Jun 2020 00:25:40 +0000
Subject: Re: [PATCH v10 2/8] oid_registry: Add TCG defined OIDS for TPM keys
Message-Id: <1592439940.3515.40.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
         <20200616160229.8018-3-James.Bottomley@HansenPartnership.com>
         <20200617214237.dlvfnx2s7aw4sfng@cantor>
In-Reply-To: <20200617214237.dlvfnx2s7aw4sfng@cantor>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Wed, 2020-06-17 at 14:42 -0700, Jerry Snitselaar wrote:
> On Tue Jun 16 20, James Bottomley wrote:
> > The TCG has defined an OID prefix "2.23.133.10.1" for the various
> > TPM
> > key uses.  We've defined three of the available numbers:
> > 
> > 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key
> > (Usually
> > 		RSA2048 or Elliptic Curve) which can be imported by a
> > 		TPM2_Load() operation.
> > 
> > 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key
> > (Usually
> > 		RSA2048 or Elliptic Curve) which can be imported by a
> > 		TPM2_Import() operation.
> > 
> > Both loadable and importable keys are specific to a given TPM, the
> > difference is that a loadable key is wrapped with the symmetric
> > secret, so must have been created by the TPM itself.  An importable
> > key is wrapped with a DH shared secret, and may be created without
> > access to the TPM provided you know the public part of the parent
> > key.
> > 
> > 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
> > 		bytes) which is sealed by the TPM.  It usually
> > 		represents a symmetric key and must be unsealed before
> > 		use.
> > 
> 
> James, which document are these defined in? I was searching last
> night, and couldn't find it.

It isn't.  It's defined in a TCG spreadsheet that Monty Wiseman keeps,
but that seems to be as "official" as it gets with the TCG OID
registry.

James
