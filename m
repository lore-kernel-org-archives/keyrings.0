From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 15 May 2020 20:10:17 +0000
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-Id: <1589573417.3653.28.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515191758.ieojyk5xhsx2hzzd@cantor>
         <1589571278.3653.22.camel@HansenPartnership.com>
In-Reply-To: <1589571278.3653.22.camel@HansenPartnership.com>
To: Jerry Snitselaar <jsnitsel@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Fri, 2020-05-15 at 12:34 -0700, James Bottomley wrote:
> On Fri, 2020-05-15 at 12:17 -0700, Jerry Snitselaar wrote:
> > On Fri May 15 20, Jarkko Sakkinen wrote:
> > > On Thu, May 14, 2020 at 08:44:23PM -0700, James Bottomley wrote:
> > > > On Fri, 2020-05-15 at 05:22 +0300, Jarkko Sakkinen wrote:
> 
> [...]
> > > > > sudo ./keyctl-smoke.sh
> > > > > 566201053 (0x80000000)
> > > > > keyctl_read_alloc: Permission denied
> > 
> > I get keyctl_read_alloc -EPERM when I 'sudo su' and try to play
> > with
> > keyctl print.
> > If I 'sudo su -' and then try it works as expected. Also works for
> > normal user.
> 
> OK, I confirm on debian as well.  If I create a key as real root and
> then try to sudo su keyctl pipe it as an ordinary user, I get EPERM.
> 
> It smells like a cockup in real vs effective permissions somewhere in
> the keyctl handler.

OK, so the problem is

sudo keyctl list @s

Still shows the session keys of the previous user

that causes sudo keyctl show on a root owned key to fail the
is_key_possessed() check, returning -EACCESS which gets translated to
EPERM

if you do

sudo su -

Then keyctl list @s shows the root session keyring and everything works

I think that means the solution is not to run the smoke test under sudo
but to do sudo -s and then run it.

James
