From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 16 Mar 2020 22:19:06 +0000
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer allocation
Message-Id: <f89b41ea8fc1ab84cc19fd1c1f9b048457bbc28d.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200313152102.1707-4-longman@redhat.com>
         <20200313152102.1707-1-longman@redhat.com>
         <1809107.1584368672@warthog.procyon.org.uk>
In-Reply-To: <1809107.1584368672@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, Waiman Long <longman@redhat.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Mon, 2020-03-16 at 14:24 +0000, David Howells wrote:
> I wonder if it's worth merging this into patch 2.  I'm not sure it's really
> worth its own patch.  If you want to generalise kvzfree(), then that could go
> as its own patch first.
> 
> David

Also in the sense that there is no senseful situation where you'd
only wanted to pick either but not both.

/Jarkko
