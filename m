From: Waiman Long <longman@redhat.com>
Date: Tue, 07 Apr 2020 20:07:58 +0000
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <ba77ea54-69db-2d5c-4811-78b0ac1c45d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200406185827.22249-1-longman@redhat.com>
 <20200406200016.GJ21484@bombadil.infradead.org>
In-Reply-To: <20200406200016.GJ21484@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, David Rientjes <rientjes@google.com>

On 4/6/20 4:00 PM, Matthew Wilcox wrote:
> On Mon, Apr 06, 2020 at 02:58:27PM -0400, Waiman Long wrote:
>> +/**
>> + * kvfree_sensitive - free a data object containing sensitive information
>> + * @addr - address of the data object to be freed
>> + * @len  - length of the data object
> Did you try building this with W=1?  I believe this is incorrect kerneldoc.
> It should be @addr: and @len:
>
> Also, it reads better in the htmldocs if you capitalise the first letter
> of each sentence and finish with a full stop.
>
You are right. I use the wrong delimiter here. I just send out a v3
patch to fix that. Thanks for noticing it.


>> @@ -914,7 +911,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>>  		 */
>>  		if (ret > key_data_len) {
>>  			if (unlikely(key_data))
>> -				__kvzfree(key_data, key_data_len);
>> +				kvfree_sensitive(key_data, key_data_len);
> I'd drop the test of key_data here.
>
I would like to keep the unlikely tag here to emphaize the fact that
this path should not be taken. I have comments up a few lines to talk
about it, though it didn't show up in the diff.

Cheers,
Longman
