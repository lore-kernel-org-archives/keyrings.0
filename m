From: James Bottomley <jejb@linux.ibm.com>
Date: Sun, 10 Feb 2019 18:25:58 +0000
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
Message-Id: <1549823158.4142.12.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linuxibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2019-02-10 at 19:10 +0100, Lukas Bulwahn wrote:
> Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen
> as
> further maintainer to the KEYS-TRUSTED section entry. So, we rectify
> this
> with this commit.
> 
> The issue was detected when writing a script that parses MAINTAINERS.
> 
> Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for
> trusted keys")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

This isn't really a bug, is it?

We have no formatting requirements for the MAINTAINERS file and the
section owner is free to align with tabs, spaces or nothing as they see
fit.  Most use a single tab, but a couple don't. The only real thing
that cares is get_maintainers.pl and it uses \s* as the parse regexp,
so it doesn't care either.

Now, we could possibly agree the file looks better with a single space
or a single tab between the tag and the value and thus we should be
doing this, but we'd need to agree on that and update the tag
description accordingly.

James
