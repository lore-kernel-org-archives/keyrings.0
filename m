From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 26 Aug 2019 05:40:24 +0000
Subject: Re: [RESEND][PATCH v2-resend] MAINTAINERS: fix style in KEYS-TRUSTED entry
Message-Id: <20190826054024.fjx3robu464ndvi7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190825170015.3199-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20190825170015.3199-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 07:00:15PM +0200, Lukas Bulwahn wrote:
> Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
> further maintainer to the KEYS-TRUSTED section entry.
> 
> In fact, ./scripts/checkpatch.pl -f MAINTAINERS complains:
> 
>   WARNING: MAINTAINERS entries use one tab after TYPE:
>   #8581: FILE: MAINTAINERS:8581:
>   +M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> The issue was detected when writing a script that parses MAINTAINERS.
> 
> Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
