From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 19 Mar 2020 18:59:06 +0000
Subject: Re: [PATCH v8 6/8] security: keys: trusted: add PCR policy to TPM2 keys
Message-Id: <1584644346.3610.31.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200310051607.30334-7-James.Bottomley@HansenPartnership.com>
         <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
         <3180901.1584637023@warthog.procyon.org.uk>
In-Reply-To: <3180901.1584637023@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Thu, 2020-03-19 at 16:57 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > keyctl new 32 keyhandle=0x81000001 hash=sha1
> > pcrinfo0000016768033e216468247bd
> > 031a0a2d9876d79818f8f" @u
> 
> I think part of this got lost.  There's only one '"' for a start.

Yes, it's a cut and paste error in the change log.  It was cut out of
the additions to Documentation/security/keys/trusted-encrypted.rst and
should read

keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1 pcrinfo0000016768033e216468247bd031a0a2d9876d79818f8f" @u

James
