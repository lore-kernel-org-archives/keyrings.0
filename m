From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 14 Sep 2020 18:02:38 +0000
Subject: Re: [PATCH v2] certs: Add EFI_CERT_X509_GUID support for dbx entries
Message-Id: <20200914180238.GB9369@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200909172736.73003-1-eric.snowberg@oracle.com>
 <20200914180127.GA9369@linux.intel.com>
In-Reply-To: <20200914180127.GA9369@linux.intel.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, davem@davemloft.net, jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com, zohar@linux.ibm.com, erichte@linux.ibm.com, mpe@ellerman.id.au, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org

On Mon, Sep 14, 2020 at 09:01:34PM +0300, Jarkko Sakkinen wrote:
> On Wed, Sep 09, 2020 at 01:27:36PM -0400, Eric Snowberg wrote:
> > The Secure Boot Forbidden Signature Database, dbx, contains a list of now
> > revoked signatures and keys previously approved to boot with UEFI Secure
> > Boot enabled.  The dbx is capable of containing any number of
> > EFI_CERT_X509_SHA256_GUID, EFI_CERT_SHA256_GUID, and EFI_CERT_X509_GUID
> > entries.
> > 
> > Currently when EFI_CERT_X509_GUID are contained in the dbx, the entries are
> > skipped.
> > 
> > Add support for EFI_CERT_X509_GUID dbx entries. When a EFI_CERT_X509_GUID
> > is found, it is added as an asymmetrical key to the .blacklist keyring.
> > Anytime the .platform keyring is used, the keys in the .blacklist keyring
> > are referenced, if a matching key is found, the key will be rejected.
> > 
> > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > ---
> > 
> > v2: 
> >  Fixed build issue reported by kernel test robot <lkp@intel.com>
> >  Commit message update (suggested by Jarkko Sakkinen)
> > 
> > ---
> >  certs/blacklist.c                             | 36 +++++++++++++++++++
> >  certs/system_keyring.c                        |  6 ++++
> >  include/crypto/pkcs7.h                        |  8 +++++
> >  include/keys/system_keyring.h                 | 11 ++++++
> >  .../platform_certs/keyring_handler.c          | 11 ++++++
> >  5 files changed, 72 insertions(+)
> > 
> > diff --git a/certs/blacklist.c b/certs/blacklist.c
> > index 6514f9ebc943..17ebf50cf0ae 100644
> > --- a/certs/blacklist.c
> > +++ b/certs/blacklist.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/err.h>
> >  #include <linux/seq_file.h>
> >  #include <keys/system_keyring.h>
> > +#include <crypto/pkcs7.h>
> >  #include "blacklist.h"
> >  
> >  static struct key *blacklist_keyring;
> > @@ -100,6 +101,41 @@ int mark_hash_blacklisted(const char *hash)
> >  	return 0;
> >  }
> >  
> > +int mark_key_revocationlisted(const char *data, size_t size)
> > +{
> > +	key_ref_t key;
> > +
> > +	key = key_create_or_update(make_key_ref(blacklist_keyring, true),
> > +				   "asymmetric",
> > +				   NULL,
> > +				   data,
> > +				   size,
> > +				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
> > +				    KEY_USR_VIEW),
> > +				   KEY_ALLOC_NOT_IN_QUOTA |
> > +				   KEY_ALLOC_BUILT_IN);
> > +
> > +	if (IS_ERR(key)) {
> > +		pr_err("Problem with revocation key (%ld)\n", PTR_ERR(key));
> > +		return PTR_ERR(key);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int is_key_revocationlisted(struct pkcs7_message *pkcs7)
> > +{
> > +	int ret;
> > +
> > +	ret = pkcs7_validate_trust(pkcs7, blacklist_keyring);
> > +
> > +	if (ret = 0)
> > +		return -EKEYREJECTED;
> > +
> > +	return -ENOKEY;
> > +}
> > +EXPORT_SYMBOL_GPL(is_key_revocationlisted);
> 
> What required this callable from a module?

Right, nees to be exported for pkcs7.


/Jarkko
