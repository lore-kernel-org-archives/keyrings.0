From: Joe Perches <joe@perches.com>
Date: Mon, 06 Apr 2020 19:38:19 +0000
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200406185827.22249-1-longman@redhat.com>
In-Reply-To: <20200406185827.22249-1-longman@redhat.com>
To: Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On Mon, 2020-04-06 at 14:58 -0400, Waiman Long wrote:
> For kvmalloc'ed data object that contains sensitive information like
> cryptographic key, we need to make sure that the buffer is always
> cleared before freeing it. Using memset() alone for buffer clearing may
> not provide certainty as the compiler may compile it away. To be sure,
> the special memzero_explicit() has to be used.

[] 
>  extern void kvfree(const void *addr);
> +extern void kvfree_sensitive(const void *addr, size_t len);

Question: why should this be const?

2.1.44 changed kfree(void *) to kfree(const void *) but
I didn't find a particular reason why.
