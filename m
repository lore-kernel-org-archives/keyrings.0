From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 18 Jun 2020 00:27:43 +0000
Subject: Re: [PATCH v10 7/8] security: keys: trusted: add ability to specify arbitrary policy
Message-Id: <1592440063.3515.42.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
         <20200616160229.8018-8-James.Bottomley@HansenPartnership.com>
         <20200617234250.GJ62794@linux.intel.com>
In-Reply-To: <20200617234250.GJ62794@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Thu, 2020-06-18 at 02:42 +0300, Jarkko Sakkinen wrote:
> On Tue, Jun 16, 2020 at 09:02:28AM -0700, James Bottomley wrote:
> > This patch adds a policy= argument to key creation.  The policy is
> > the standard tss policymaker format and each separate policy line
> > must have a newline after it.
> 
> Never heard of policymaker before and did not find TCG spec for it.

It's not part of the spec.  Both the IBM and Intel TSSs define a
policymaker tool to help you build policy hashes.  The format is simply
a set of numbers that if hashed a line at a time produce the policy
hash.

James
