From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sat, 21 Mar 2020 00:58:20 +0000
Subject: Re: [PATCH v5 2/2] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <20200321005820.GC7166@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200320143547.GB3629@linux.intel.com>
 <20200318221457.1330-1-longman@redhat.com>
 <20200318221457.1330-3-longman@redhat.com>
 <20200319194650.GA24804@linux.intel.com>
 <f22757ad-4d6f-ffd2-eed5-6b9bd1621b10@redhat.com>
 <20200320020717.GC183331@linux.intel.com>
 <7dbc524f-6c16-026a-a372-2e80b40eab30@redhat.com>
 <3984029.1584748510@warthog.procyon.org.uk>
In-Reply-To: <3984029.1584748510@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Waiman Long <longman@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Fri, Mar 20, 2020 at 11:55:10PM +0000, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > /* Key data can change as we don not hold key->sem. */
> 
> I think you mean "we don't".

Oops, typo. Yes, thanks.

/Jarkko
