From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Wed, 07 Mar 2018 17:56:38 +0000
Subject: Re: [PATCH] X.509: unpack RSA signatureValue field from BIT STRING
Message-Id: <593f6dbe-4ab4-0149-43d9-388cf0fee9f3@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <88da0c24-385c-64a9-6d56-36696d433bc7@maciej.szmigiero.name>
 <30085.1520437454@warthog.procyon.org.uk>
In-Reply-To: <30085.1520437454@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On 07.03.2018 16:44, David Howells wrote:
> Maciej S. Szmigiero <mail@maciej.szmigiero.name> wrote:
> 
>> +	if (!strcmp(ctx->cert->sig->pkey_algo, "rsa")) {
> 
> I'm going to change this to '= 0' rather than '!'.

No problem. 
> David
> 

Thanks,
Maciej
