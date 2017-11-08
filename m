From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 08 Nov 2017 20:40:22 +0000
Subject: Re: general protection fault in asn1_ber_decoder
Message-Id: <20171108204022.GB14292@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <94eb2c1886e4e1e95e055d54b9ab@google.com>
In-Reply-To: <94eb2c1886e4e1e95e055d54b9ab@google.com>
To: syzbot <bot+04b92812698232d15d78c1e4d3bbf6fcc21eeeb1@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dhowells@redhat.com, herbert@gondor.apana.org.au, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

On Mon, Nov 06, 2017 at 10:36:00AM -0800, syzbot wrote:
> 
> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new
> bug report.
> Note: all commands must start from beginning of the line.

#syz fix: KEYS: fix NULL pointer dereference during ASN.1 parsing [ver #2]
