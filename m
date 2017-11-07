From: David Howells <dhowells@redhat.com>
Date: Tue, 07 Nov 2017 13:08:06 +0000
Subject: Re: general protection fault in asn1_ber_decoder
Message-Id: <12841.1510060086@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171106222153.GA37298@gmail.com> <94eb2c1886e4e1e95e055d54b9ab@google.com> <15884.1510005945@warthog.procyon.org.uk>
In-Reply-To: <20171106222153.GA37298@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, syzbot <bot+04b92812698232d15d78c1e4d3bbf6fcc21eeeb1@syzkaller.appspotmail.com>, davem@davemloft.net, herbert@gondor.apana.org.au, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

Eric Biggers <ebiggers3@gmail.com> wrote:

> Hi David, you just beat me to it, but I don't think this is the best way to
> fix the problem.  The length check just needs to be rewritten to not
> overflow.  Also it seems there is another broken length check later in the
> function.  How about this:

Okay, fair enough.  Do you mind if I trim your register dump a bit?

David
