From: Waiman Long <longman@redhat.com>
Date: Mon, 18 May 2020 02:39:38 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <365c8e0c-5d92-f032-b9ff-f64a8d314dfe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200407200318.11711-1-longman@redhat.com>
 <1158ff38-c65d-379f-8ae7-6f507d9fc8dd@gmail.com>
 <20200514120018.GA16070@bombadil.infradead.org>
 <f779dea1-3b50-e354-3914-7394b4473f5b@gmail.com>
In-Reply-To: <f779dea1-3b50-e354-3914-7394b4473f5b@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, David Rientjes <rientjes@google.com>

On 5/16/20 8:27 PM, Balbir Singh wrote:
>
> On 14/5/20 10:00 pm, Matthew Wilcox wrote:
>> On Thu, May 14, 2020 at 09:00:40PM +1000, Balbir Singh wrote:
>>> I wonder if the right thing to do is also to disable pre-emption, just so that the thread does not linger on with sensitive data.
>>>
>>> void kvfree_sensitive(const void *addr, size_t len)
>>> {
>>> 	preempt_disable();
>>> 	if (likely(!ZERO_OR_NULL_PTR(addr))) {
>>> 		memzero_explicit((void *)addr, len);
>>> 		kvfree(addr);
>>> 	}
>>> 	preempt_enable();
>>> }
>>> EXPORT_SYMBOL(kvfree_sensitive);
>> If it's _that_ sensitive then the caller should have disabled preemption.
>> Because preemption could otherwise have occurred immediately before
>> kvfree_sensitive() was called.
>>
> May be, but the callers of the API have to be explictly aware of the contract.
> I don't disagree with you on what you've said, but I was referring to the
> intent of freeing sensitive data vs the turn around time for doing so.

We can't disable preemption like that. The vfree() call may potentially 
sleep. It could be a mess to keep track of the preemption state to make 
that works.

The purpose of this API is to make sure that a newly allocated memory 
block won't contain secret left behind from another task. There is no 
guarantee on how long the freeing process will take.

Cheers,
Longman
