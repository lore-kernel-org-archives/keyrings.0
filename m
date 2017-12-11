From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 11 Dec 2017 18:55:02 +0000
Subject: Re: general protection fault in strcmp
Message-Id: <20171211185502.GA62691@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <089e082676ecdedb0b055f394f11@google.com>
In-Reply-To: <089e082676ecdedb0b055f394f11@google.com>
To: syzbot <bot+25a1a3685abe943a89512250aece10bdd9aa4827@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dhowells@redhat.com, herbert@gondor.apana.org.au, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

On Thu, Nov 30, 2017 at 12:44:01PM -0800, syzbot wrote:
> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new
> bug report.
> Note: all commands must start from beginning of the line in the email body.
> 

#syz fix: KEYS: reject NULL restriction string when type is specified
