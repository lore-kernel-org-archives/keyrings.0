From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 03 Nov 2017 14:25:29 +0000
Subject: Re: [PATCH v10 00/20] simplify crypto wait for async op
Message-Id: <20171103142528.GL9011@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1508310057-25369-1-git-send-email-gilad@benyossef.com>
In-Reply-To: <1508310057-25369-1-git-send-email-gilad@benyossef.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org, Gary Hook <gary.hook@amd.com>, David Howells <dhowells@redhat.com>, dm-devel@redhat.com, keyrings@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, Alasdair Kergon <agk@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Corbet <corbet@lwn.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>, Tom Lendacky <thomas.lendacky@amd.com>, linux-cifs@vger.kernel.org, linux-ima-user@lists.sourceforge.net, Arnaud Ebalard <arno@natisbad.org>, linux-fscrypt@vger.kernel.org, linux-mediatek@lists.infradead.org, James Morris <james.l.morris@oracle.com>, Matthias Brugger <matthias.bgg@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-arm-kernel@lists.infradead.org, Ofir

On Wed, Oct 18, 2017 at 08:00:32AM +0100, Gilad Ben-Yossef wrote:
> Many users of kernel async. crypto services have a pattern of
> starting an async. crypto op and than using a completion
> to wait for it to end.
> 
> This patch set simplifies this common use case in two ways:
> 
> First, by separating the return codes of the case where a
> request is queued to a backlog due to the provider being
> busy (-EBUSY) from the case the request has failed due
> to the provider being busy and backlogging is not enabled
> (-ENOSPC).
> 
> Next, this change is than built on to create a generic API
> to wait for a async. crypto operation to complete.
> 
> The end result is a smaller code base and an API that is
> easier to use and more difficult to get wrong.
> 
> The patch set was boot tested on x86_64 and arm64 which
> at the very least tests the crypto users via testmgr and
> tcrypt but I do note that I do not have access to some
> of the HW whose drivers are modified nor do I claim I was
> able to test all of the corner cases.
> 
> The patch set is based upon linux-next release tagged
> next-20171017.

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
