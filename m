From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 17 Jun 2020 23:42:50 +0000
Subject: Re: [PATCH v10 7/8] security: keys: trusted: add ability to specify arbitrary policy
Message-Id: <20200617234250.GJ62794@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-8-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200616160229.8018-8-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Tue, Jun 16, 2020 at 09:02:28AM -0700, James Bottomley wrote:
> This patch adds a policy= argument to key creation.  The policy is the
> standard tss policymaker format and each separate policy line must
> have a newline after it.

Never heard of policymaker before and did not find TCG spec for it.

/Jarkko
