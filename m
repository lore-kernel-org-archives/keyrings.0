From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 13 Mar 2020 16:43:06 +0000
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer allocation
Message-Id: <20200313164306.GA907@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-4-longman@redhat.com>
In-Reply-To: <20200313152102.1707-4-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Fri, Mar 13, 2020 at 11:21:02AM -0400, Waiman Long wrote:
> For large multi-page temporary buffer allocation, the security/keys
> subsystem don't need contiguous physical pages. It will work perfectly
> fine with virtually mapped pages.
> 
> Replace the kmalloc() call by kvmalloc() and provide a __kvzfree()
> helper function to clear and free the kvmalloc'ed buffer. This will
> reduce the chance of memory allocation failure just because of highly
> fragmented pages.
> 
> Suggested-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  security/keys/internal.h | 14 ++++++++++++++
>  security/keys/keyctl.c   | 10 +++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index ba3e2da14cef..855b11eb73ee 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -16,6 +16,8 @@
>  #include <linux/keyctl.h>
>  #include <linux/refcount.h>
>  #include <linux/compat.h>
> +#include <linux/mm.h>
> +#include <linux/vmalloc.h>
>  
>  struct iovec;
>  
> @@ -349,4 +351,16 @@ static inline void key_check(const struct key *key)
>  
>  #endif
>  
> +/*
> + * Helper function to clear and free a kvmalloc'ed memory object.
> + */
> +static inline void __kvzfree(const void *addr, size_t len)
> +{
> +	if (is_vmalloc_addr(addr)) {
> +		memset((void *)addr, 0, len);
> +		vfree(addr);
> +	} else {
> +		kzfree(addr);
> +	}
> +}

Since this takes the length as a parameter, it can be simplified to:

static inline void __kvzfree(const void *addr, size_t len)
{
	if (addr) {
		memset((void *)addr, 0, len);
		kvfree(addr);
	}
}

>  			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
>  				if (unlikely(tmpbuf))
> -					kzfree(tmpbuf);
> +					__kvzfree(tmpbuf, tmpbuflen);

Both kzfree() and __kvzfree() handle a NULL pointer, so there's no need for the
NULL check first.

> @@ -920,7 +920,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>  				ret = -EFAULT;
>  		}
>  		if (tmpbuf)
> -			kzfree(tmpbuf);
> +			__kvzfree(tmpbuf, tmpbuflen);

Likewise here.  No need for the NULL check.

- Eric
