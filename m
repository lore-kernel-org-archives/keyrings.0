From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 05 Mar 2020 21:16:51 +0000
Subject: Re: [PATCH] KEYS: Don't write out to userspace while holding key semaphore
Message-Id: <20200305211651.GA225345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200305210640.15315-1-longman@redhat.com>
In-Reply-To: <20200305210640.15315-1-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Thu, Mar 05, 2020 at 04:06:40PM -0500, Waiman Long wrote:
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 9b898c969558..564a4d187329 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -846,14 +846,36 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>  can_read_key:
>  	ret = -EOPNOTSUPP;
>  	if (key->type->read) {
> -		/* Read the data with the semaphore held (since we might sleep)
> +		/*
> +		 * Read the data with the semaphore held (since we might sleep)
>  		 * to protect against the key being updated or revoked.
> +		 *
> +		 * Allocating a temporary buffer to hold the keys before
> +		 * transferring them to user buffer to avoid potential
> +		 * deadlock involving page fault and mmap_sem.
>  		 */
> +		char *tmpbuf = kmalloc(buflen, GFP_KERNEL);

This is passing an arbitrarily large size from userspace into kmalloc().

- Eric
