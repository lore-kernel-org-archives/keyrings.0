From: Waiman Long <longman@redhat.com>
Date: Fri, 20 Mar 2020 13:27:03 +0000
Subject: Re: [PATCH v5 2/2] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <7dbc524f-6c16-026a-a372-2e80b40eab30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200318221457.1330-1-longman@redhat.com>
 <20200318221457.1330-3-longman@redhat.com>
 <20200319194650.GA24804@linux.intel.com>
 <f22757ad-4d6f-ffd2-eed5-6b9bd1621b10@redhat.com>
 <20200320020717.GC183331@linux.intel.com>
In-Reply-To: <20200320020717.GC183331@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On 3/19/20 10:07 PM, Jarkko Sakkinen wrote:
> On Thu, Mar 19, 2020 at 08:07:55PM -0400, Waiman Long wrote:
>> On 3/19/20 3:46 PM, Jarkko Sakkinen wrote:
>>> On Wed, Mar 18, 2020 at 06:14:57PM -0400, Waiman Long wrote:
>>>> +			 * It is possible, though unlikely, that the key
>>>> +			 * changes in between the up_read->down_read period.
>>>> +			 * If the key becomes longer, we will have to
>>>> +			 * allocate a larger buffer and redo the key read
>>>> +			 * again.
>>>> +			 */
>>>> +			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
>>> Shouldn't you check that tmpbuflen stays below buflen (why else
>>> you had made copy of buflen otherwise)?
>> The check above this thunk:
>>
>> if ((ret > 0) && (ret <= buflen)) {
>>
>> will make sure that ret will not be larger than buflen. So tmpbuflen
>> will never be bigger than buflen.
> Ah right, of course, thanks.
>
> What would go wrong if the condition was instead
> ((ret > 0) && (ret <= tmpbuflen))?

That if statement is a check to see if the actual key length is longer
than the user-supplied buffer (buflen). If that is the case, it will
just return the expected length without storing anything into the user
buffer. For the case that buflen >= ret > tmpbuflen, the revised check
above will incorrectly skip the storing step causing the caller to
incorrectly think the key is there in the buffer.

Maybe I should clarify that a bit more in the comment.

Cheers,
Longman
