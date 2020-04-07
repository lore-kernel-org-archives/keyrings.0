From: Waiman Long <longman@redhat.com>
Date: Tue, 07 Apr 2020 20:24:26 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <025eb655-4c3f-6196-7f55-2987022c9b42@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200407200318.11711-1-longman@redhat.com>
 <694135.1586290793@warthog.procyon.org.uk>
In-Reply-To: <694135.1586290793@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On 4/7/20 4:19 PM, David Howells wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>> sensitive data objects allocated by kvmalloc(). The relevnat places
> "relevant".

Oh, sorry about the typo. Maybe Andrew can fix it.

Cheers,
Longman
