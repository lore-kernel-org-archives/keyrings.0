From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 22 Aug 2018 14:19:56 +0000
Subject: Re: tpm: Provide a TPM access library
Message-Id: <20180822141956.GA28110@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

On Tue, Aug 21, 2018 at 04:56:49PM +0100, David Howells wrote:
> 
> Hi Denis, Jarkko, James,
> 
> I managed to recover the TPM library patchset that I was working on about four
> years ago in the process of trying to write an asymmetric key subtype that
> could use the TPM.
> 
> Here it is in it's original glory for reference.  I ended up leaving it
> because Jarkko's tpm-2 stuff broke it and I had other things to work on.  If
> it's deemed worthwhile, I can try to forward port it to current Linus/mastet.
> 
> Note that one or two of the preliminary patches may be upstream.
> 
> The patches can also be found here:
> 
> 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=tpm-lib

Just a minor overal complaint: lower case for tags (please do not send
a newer version just because of that  before I have time to review this).
Thank you.

/Jarkko
