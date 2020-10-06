From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Tue, 06 Oct 2020 17:18:43 +0000
Subject: Re: [PATCH v2] encrypted-keys: Print more useful debug info if encryption algo is not available
Message-Id: <CAOMFOmWbxPZ4=XKPkX89DaGhGez94NZopexYUj7hA7rDXb9x0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20201005225258.200181-1-anatol.pomozov@gmail.com>
In-Reply-To: <20201005225258.200181-1-anatol.pomozov@gmail.com>
To: keyrings@vger.kernel.org

Hi

On Tue, Oct 6, 2020 at 8:59 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Oct 06, 2020 at 06:56:28PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Oct 05, 2020 at 03:52:58PM -0700, Anatol Pomozov wrote:
> > > It helps to improve a cryptic message "encrypted_key failed to alloc_cipher (-2)".
> > > Adding algo name makes it easier to understand what cipher has failed.
> > >
> > > Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> >
> > NAK, because you are missing David Howells from the CC list.
>
> Oh and also me. You are essentially missing all the keyring maintainers.

The MAINTAINERS file states following:

KEYS-ENCRYPTED
M:      Mimi Zohar <zohar@linux.ibm.com>
L:      linux-integrity@vger.kernel.org
L:      keyrings@vger.kernel.org
S:      Supported
F:      Documentation/security/keys/trusted-encrypted.rst
F:      include/keys/encrypted-type.h
F:      security/keys/encrypted-keys/

Everything seems fine as I included the official maintainer and the
project maillist.

If David is not subscribed to the project maillist I'll be glad to CC
him as well.
