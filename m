From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 23 Oct 2018 11:10:57 +0000
Subject: Re: [PATCH v2 4/4] sign-file: add explicit engine specification
Message-Id: <1540293057.2881.2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1540205281.2815.12.camel@HansenPartnership.com>
In-Reply-To: <1540205281.2815.12.camel@HansenPartnership.com>
To: keyrings@vger.kernel.org

On Mon, 2018-10-22 at 12:38 +0100, David Woodhouse wrote:
> On Mon, 2018-10-22 at 11:48 +0100, James Bottomley wrote:
> > This commit adds an optional -e <engine> argument to sign
> > file.  Now that we have the explicit engine addition, the original
> > pkcs11 token implementation can also be merged into this code
> > (using UI methods for getting the key instead of the engine control
> > command).  To keep the code functioning the same way (no need to
> > specify the pkcs11 engine if the key file begins pkcs11:) an
> > explicit check will set the engine to pkcs11 if a pkcs11 key
> > specifier is detected.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> 
> Acked-if-you-tested-it-with-PKCS#11-by: David Woodhouse <dwmw@amazon.
> co.uk>

It was a right royal pain, but I have tested it with softhsm+p11lib
engine and it all (amazingly) seems to work with correct pkcs11 URLs
... just don't ask me to do it again.

James
