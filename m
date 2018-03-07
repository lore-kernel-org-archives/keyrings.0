From: David Howells <dhowells@redhat.com>
Date: Wed, 07 Mar 2018 15:44:14 +0000
Subject: Re: [PATCH] X.509: unpack RSA signatureValue field from BIT STRING
Message-Id: <30085.1520437454@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <88da0c24-385c-64a9-6d56-36696d433bc7@maciej.szmigiero.name>
In-Reply-To: <88da0c24-385c-64a9-6d56-36696d433bc7@maciej.szmigiero.name>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Maciej S. Szmigiero <mail@maciej.szmigiero.name> wrote:

> +	if (!strcmp(ctx->cert->sig->pkey_algo, "rsa")) {

I'm going to change this to '= 0' rather than '!'.

David
