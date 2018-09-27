From: David Howells <dhowells@redhat.com>
Date: Thu, 27 Sep 2018 17:12:18 +0000
Subject: Re: [PATCH 3/5] rxrpc: mention that client key payloads are not arbitrary
Message-Id: <29436.1538068338@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131450.23458-4-mathstuf@gmail.com>
In-Reply-To: <20180927131450.23458-4-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> wrote:

> - * rxrpc defined keys take an arbitrary string as the description and an
> - * arbitrary blob of data as the payload
> + * rxrpc defined keys take an arbitrary string as the description. See
> + * rxrpc_preparse for the payload format.

I think this change is unnecessary.  Someone who knows what they're looking at
should know that.  Better would be to describe it in Documentation somewhere.
Might be worth just deleting that particular comment entirely.

David
