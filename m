From: Joe Perches <joe@perches.com>
Date: Wed, 08 Apr 2020 00:35:24 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <bc4500becb77f4e6396f69cc354ceb46c2aebb04.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200407200318.11711-1-longman@redhat.com>
	 <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
	 <67c51b03-192c-3006-5071-452f351aee67@redhat.com>
	 <20200407221255.GM21484@bombadil.infradead.org>
In-Reply-To: <20200407221255.GM21484@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>

On Tue, 2020-04-07 at 15:12 -0700, Matthew Wilcox wrote:
> On Tue, Apr 07, 2020 at 04:45:45PM -0400, Waiman Long wrote:
> > On 4/7/20 4:31 PM, Joe Perches wrote:
> > > On Tue, 2020-04-07 at 16:03 -0400, Waiman Long wrote:
> > > > +extern void kvfree_sensitive(const void *addr, size_t len);
> > > Why should size_t len be required?
> > > 
> > > Why not do what kzfree does and memset
> > > the entire allocation? (area->size)
> > 
> > If the memory is really virtually mapped, the only way to find out the
> > size of the object is to use find_vm_area() which can be relatively high
> > cost and no simple helper function is available. On the other hand, the
> > length is readily available in the callers. So passing the length
> > directly to the kvfree_sensitive is simpler.
> 
> Also it lets us zero only the first N bytes of the allocation.  That might
> be good for performance, if only the first N bytes of an M byte allocation
> are actually sensitive.  I don't know if we have any such cases, but
> they could exist.

I would really doubt it as the allocation of
sensitive data should generally be separate.

Also, a similar argument could apply to
kzfree/kfree_sensitive.
