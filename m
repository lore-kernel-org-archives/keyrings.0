From: David Howells <dhowells@redhat.com>
Date: Tue, 07 Apr 2020 20:19:53 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <694135.1586290793@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200407200318.11711-1-longman@redhat.com>
In-Reply-To: <20200407200318.11711-1-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

Waiman Long <longman@redhat.com> wrote:

> sensitive data objects allocated by kvmalloc(). The relevnat places

"relevant".

>  			if (unlikely(key_data))
> -				__kvzfree(key_data, key_data_len);
> +				kvfree_sensitive(key_data, key_data_len);

I think the if-statement is redundant.

David
