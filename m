From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 18 Dec 2019 22:06:14 +0000
Subject: Re: [PATCH] KEYS: trusted: fix type warnings in ntohl/nthos
Message-Id: <73018a43cf345264d135e4b3a4c6c84ba0651489.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191217110939.2067979-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20191217110939.2067979-1-ben.dooks@codethink.co.uk>
To: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2019-12-17 at 11:09 +0000, Ben Dooks (Codethink) wrote:
> The ntohl takes a __be32 and ntohs takes __be16, so cast to
> those types before passing it to the byte swapping functions.
> 
> Note, would be32_to_cpu and be16_to_cpu be better here?

Yes, can you refine this?

Also in commit message you could

"
E.g.

security/keys/trusted-keys/trusted_tpm1.c:201:19: warning: cast to restricted __be32
"

We get the idea from one line :-)

/Jarkko
