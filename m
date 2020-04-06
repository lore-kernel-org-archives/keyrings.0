From: David Howells <dhowells@redhat.com>
Date: Mon, 06 Apr 2020 14:32:09 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <102082.1586183529@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200406023700.1367-1-longman@redhat.com>
In-Reply-To: <20200406023700.1367-1-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Waiman Long <longman@redhat.com> wrote:

> +static inline void kvfree_sensitive(const void *addr, size_t len)

Linus suggested making it non-inline.

David
