From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sat, 16 May 2020 12:24:38 +0000
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-Id: <967f6b0a1fd4ba6e2c44527174e1798de365da1a.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515093000.naogi4a7j22bzggz@cantor>
         <1589568507.3653.18.camel@HansenPartnership.com>
In-Reply-To: <1589568507.3653.18.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Jerry Snitselaar <jsnitsel@redhat.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Fri, 2020-05-15 at 11:48 -0700, James Bottomley wrote:
> On Fri, 2020-05-15 at 02:30 -0700, Jerry Snitselaar wrote:
> > On Fri May 15 20, Jarkko Sakkinen wrote:
> > > On Thu, May 14, 2020 at 08:44:23PM -0700, James Bottomley wrote:
> [...]
> > > > However, I don't have keyctl_read_alloc in my tree, so it may be
> > > > an incompatibility with another patch set.  What's your base and
> > > > what other patches do you have applied?
> > > 
> > > http://git.infradead.org/users/jjs/linux-tpmdd.git
> > > 
> > > Or exactly:
> > > 
> > > git://git.infradead.org/users/jjs/linux-tpmdd.git (master)
> > > 
> > > /Jarkko
> > > 
> > 
> > keyctl_read_alloc is in the userspace keyctl program, right?
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git
> 
> Hm, right thanks!  I just confirmed that linux-tpmdd.git with these
> patches applied still works for me.  I'm using the keyctl in debian
> testing, which identifies itself as version 1.6-6
> 
> I'll try building from git.
> James

Can you run the same exact command sequence that I posted?

/Jarkko
