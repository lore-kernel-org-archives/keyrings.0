From: Waiman Long <longman@redhat.com>
Date: Mon, 06 Apr 2020 14:36:07 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <3f6658e5-0082-7759-1d08-eda9cb3eba2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20200406023700.1367-1-longman@redhat.com>
 <alpine.DEB.2.21.2004052119530.243304@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2004052119530.243304@chino.kir.corp.google.com>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On 4/6/20 12:20 AM, David Rientjes wrote:
> On Sun, 5 Apr 2020, Waiman Long wrote:
>
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
>> Fixes: 4f0882491a14 ("KEYS: Avoid false positive ENOMEM error on key rea=
d")
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  include/linux/mm.h       | 17 +++++++++++++++++
>>  security/keys/internal.h | 11 -----------
>>  security/keys/keyctl.c   | 16 +++++-----------
>>  3 files changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 7dd5c4ccbf85..c26f279f1956 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -758,6 +758,23 @@ static inline void *kvcalloc(size_t n, size_t size,=
 gfp_t flags)
>> =20
>>  extern void kvfree(const void *addr);
>> =20
>> +/**
>> + * kvfree_sensitive - free a data object containing sensitive informati=
on
>> + * @addr - address of the data object to be freed
>> + * @len  - length of the data object
>> + *
>> + * Use the special memzero_explicit() function to clear the content of a
>> + * kvmalloc'ed object containing sensitive data to make sure that the
>> + * compiler won't optimize out the data clearing.
>> + */
>> +static inline void kvfree_sensitive(const void *addr, size_t len)
>> +{
>> +	if (addr) {
> Shouldn't this be if (unlikely(ZERO_OR_NULL_PTR(addr))?
>
ZERO_OR_NULL_PTR is defined in slab.h. Using it may cause some header
file dependency problem. To guard against the possibility of 0-length
allocation request, how about just

=A0=A0=A0 if (likely(addr && len)) {

Cheers,
Longman
