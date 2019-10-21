From: David Howells <dhowells@redhat.com>
Date: Mon, 21 Oct 2019 14:21:59 +0000
Subject: Re: [PATCH] security/keyring: avoid pagefaults in keyring_read_iterator
Message-Id: <30309.1571667719@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191018184030.8407-1-crecklin@redhat.com>
In-Reply-To: <20191018184030.8407-1-crecklin@redhat.com>
To: Chris von Recklinghausen <crecklin@redhat.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>

Chris von Recklinghausen <crecklin@redhat.com> wrote:

> The put_user call from keyring_read_iterator caused a page fault which
> attempts to lock mm->mmap_sem and type->lock_class (key->sem) in the reverse
> order that keyring_read_iterator did, thus causing the circular locking
> dependency.
> 
> Remedy this by using access_ok and __put_user instead of put_user so we'll
> return an error instead of faulting in the page.

I wonder if it's better to create a kernel buffer outside of the lock in
keyctl_read_key().  Hmmm...  The reason I didn't want to do that is that
keyrings have don't have limits on the size.  Maybe that's not actually a
problem, since 1MiB would be able to hold a list of a quarter of a million
keys.

David
