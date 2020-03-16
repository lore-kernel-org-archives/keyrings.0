From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 16 Mar 2020 13:53:30 +0000
Subject: Re: [PATCH v3 1/3] KEYS: Don't write out to userspace while holding key semaphore
Message-Id: <c1138c83619553d018970a4b2d95f38fccebc99c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200315212706.GE224162@linux.intel.com>
         <20200313152102.1707-1-longman@redhat.com>
         <20200313152102.1707-2-longman@redhat.com>
         <20200315192104.GD224162@linux.intel.com>
         <1793253.1584357764@warthog.procyon.org.uk>
In-Reply-To: <1793253.1584357764@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Waiman Long <longman@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Mon, 2020-03-16 at 11:22 +0000, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > I guess we cannot sanely define fixes tag for this one, can we?
> 
> Use:
> 
> 	Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> David

Longmao, please include this to the next version.

/Jarkko
