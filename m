From: Waiman Long <longman@redhat.com>
Date: Tue, 10 Mar 2020 15:58:19 +0000
Subject: Re: [PATCH v2 2/2] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <da226448-4b76-0456-4c29-742a1a24fe79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200308170410.14166-3-longman@redhat.com>
 <20200308170410.14166-1-longman@redhat.com>
 <416690.1583771540@warthog.procyon.org.uk>
 <a4c92057-c364-965c-a251-02cbe46229b6@redhat.com>
In-Reply-To: <a4c92057-c364-965c-a251-02cbe46229b6@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On 3/10/20 11:45 AM, Waiman Long wrote:
> On 3/9/20 12:32 PM, David Howells wrote:
>> Waiman Long <longman@redhat.com> wrote:
>>
>>> +			tmpbuf = kmalloc(tbuflen, GFP_KERNEL);
>> This would probably be better off using kvmalloc() - otherwise big objects
>> have to be constructed from runs of contiguous pages.  But since all we're
>> doing is buffering for userspace, we don't care about that.
>>
>> If you agree, we can address it with an additional patch.
>>
>> David
> That is certainly fine with me. I don't care if the pages are contiguous
> or not. Will add a patch 3 for that as suggested.

That is not as simple as I thought. First of that, there is not an
equivalent kzvfree() helper to clear the buffer first before clearing.
Of course, I can do that manually.

With patch 2, the allocated buffer length will be max(1024, keylen). The
security code uses kmalloc() for allocation. If we use kvalloc() here,
perhaps we should also use that for allocation that can be potentially
large like that in big_key. What do you think?

Cheers,
Longman
