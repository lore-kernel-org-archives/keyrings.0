From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 02 Mar 2020 11:08:49 +0000
Subject: Re: [PATCH v5 3/6] security: keys: trusted fix tpm2 authorizations
Message-Id: <20200302110849.GA3979@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
 <20200130101812.6271-4-James.Bottomley@HansenPartnership.com>
 <20200225164850.GB15662@linux.intel.com>
 <1582765091.4245.33.camel@HansenPartnership.com>
 <20200227161949.GD5140@linux.intel.com>
 <1582820506.18445.3.camel@HansenPartnership.com>
 <1582825769.18445.18.camel@HansenPartnership.com>
In-Reply-To: <1582825769.18445.18.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Thu, Feb 27, 2020 at 09:49:29AM -0800, James Bottomley wrote:
> On Thu, 2020-02-27 at 08:21 -0800, James Bottomley wrote:
> > On Thu, 2020-02-27 at 18:19 +0200, Jarkko Sakkinen wrote:
> [...]
> > Ok, I'll add that commit as the fixes; it certainly makes no sense to
> > backport this change before the above commit.
> 
> This is what I currently have.  Do you want me to resend the whole
> series?

I prefer to review full snapshots of the series.

/Jarkko
