From: David Howells <dhowells@redhat.com>
Date: Tue, 10 Mar 2020 17:12:23 +0000
Subject: Re: [PATCH v2 2/2] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <675400.1583860343@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <da226448-4b76-0456-4c29-742a1a24fe79@redhat.com> <20200308170410.14166-3-longman@redhat.com> <20200308170410.14166-1-longman@redhat.com> <416690.1583771540@warthog.procyon.org.uk> <a4c92057-c364-965c-a251-02cbe46229b6@redhat.com>
In-Reply-To: <da226448-4b76-0456-4c29-742a1a24fe79@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

Waiman Long <longman@redhat.com> wrote:

> That is not as simple as I thought. First of that, there is not an
> equivalent kzvfree() helper to clear the buffer first before clearing.
> Of course, I can do that manually.

Yeah, the actual substance of vfree() may get deferred.  It may be worth
adding a kvzfree() that switches between kzfree() and memset(),vfree().

> With patch 2, the allocated buffer length will be max(1024, keylen). The
> security code uses kmalloc() for allocation. If we use kvalloc() here,
> perhaps we should also use that for allocation that can be potentially
> large like that in big_key. What do you think?

Not for big_key: if it's larger than BIG_KEY_FILE_THRESHOLD (~1KiB) it gets
written encrypted into shmem so that it can be swapped out to disk when not in
use.

However, other cases, sure - just be aware that on a 32-bit system,
vmalloc/vmap space is a strictly limited resource.

David
