From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 26 Mar 2019 12:10:20 +0000
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
Message-Id: <1553602220.3960.29.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
         <20190325212705.26837-1-joe@perches.com>
         <20190326113725.GA10898@linux.intel.com>
In-Reply-To: <20190326113725.GA10898@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, Denis Kenzior <denkenz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, James Morris <james.morris@microsoft.com>

Hi Jarrko,

On Tue, 2019-03-26 at 13:37 +0200, Jarkko Sakkinen wrote:
> Mimi,
> 
> Can you fix this and I can ack and send PR through my tree?

Making the "trusted.h" include file public was part of David's "KEYS:
Support TPM-wrapped key and crypto ops" patch set.  I wasn't involved
in reviewing or upstreaming this patch set.  As I recall, it was
upstreamed rather quickly without much review.  As it is TPM related,
it should have at least been posted on the linux-integrity mailing
list.  I have no idea if "trusted.h" should have been made public.

I'm not sure just "fixing" the MAINTAINERS file is the right solution.
 I was hoping to look at it later this week.  Perhaps you and James
could take a look?

Mimi
