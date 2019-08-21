From: David Howells <dhowells@redhat.com>
Date: Wed, 21 Aug 2019 19:22:39 +0000
Subject: Re: [GIT PULL] Keys: Set 4 - Key ACLs for 5.3
Message-Id: <19088.1566415359@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1566402203.5162.12.camel@linux.ibm.com> <1562814435.4014.11.camel@linux.ibm.com> <28477.1562362239@warthog.procyon.org.uk> <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com> <20190710194620.GA83443@gmail.com> <20190710201552.GB83443@gmail.com> <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com> <23498.1565962602@warthog.procyon.org.uk>
In-Reply-To: <1566402203.5162.12.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, James Morris <jmorris@namei.org>, keyrings@vger.kernel.org, Netdev <netdev@vger.kernel.org>, linux-nfs@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-integrity@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

I added a bunch of tests to the keyutils testsuite, currently on my -next
branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log/?h=next

See:

	Add a keyctl command for granting a permit on a key
	Handle kernel having key/keyring ACLs

I've added manpages to describe the new bits, but I wonder whether I should
add a manpage specifically to detail the permissions system.  It'll probably
be useful when more advanced subjects become available, such as for specific
UIDs and for containers-as-a-whole.

David
