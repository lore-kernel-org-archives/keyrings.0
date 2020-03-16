From: David Howells <dhowells@redhat.com>
Date: Mon, 16 Mar 2020 11:34:19 +0000
Subject: Re: [PATCH v3 1/3] KEYS: Don't write out to userspace while holding key semaphore
Message-Id: <1794026.1584358459@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200315212706.GE224162@linux.intel.com> <20200313152102.1707-1-longman@redhat.com> <20200313152102.1707-2-longman@redhat.com> <20200315192104.GD224162@linux.intel.com>
In-Reply-To: <20200315212706.GE224162@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, Waiman Long <longman@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> Do you have a test case that can reproduce this on a constant basis?

In this case it's quite tricky because a network filesystem is involved.  I
wonder if it might be possible to do it with fscrypt or ecryptfs.

David
