From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sun, 15 Mar 2020 21:52:53 +0000
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer allocation
Message-Id: <20200315215253.GG224162@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-4-longman@redhat.com>
 <20200313164306.GA907@sol.localdomain>
 <8f2f1787-88b0-f86d-991c-34cfd2f9b4aa@redhat.com>
In-Reply-To: <8f2f1787-88b0-f86d-991c-34cfd2f9b4aa@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Fri, Mar 13, 2020 at 01:49:57PM -0400, Waiman Long wrote:
> >>  			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
> >>  				if (unlikely(tmpbuf))
> >> -					kzfree(tmpbuf);
> >> +					__kvzfree(tmpbuf, tmpbuflen);
> > Both kzfree() and __kvzfree() handle a NULL pointer, so there's no need for the
> > NULL check first.
> >
> I would like to keep this one because of the unlikely annotation.

What (measurable) gain does it bring anyway?

/Jarkko
