From: James Bottomley <jejb@linux.ibm.com>
Date: Fri, 19 Oct 2018 16:30:23 +0000
Subject: Re: [PATCH v2 -next] KEYS: trusted: remove set but not used variable 'keyhndl'
Message-Id: <1539966623.2819.3.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539241599-140866-1-git-send-email-yuehaibing@huawei.com>
         <1539949699-74650-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1539949699-74650-1-git-send-email-yuehaibing@huawei.com>
To: YueHaibing <yuehaibing@huawei.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, 2018-10-19 at 11:48 +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> security/keys/trusted.c: In function 'tpm_unseal':
> security/keys/trusted.c:592:11: warning:
>  variable 'keyhndl' set but not used [-Wunused-but-set-variable]
>   uint32_t keyhndl;
> 
> It never used since introduction in 
> commit d00a1c72f7f4 ("keys: add new trusted key-type")

This triggered an "er, shouldn't we be using the SRK parent by
default?"  search through the code, but it turns out that's all taken
care of in trusted_options_alloc() where we'll set up the SRK as parent
with well known auth and unless overridden on the command line, that's
what we use, so I'm happy this is simply left over code from a
different implementation of that use case.

James
