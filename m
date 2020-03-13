From: Waiman Long <longman@redhat.com>
Date: Fri, 13 Mar 2020 13:29:47 +0000
Subject: Re: [PATCH v2 1/2] KEYS: Don't write out to userspace while holding key semaphore
Message-Id: <e2dc038b-0283-0bf6-45f6-ad2dd0775e81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200308170410.14166-1-longman@redhat.com>
 <20200308170410.14166-2-longman@redhat.com>
 <20200313010425.GA11360@linux.intel.com>
In-Reply-To: <20200313010425.GA11360@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On 3/12/20 9:04 PM, Jarkko Sakkinen wrote:
> On Sun, Mar 08, 2020 at 01:04:09PM -0400, Waiman Long wrote:
>> +		/*
>> +		 * Read methods will just return the required length
>> +		 * without any copying if the provided length isn't big
>> +		 * enough.
>> +		 */
>> +		if ((ret > 0) && (ret <= buflen) && buffer &&
>> +		    copy_to_user(buffer, tmpbuf, ret))
>> +			ret = -EFAULT;
> Please, reorg and remove redundant parentheses:
>
> /*
>  * Read methods will just return the required length
>  * without any copying if the provided length isn't big
>  * enough.
>  */
> if (ret > 0 && ret <= buflen) {
> 	if (buffer && copy_to_user(buffer, tmpbuf, ret))
> 		ret = -EFAULT;
> }
>
> Now the comment is attached to the exact right thing. The previous
> organization is a pain to look at when backtracking commits for
> whatever reason in the future.
Yes, I can reorganize the code.
> I'm also wondering, would it be possible to rework the code in a way
> that you don't have check whether buffer is valid on a constant basis?

One way to do that is to extract the down_read/up_read block into a
helper function and then have 2 separate paths - one for length
retrieval and another one for reading the key. I think that will make
the code a bit easier easier to read.

Thanks,
Longman
