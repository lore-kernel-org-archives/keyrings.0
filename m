From: David Howells <dhowells@redhat.com>
Date: Tue, 28 Nov 2017 10:57:54 +0000
Subject: Re: [PATCH] X.509: fix comparisons of ->pkey_algo
Message-Id: <10025.1511866674@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171127071724.25874-1-ebiggers3@gmail.com>
In-Reply-To: <20171127071724.25874-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, Alexander Potapenko <glider@google.com>, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> if (strcmp(x509->pub->pkey_algo, sinfo->sig->pkey_algo))

Can you make this strcmp(...) != 0?  I know it may seem picky, but checking
strcmp() in this way kind of inverts the true/false thing.

Thanks,
David
