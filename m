From: Waiman Long <longman@redhat.com>
Date: Wed, 18 Mar 2020 14:34:33 +0000
Subject: Re: [PATCH v4 4/4] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <e47bef56-9271-93e0-0e59-c77c253babea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200317194140.6031-5-longman@redhat.com>
 <20200317194140.6031-1-longman@redhat.com>
 <2832139.1584520054@warthog.procyon.org.uk>
In-Reply-To: <2832139.1584520054@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On 3/18/20 4:27 AM, David Howells wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>> +static inline void __kvzfree(const void *addr, size_t len)
>> +{
>> +	if (addr) {
>> +		memset((void *)addr, 0, len);
>> +		kvfree(addr);
>> +	}
>> +}
> I wonder if that would be better as "kvfree(memset(...))" as memset() will
> return the address parameter.  If memset is not inline, it avoids the need for
> the compiler to save the parameter.
>
> David

Doing this is micro-optimization. As the keys subsystem is that
performance critical, do we need to do that to save a cycle or two while
making the code a bit harder to read?

Cheers,
Longman
