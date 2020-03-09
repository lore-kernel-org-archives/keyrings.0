From: David Howells <dhowells@redhat.com>
Date: Mon, 09 Mar 2020 16:32:20 +0000
Subject: Re: [PATCH v2 2/2] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <416690.1583771540@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200308170410.14166-3-longman@redhat.com> <20200308170410.14166-1-longman@redhat.com>
In-Reply-To: <20200308170410.14166-3-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

Waiman Long <longman@redhat.com> wrote:

> +			tmpbuf = kmalloc(tbuflen, GFP_KERNEL);

This would probably be better off using kvmalloc() - otherwise big objects
have to be constructed from runs of contiguous pages.  But since all we're
doing is buffering for userspace, we don't care about that.

If you agree, we can address it with an additional patch.

David
