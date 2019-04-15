From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 15 Apr 2019 07:46:00 +0000
Subject: Re: [PATCH v2] MAINTAINERS: fix style in KEYS-TRUSTED entry
Message-Id: <20190415074600.GB13925@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190413055448.5434-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20190413055448.5434-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 07:54:48AM +0200, Lukas Bulwahn wrote:
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
