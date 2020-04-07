From: Waiman Long <longman@redhat.com>
Date: Tue, 07 Apr 2020 20:45:45 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <67c51b03-192c-3006-5071-452f351aee67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200407200318.11711-1-longman@redhat.com>
 <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
In-Reply-To: <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
To: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On 4/7/20 4:31 PM, Joe Perches wrote:
> On Tue, 2020-04-07 at 16:03 -0400, Waiman Long wrote:
>> For kvmalloc'ed data object that contains sensitive information like
>> cryptographic key, we need to make sure that the buffer is always
>> cleared before freeing it. Using memset() alone for buffer clearing may
>> not provide certainty as the compiler may compile it away. To be sure,
>> the special memzero_explicit() has to be used.
>>
>> This patch introduces a new kvfree_sensitive() for freeing those
>> sensitive data objects allocated by kvmalloc(). The relevnat places
>> where kvfree_sensitive() can be used are modified to use it.
> []
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> []
>> @@ -757,6 +757,7 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
>>  }
>>  
>>  extern void kvfree(const void *addr);
>> +extern void kvfree_sensitive(const void *addr, size_t len);
> Why should size_t len be required?
>
> Why not do what kzfree does and memset
> the entire allocation? (area->size)

If the memory is really virtually mapped, the only way to find out the
size of the object is to use find_vm_area() which can be relatively high
cost and no simple helper function is available. On the other hand, the
length is readily available in the callers. So passing the length
directly to the kvfree_sensitive is simpler.

Cheers,
Longman
