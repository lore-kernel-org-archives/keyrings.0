From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 05 Mar 2020 11:25:11 +0000
Subject: Re: [PATCH] MAINTAINERS: adjust to trusted keys subsystem creation
Message-Id: <9127f0318e8507ca0b4e146d9b99d9ecb27f7f28.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200304160359.16809-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200304160359.16809-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Sebastian Duda <sebastian.duda@fau.de>, Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2020-03-04 at 17:03 +0100, Lukas Bulwahn wrote:
> Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
> renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
> to trusted-keys/trusted_tpm1.c in security/keys/.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   warning: no file matches F: security/keys/trusted.c
>   warning: no file matches F: include/keys/trusted.h
> 
> Rectify the KEYS-TRUSTED entry in MAINTAINERS now.
> 
> Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Sumit, please ack.
> Jarkko, please pick this patch.

I'll pick it when it is done. I acknowledge the regression but I
see no reason for rushing as this does not break any systems in
the wild.

/Jarkko
