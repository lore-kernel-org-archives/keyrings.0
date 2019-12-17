From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 17 Dec 2019 14:35:58 +0000
Subject: Re: [PATCH] KEYS: trusted: fix type warnings in ntohl/nthos
Message-Id: <10be346c204016547fee0323cbf2ab4688dd2859.camel@linux.intel.com>
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

Thanks!

> Note, would be32_to_cpu and be16_to_cpu be better here?

Yes, I think that should work too.

/Jarkko
