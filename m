From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 13 Mar 2020 01:04:25 +0000
Subject: Re: [PATCH v2 1/2] KEYS: Don't write out to userspace while holding key semaphore
Message-Id: <20200313010425.GA11360@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200308170410.14166-1-longman@redhat.com>
 <20200308170410.14166-2-longman@redhat.com>
In-Reply-To: <20200308170410.14166-2-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Sun, Mar 08, 2020 at 01:04:09PM -0400, Waiman Long wrote:
> +		/*
> +		 * Read methods will just return the required length
> +		 * without any copying if the provided length isn't big
> +		 * enough.
> +		 */
> +		if ((ret > 0) && (ret <= buflen) && buffer &&
> +		    copy_to_user(buffer, tmpbuf, ret))
> +			ret = -EFAULT;

Please, reorg and remove redundant parentheses:

/*
 * Read methods will just return the required length
 * without any copying if the provided length isn't big
 * enough.
 */
if (ret > 0 && ret <= buflen) {
	if (buffer && copy_to_user(buffer, tmpbuf, ret))
		ret = -EFAULT;
}

Now the comment is attached to the exact right thing. The previous
organization is a pain to look at when backtracking commits for
whatever reason in the future.

I'm also wondering, would it be possible to rework the code in a way
that you don't have check whether buffer is valid on a constant basis?

/Jarkko
