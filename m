From: David Howells <dhowells@redhat.com>
Date: Fri, 05 Oct 2018 15:43:50 +0000
Subject: Re: [PATCH 04/22] KEYS: Make the X.509 and PKCS7 parsers supply the sig encoding type
Message-Id: <21922.1538754230@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LRH.2.21.1810040511390.16168@namei.org> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618448451.7946.79126788153992612.stgit@warthog.procyon.org.uk>
In-Reply-To: <alpine.LRH.2.21.1810040511390.16168@namei.org>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, denkenz@gmail.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> Perhaps I'm missing something here but why do you need the gotos vs. just 
> breaking to this code?

Because at some point we might add support for some other public key
algorithm, such as EC.  This makes it clearer that that piece of code is
specific to a certain set of algorithm identifiers.

David
