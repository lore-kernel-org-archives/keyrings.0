From: David Howells <dhowells@redhat.com>
Date: Tue, 28 Nov 2017 11:03:54 +0000
Subject: Re: [PATCH] X.509: fix printing uninitialized stack memory when OID is empty
Message-Id: <10620.1511867034@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171127071817.25999-1-ebiggers3@gmail.com>
In-Reply-To: <20171127071817.25999-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, Alexander Potapenko <glider@google.com>, Eric Biggers <ebiggers@google.com>, Takashi Iwai <tiwai@suse.de>

I wonder if all -EBADMSG returns here should just print "(badoid)" into the
buffer.

David
