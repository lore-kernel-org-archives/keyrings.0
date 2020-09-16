From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 16 Sep 2020 18:09:08 +0000
Subject: Re: [PATCH v4] certs: Add EFI_CERT_X509_GUID support for dbx entries
Message-Id: <20200916180908.GG21026@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200916004927.64276-1-eric.snowberg@oracle.com>
In-Reply-To: <20200916004927.64276-1-eric.snowberg@oracle.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, davem@davemloft.net, jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com, zohar@linux.ibm.com, erichte@linux.ibm.com, mpe@ellerman.id.au, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org

On Tue, Sep 15, 2020 at 08:49:27PM -0400, Eric Snowberg wrote:
> The Secure Boot Forbidden Signature Database, dbx, contains a list of now
> revoked signatures and keys previously approved to boot with UEFI Secure
> Boot enabled.  The dbx is capable of containing any number of
> EFI_CERT_X509_SHA256_GUID, EFI_CERT_SHA256_GUID, and EFI_CERT_X509_GUID
> entries.
> 
> Currently when EFI_CERT_X509_GUID are contained in the dbx, the entries are
> skipped.
> 
> Add support for EFI_CERT_X509_GUID dbx entries. When a EFI_CERT_X509_GUID
> is found, it is added as an asymmetrical key to the .blacklist keyring.
> Anytime the .platform keyring is used, the keys in the .blacklist keyring
> are referenced, if a matching key is found, the key will be rejected.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Looks good to me.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
