From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 10 Jun 2017 09:01:31 +0000
Subject: Re: [PATCH v2 01/11] crypto: introduce crypto wait for async op
Message-Id: <20170610090131.GA15594@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1496046180-21962-1-git-send-email-gilad@benyossef.com>
	<1496046180-21962-2-git-send-email-gilad@benyossef.com>
	<20170610034336.GB14206@gondor.apana.org.au>
	<CAOtvUMeRtcVcp8HE9oJAkJO35yF9XBsry3tdNQYj-e31DnDFQQ@mail.gmail.com>
In-Reply-To: <CAOtvUMeRtcVcp8HE9oJAkJO35yF9XBsry3tdNQYj-e31DnDFQQ@mail.gmail.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org, David Howells <dhowells@redhat.com>, device-mapper development <dm-devel@redhat.com>, keyrings@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, Pavel Shilovsky <pshilov@microsoft.com>, Alasdair Kergon <agk@redhat.com>, linux-cifs@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-ima-user@lists.sourceforge.net, Eric Biggers <ebiggers3@gmail.com>, linux-raid@vger.kernel.org, linux-fscrypt@vger.kernel.org, James Morris <james.l.morris@oracle.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Ofir Drang <ofir.drang@arm.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, samba-technical@lists.samba.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Steve French <sfrench@samba.org>linux-

On Sat, Jun 10, 2017 at 11:05:39AM +0300, Gilad Ben-Yossef wrote:
>
> I guess there is a question if it really is important to know that
> your request ended up
> on the backlog, rather than being handled.I can imagine it can be used
> as back pressure
> indication but I wonder if someone is using that.

Oh yes we do want it to return EBUSY if we put it on the backlog
because in that case we want the user to stop sending us new
requests.

It's the other case where we dropped the request and returned
EBUSY where I think we could return something other than EBUSY
and get rid of the ambiguity.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
