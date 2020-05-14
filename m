From: Matthew Wilcox <willy@infradead.org>
Date: Thu, 14 May 2020 12:00:18 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <20200514120018.GA16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200407200318.11711-1-longman@redhat.com>
 <1158ff38-c65d-379f-8ae7-6f507d9fc8dd@gmail.com>
In-Reply-To: <1158ff38-c65d-379f-8ae7-6f507d9fc8dd@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, David Rientjes <rientjes@google.com>

On Thu, May 14, 2020 at 09:00:40PM +1000, Balbir Singh wrote:
> I wonder if the right thing to do is also to disable pre-emption, just so that the thread does not linger on with sensitive data.
> 
> void kvfree_sensitive(const void *addr, size_t len)
> {
> 	preempt_disable();
> 	if (likely(!ZERO_OR_NULL_PTR(addr))) {
> 		memzero_explicit((void *)addr, len);
> 		kvfree(addr);
> 	}
> 	preempt_enable();
> }
> EXPORT_SYMBOL(kvfree_sensitive);

If it's _that_ sensitive then the caller should have disabled preemption.
Because preemption could otherwise have occurred immediately before
kvfree_sensitive() was called.
