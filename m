From: Waiman Long <longman@redhat.com>
Date: Wed, 18 Mar 2020 14:32:19 +0000
Subject: Re: [PATCH v4 2/4] KEYS: Remove __user annotation from rxrpc_read()
Message-Id: <fc537b1b-36f5-eac7-111b-e50f41fd01ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200317194140.6031-3-longman@redhat.com>
 <20200317194140.6031-1-longman@redhat.com>
 <2831786.1584519784@warthog.procyon.org.uk>
In-Reply-To: <2831786.1584519784@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On 3/18/20 4:23 AM, David Howells wrote:
> Patch 2 and 3 need to be rolled into patch 1 otherwise sparse will give
> warnings about mismatches in address spaces on patch 1.
>
> Thanks,
> David

I separated them because they spans different domain. Sure, I will
repost it to merge the first three.

Cheers,
Longman
