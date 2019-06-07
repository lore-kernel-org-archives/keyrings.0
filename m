From: David Howells <dhowells@redhat.com>
Date: Fri, 07 Jun 2019 14:37:49 +0000
Subject: Re: [PATCH 10/10] Add sample notification program [ver #3]
Message-Id: <17511.1559918269@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190606212140.GA25664@vmlxhi-102.adit-jv.com> <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk> <155981421379.17513.13158528501056454772.stgit@warthog.procyon.org.uk>
In-Reply-To: <20190606212140.GA25664@vmlxhi-102.adit-jv.com>
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-block@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Eugeniu Rosca <roscaeugeniu@gmail.com>

Eugeniu Rosca <erosca@de.adit-jv.com> wrote:

> > +			asm ("lfence" : : : "memory" );
> [..]
> > +			asm("mfence" ::: "memory");

Have a look at ver #4.

David
