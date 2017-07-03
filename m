From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 03 Jul 2017 12:35:15 +0000
Subject: Re: [PATCH v3 01/28] crypto: change backlog return code to -EIOCBQUEUED
Message-Id: <20170703123515.GC30067@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
	<1499006535-19760-2-git-send-email-gilad@benyossef.com>
In-Reply-To: <1499006535-19760-2-git-send-email-gilad@benyossef.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org, Gary Hook <gary.hook@amd.com>, David Howells <dhowells@redhat.com>, dm-devel@redhat.com, keyrings@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, Alasdair Kergon <agk@redhat.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Corbet <corbet@lwn.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>, Tom Lendacky <thomas.lendacky@amd.com>, linux-cifs@vger.kernel.org, linux-ima-user@lists.sourceforge.net, Arnaud Ebalard <arno@natisbad.org>, linux-raid@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-mediatek@lists.infradead.org, James Morris <james.l.morris@oracle.com>, Matthias Brugger <matthias.bgg@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-arm-kernel@lists.infradead.org, Ofir Drang <ofir.drang@arm.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, Dm

On Sun, Jul 02, 2017 at 05:41:43PM +0300, Gilad Ben-Yossef wrote:
> The crypto API was using the -EBUSY return value to indicate
> both a hard failure to submit a crypto operation into a
> transformation provider when the latter was busy and the backlog
> mechanism was not enabled as well as a notification that the operation
> was queued into the backlog when the backlog mechanism was enabled.
> 
> Having the same return code indicate two very different conditions
> depending on a flag is both error prone and requires extra runtime
> check like the following to discern between the cases:
> 
> 	if (err = -EINPROGRESS ||
> 	    (err = -EBUSY && (ahash_request_flags(req) &
> 			       CRYPTO_TFM_REQ_MAY_BACKLOG)))
> 
> This patch changes the return code used to indicate a crypto op
> was queued in the backlog to -EIOCBQUEUED, thus resolving both
> issues.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

So you're changing the success case from EBUSY to EIOCBQUEUED.
This results in a lot of churn as you have to change every single
driver and caller.

How about changing the error case to use something other than
EBUSY instead?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
