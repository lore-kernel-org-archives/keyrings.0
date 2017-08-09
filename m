From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Wed, 09 Aug 2017 05:18:03 +0000
Subject: Re: [PATCH v4 02/19] crypto: ccm: use -EAGAIN for transient busy indication
Message-Id: <CAOtvUMeUHk9KxQumhuvJ52dp-_-LFOD8XGvCWvhU6LjEZhEF7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1502193834-11289-1-git-send-email-gilad@benyossef.com>
 <1502193834-11289-3-git-send-email-gilad@benyossef.com> <4600c898-a2f2-f95f-15b4-0adcc6acc0b5@amd.com>
In-Reply-To: <4600c898-a2f2-f95f-15b4-0adcc6acc0b5@amd.com>
To: Gary R Hook <gary.hook@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Arnaud Ebalard <arno@natisbad.org>, Matthias Brugger <matthias.bgg@gmail.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, "dm-devel@redhat.com" <dm-devel@redhat.com>, Shaohua Li <shli@kernel.org>, Steve French <sfrench@samba.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-

On Tue, Aug 8, 2017 at 6:24 PM, Gary R Hook <gary.hook@amd.com> wrote:
> On 08/08/2017 07:03 AM, Gilad Ben-Yossef wrote:
>>
>> Replace -EBUSY with -EAGAIN when reporting transient busy
>> indication in the absence of backlog.
>>
>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
>
> Could we use "ccp" in the subject line, please?

Of course, sorry about the the typo.

Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
