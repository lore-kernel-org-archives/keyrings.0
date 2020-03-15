From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sun, 15 Mar 2020 21:27:06 +0000
Subject: Re: [PATCH v3 1/3] KEYS: Don't write out to userspace while holding key semaphore
Message-Id: <20200315212706.GE224162@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-2-longman@redhat.com>
 <20200315192104.GD224162@linux.intel.com>
In-Reply-To: <20200315192104.GD224162@linux.intel.com>
To: Waiman Long <longman@redhat.com>, David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Sun, Mar 15, 2020 at 09:21:16PM +0200, Jarkko Sakkinen wrote:
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I guess we cannot sanely define fixes tag for this one, can we?

Surely this should still go to stable.

Do you have a test case that can reproduce this on a constant basis?

/Jarkko
