From: Waiman Long <longman@redhat.com>
Date: Mon, 04 May 2020 02:57:23 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <82fbc32f-3f9e-b876-b998-7714e8597988@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200407200318.11711-1-longman@redhat.com>
 <20200501232224.GC915@sol.localdomain>
In-Reply-To: <20200501232224.GC915@sol.localdomain>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On 5/1/20 7:22 PM, Eric Biggers wrote:
> On Tue, Apr 07, 2020 at 04:03:18PM -0400, Waiman Long wrote:
>> For kvmalloc'ed data object that contains sensitive information like
>> cryptographic key, we need to make sure that the buffer is always
>> cleared before freeing it. Using memset() alone for buffer clearing may
>> not provide certainty as the compiler may compile it away. To be sure,
>> the special memzero_explicit() has to be used.
>>
>> This patch introduces a new kvfree_sensitive() for freeing those
>> sensitive data objects allocated by kvmalloc(). The relevnat places
>> where kvfree_sensitive() can be used are modified to use it.
>>
>> Fixes: 4f0882491a14 ("KEYS: Avoid false positive ENOMEM error on key read")
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Looks good, feel free to add:
>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
>
> (I don't really buy the argument that the compiler could compile away memset()
> before kvfree().  But I agree with using memzero_explicit() anyway to make the
> intent explicit.)
>
> I don't see this patch in linux-next yet.  Who is planning to take this patch?
> Presumably David through the keyrings tree, or Andrew through mm?
>
> - Eric
>
Andrew, would you mind taking this patch into the mm-tree?

Thanks,
Longman
