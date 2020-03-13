From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 13 Mar 2020 15:28:37 +0000
Subject: Re: [PATCH v2 1/2] KEYS: Don't write out to userspace while holding key semaphore
Message-Id: <20200313152837.GB142269@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200308170410.14166-1-longman@redhat.com>
 <20200308170410.14166-2-longman@redhat.com>
 <20200313010425.GA11360@linux.intel.com>
 <e2dc038b-0283-0bf6-45f6-ad2dd0775e81@redhat.com>
In-Reply-To: <e2dc038b-0283-0bf6-45f6-ad2dd0775e81@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Fri, Mar 13, 2020 at 09:29:47AM -0400, Waiman Long wrote:
> One way to do that is to extract the down_read/up_read block into a
> helper function and then have 2 separate paths - one for length
> retrieval and another one for reading the key. I think that will make
> the code a bit easier easier to read.
> 
> Thanks,
> Longman

If it is not too much trouble for you, I think this would be a legit
cleanup to do.

/Jarkko
