From: "lukas.bulwahn" <lukas.bulwahn@gmail.com>
Date: Sun, 10 Feb 2019 19:06:20 +0000
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
Message-Id: <alpine.DEB.2.21.1902101954310.9405@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com> <1549823158.4142.12.camel@linux.ibm.com>
In-Reply-To: <1549823158.4142.12.camel@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linuxibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org



On Sun, 10 Feb 2019, James Bottomley wrote:

> On Sun, 2019-02-10 at 19:10 +0100, Lukas Bulwahn wrote:
> > Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen
> > as
> > further maintainer to the KEYS-TRUSTED section entry. So, we rectify
> > this
> > with this commit.
> > 
> > The issue was detected when writing a script that parses MAINTAINERS.
> > 
> > Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for
> > trusted keys")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> This isn't really a bug, is it?
> 
> We have no formatting requirements for the MAINTAINERS file and the
> section owner is free to align with tabs, spaces or nothing as they see
> fit.  Most use a single tab, but a couple don't. The only real thing
> that cares is get_maintainers.pl and it uses \s* as the parse regexp,
> so it doesn't care either.
> 
> Now, we could possibly agree the file looks better with a single space
> or a single tab between the tag and the value and thus we should be
> doing this, but we'd need to agree on that and update the tag
> description accordingly.
> 

It was the only line in MAINTAINERS remaining that used spaces instead of 
a single tab. So, even if there is not an explicit formatting requirement, 
changing a single line to have it consistent in one format seemed 
reasonable to me.

I just sent a new patch that also corrected the email address; 
unfortunately, I was distracted and sent it out wrong twice before
getting Mimi's email right on the third try.

Please ignore this patch and consider the patch:

MAINTAINERS: rectify two issues in KEYS-TRUSTED entry

Thanks,

Lukas
