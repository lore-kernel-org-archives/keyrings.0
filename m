From: Denis Kenzior <denkenz@gmail.com>
Date: Wed, 08 Aug 2018 15:49:56 +0000
Subject: Re: [RFCv3 08/13] KEYS: asym_tpm: Add loadkey2 and flushspecific
Message-Id: <d42e79ad-ea36-6e87-aacd-a5ea73581213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180802183121.22909-9-denkenz@gmail.com>
In-Reply-To: <20180802183121.22909-9-denkenz@gmail.com>
To: keyrings@vger.kernel.org

Hi David,

On 08/08/2018 10:46 AM, David Howells wrote:
> Denis Kenzior <denkenz@gmail.com> wrote:
> 
>> +#include "../../security/keys/trusted.h"
> 
> Should this be moved to include/keys/ somewhere, at least in part?
> 

That is one of the questions in my mind as well.  Should we factor out 
the core TPM primitives out of trusted.[ch] into a separate library / 
module or just have asym_tpm depend on the trusted subtype.  I have no 
real preference here as long as the stuff in trusted.[ch] can be shared 
somehow.

If you want to simply move trusted.h to include/keys that would be good 
with me as well.

Regards,
-Denis

