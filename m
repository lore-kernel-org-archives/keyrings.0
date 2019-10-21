From: Chris von Recklinghausen <crecklin@redhat.com>
Date: Mon, 21 Oct 2019 15:46:15 +0000
Subject: Re: [PATCH] security/keyring: avoid pagefaults in keyring_read_iterator
Message-Id: <b8aa0f7c-0a90-efae-9fb7-aa85b19a0d9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191018184030.8407-1-crecklin@redhat.com>
 <30309.1571667719@warthog.procyon.org.uk>
In-Reply-To: <30309.1571667719@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>

On 10/21/2019 10:21 AM, David Howells wrote:
> Chris von Recklinghausen <crecklin@redhat.com> wrote:
>
>> The put_user call from keyring_read_iterator caused a page fault which
>> attempts to lock mm->mmap_sem and type->lock_class (key->sem) in the reverse
>> order that keyring_read_iterator did, thus causing the circular locking
>> dependency.
>>
>> Remedy this by using access_ok and __put_user instead of put_user so we'll
>> return an error instead of faulting in the page.
> I wonder if it's better to create a kernel buffer outside of the lock in
> keyctl_read_key().  Hmmm...  The reason I didn't want to do that is that
> keyrings have don't have limits on the size.  Maybe that's not actually a
> problem, since 1MiB would be able to hold a list of a quarter of a million
> keys.
>
> David
>

Hi David,

Thanks for the feedback.

I can try to prototype that, but regardless of where the kernel buffer
is allocated, the important part is causing the initial pagefault in the
read path outside the lock so __put_user won't fail due to a valid user
address but page backing the user address isn't in-core.

I'll start work on v2.

Thanks,

Chris
