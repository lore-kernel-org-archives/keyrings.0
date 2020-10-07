From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 07 Oct 2020 03:15:08 +0000
Subject: Re: [PATCH v2] encrypted-keys: Print more useful debug info if encryption algo is not available
Message-Id: <20201007031508.GB143690@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20201005225258.200181-1-anatol.pomozov@gmail.com>
In-Reply-To: <20201005225258.200181-1-anatol.pomozov@gmail.com>
To: keyrings@vger.kernel.org

On Tue, Oct 06, 2020 at 08:33:24PM -0400, Mimi Zohar wrote:
> On Wed, 2020-10-07 at 02:39 +0300, Jarkko Sakkinen wrote:
> > On Tue, Oct 06, 2020 at 10:18:43AM -0700, Anatol Pomozov wrote:
> > > Hi
> > > 
> > > On Tue, Oct 6, 2020 at 8:59 AM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > On Tue, Oct 06, 2020 at 06:56:28PM +0300, Jarkko Sakkinen wrote:
> > > > > On Mon, Oct 05, 2020 at 03:52:58PM -0700, Anatol Pomozov wrote:
> > > > > > It helps to improve a cryptic message "encrypted_key failed to alloc_cipher (-2)".
> > > > > > Adding algo name makes it easier to understand what cipher has failed.
> > > > > >
> > > > > > Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> > > > >
> > > > > NAK, because you are missing David Howells from the CC list.
> > > >
> > > > Oh and also me. You are essentially missing all the keyring maintainers.
> > > 
> > > The MAINTAINERS file states following:
> > > 
> > > KEYS-ENCRYPTED
> > > M:      Mimi Zohar <zohar@linux.ibm.com>
> > > L:      linux-integrity@vger.kernel.org
> > > L:      keyrings@vger.kernel.org
> > > S:      Supported
> > > F:      Documentation/security/keys/trusted-encrypted.rst
> > > F:      include/keys/encrypted-type.h
> > > F:      security/keys/encrypted-keys/
> > > 
> > > Everything seems fine as I included the official maintainer and the
> > > project maillist.
> > > 
> > > If David is not subscribed to the project maillist I'll be glad to CC
> > > him as well.
> > 
> > Ugh, you are right then. Those two lists still confuse me thought
> > but that is not your fault.
> 
> Please refer to Documentation/security/keys/trusted-encrypted.rst for
> an explanation.

Yeah, I was not sure about the organization and just spotted keyrings
in the CC list :-)

> 
> > 
> > Based on that I can give my ack because the change looks right
> > still.
> > 
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Thanks for explaining the situation.
> 
> Thanks, Jarrko.  I'm on vacation, returning next week.

Have a good one!

> Mimi

/Jarkko
