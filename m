From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sun, 15 Mar 2020 21:32:45 +0000
Subject: Re: [PATCH v3 2/3] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <20200315213245.GF224162@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-3-longman@redhat.com>
In-Reply-To: <20200313152102.1707-3-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Fri, Mar 13, 2020 at 11:21:01AM -0400, Waiman Long wrote:
> -		 * Read methods will just return the required length
> -		 * without any copying if the provided length isn't big
> -		 * enough.
> +		 * We don't want an erronous -ENOMEM error due to an
> +		 * arbitrary large user-supplied buflen. So if buflen
> +		 * exceeds a threshold (1024 bytes in this case), we call
> +		 * the read method twice. The first time to get the buffer
> +		 * length and the second time to read out the key data.
> +		 *
> +		 * N.B. All the read methods will return the required
> +		 *      buffer length with a NULL input buffer or when
> +		 *      the input buffer length isn't large enough.
>  		 */
> +		if (buflen <= 0x400) {

1. The overwhelmingly long comment. Will be destined to rotten.
2. Magic number.
3. The cap must be updated both in comment and code, and not only
   that, but the numbers use a different base (dec and hex).

/Jarkko
