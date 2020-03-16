From: Waiman Long <longman@redhat.com>
Date: Mon, 16 Mar 2020 15:21:29 +0000
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer allocation
Message-Id: <b7188708-67fa-b41d-2d03-f9a3862f32d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200313152102.1707-4-longman@redhat.com>
 <20200313152102.1707-1-longman@redhat.com>
 <1809107.1584368672@warthog.procyon.org.uk>
In-Reply-To: <1809107.1584368672@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On 3/16/20 10:24 AM, David Howells wrote:
> I wonder if it's worth merging this into patch 2.  I'm not sure it's really
> worth its own patch.  If you want to generalise kvzfree(), then that could go
> as its own patch first.
>
> David

Sure, I can merge it into patch 2.

Thanks,
Longman
