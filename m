From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 18 Sep 2018 11:30:12 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <1537270212.3424.4.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1809061007140.23269@namei.org>
	<12101.1536420374@warthog.procyon.org.uk>
	<1537254055.20009.64.camel@infradead.org>
In-Reply-To: <1537254055.20009.64.camel@infradead.org>
To: linux-security-module@vger.kernel.org

On Tue, 2018-09-18 at 08:00 +0100, David Woodhouse wrote:
> 
> On Sat, 2018-09-08 at 16:26 +0100, David Howells wrote:
> > Marcel Holtmann <marcel@holtmann.org> wrote:
> > 
> > > 
> > > so I have reviewed and tested this code. In addition, we have
> > > test cases for it in ELL (embedded linux library).
> > 
> > I wonder if there's any practical way to add a test for this to the
> > keyutils test suite.  I'm guessing it's quite tricky, given the
> > extra bits you need to emulate the TPM.
> 
> Right, for a lot of userspace stuff we have the TPM emulator but for
> the kernel you might need to run in qemu, which I believe can emulate
> a TPM now (or at least, can talk to the TPM emulator, which has the
> same effect).

Actually, you don't necessarily.  I use this patch:

https://marc.info/?l=tpmdd-devel&m8392353230117

Which allows me to make a TCP connection to the software TPM running in
userspace without having to have the TPM components in qemu (or even to
run virtual).  I used it to debug all the in-kernel resource manager
patches.  It's TPM 2.0, but could easily be modified to work with 1.2

James
