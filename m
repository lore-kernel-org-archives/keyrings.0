From: James Bottomley <jejb@linux.vnet.ibm.com>
Date: Wed, 08 Aug 2018 15:53:37 +0000
Subject: Re: [RFCv3 08/13] KEYS: asym_tpm: Add loadkey2 and flushspecific
Message-Id: <1533743617.4044.13.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20180802183121.22909-9-denkenz@gmail.com>
In-Reply-To: <20180802183121.22909-9-denkenz@gmail.com>
To: keyrings@vger.kernel.org

On Wed, 2018-08-08 at 10:49 -0500, Denis Kenzior wrote:
> Hi David,
> 
> On 08/08/2018 10:46 AM, David Howells wrote:
> > Denis Kenzior <denkenz@gmail.com> wrote:
> > 
> > > +#include "../../security/keys/trusted.h"
> > 
> > Should this be moved to include/keys/ somewhere, at least in part?
> > 
> 
> That is one of the questions in my mind as well.  Should we factor
> out the core TPM primitives out of trusted.[ch] into a separate
> library / module or just have asym_tpm depend on the trusted
> subtype.  I have no real preference here as long as the stuff in
> trusted.[ch] can be shared somehow.
> 
> If you want to simply move trusted.h to include/keys that would be
> good with me as well.

I'm happy with that.  The trusted code is a bit of a mess at the
moment: all the tpm1.2 handling is inside trusted.c but the tpm2
handling is done by callouts to drivers/char/tpm/

I think, ideally, the tpm1.2 pieces should similarly move into
drivers/char/tpm/

James

