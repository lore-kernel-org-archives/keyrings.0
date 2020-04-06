From: Waiman Long <longman@redhat.com>
Date: Mon, 06 Apr 2020 14:40:35 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <04045dde-aa1a-5e7c-5a71-6b4a52c2fbb7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200406023700.1367-1-longman@redhat.com>
 <102082.1586183529@warthog.procyon.org.uk>
In-Reply-To: <102082.1586183529@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On 4/6/20 10:32 AM, David Howells wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>> +static inline void kvfree_sensitive(const void *addr, size_t len)
> Linus suggested making it non-inline.

Sorry, I misread his comment. Will send a v2 to fix that.

Cheers,
Longman
