From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sat, 16 May 2020 09:59:34 +0000
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-Id: <1668d149a6604c598f87368a3ef7a9140cf7eb51.camel@linux.intel.com>
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
In-Reply-To: <20200515093000.naogi4a7j22bzggz@cantor>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Fri, 2020-05-15 at 02:30 -0700, Jerry Snitselaar wrote:
> On Fri May 15 20, Jarkko Sakkinen wrote:
> > On Thu, May 14, 2020 at 08:44:23PM -0700, James Bottomley wrote:
> > > On Fri, 2020-05-15 at 05:22 +0300, Jarkko Sakkinen wrote:
> > > > On Thu, 2020-05-14 at 17:31 +0300, Jarkko Sakkinen wrote:
> > > > > I'm compiling now kernel with all series included.
> > > > > 
> > > > > Kind of checking if I could just take the whole series. Let see.
> > > > > 
> > > > > In all cases I want the style errors in 3/8 to be fixes with a
> > > > > helper
> > > > > but maybe better to hold before sending anything. Possibly that is
> > > > > all
> > > > > needed I'll just carve that patch myself.
> > > > > 
> > > > > Please don't do anything for the moment.
> > > > 
> > > > This is what I tried first (with the full series applied):
> > > > 
> > > > #!/bin/sh
> > > > 
> > > > die()
> > > > {
> > > > 	keyctl clear @u
> > > > 	./tpm2-flush --all-transient
> > > > 	exit $1
> > > > }
> > > > 
> > > > KEYHANDLE=$(./tpm2-root-key || die 1)
> > > > KEYID=$(keyctl add trusted kmk "new 32 keyhandle=$KEYHANDLE
> > > > hash=sha256" @u || die 1)
> > > > 
> > > > echo "$KEYID ($KEYHANDLE)"
> > > > 
> > > > keyctl pipe $KEYID > blob.hex || die 1
> > > > keyctl clear @u || die 1
> > > > 
> > > > echo "Import key from blob"
> > > > 
> > > > keyctl add trusted kmk "load `cat blob.hex` keyhandle=$KEYHANDLE" @u
> > > > > > die 1
> > > > 
> > > > die 0
> > > > 
> > > > Result:
> > > > 
> > > > sudo ./keyctl-smoke.sh
> > > > 566201053 (0x80000000)
> > > > keyctl_read_alloc: Permission denied
> > > 
> > > Well, it's clearly failing in keyctl pipe
> > > 
> > > I do confess to never having tested a volatile primary, but I just did
> > > so and it works for me.  I will also add the keyhandle in the load
> > > isn't necessary, because it should be in the blob, but there should
> > > also be no harm (just tested).
> > > 
> > > However, I don't have keyctl_read_alloc in my tree, so it may be an
> > > incompatibility with another patch set.  What's your base and what
> > > other patches do you have applied?
> > 
> > http://git.infradead.org/users/jjs/linux-tpmdd.git
> > 
> > Or exactly:
> > 
> > git://git.infradead.org/users/jjs/linux-tpmdd.git (master)
> > 
> > /Jarkko
> > 
> 
> keyctl_read_alloc is in the userspace keyctl program, right?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git

Yes.

/Jarkko
