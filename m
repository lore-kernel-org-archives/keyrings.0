From: David Howells <dhowells@redhat.com>
Date: Tue, 18 Sep 2018 17:18:37 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <20622.1537291117@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <c33c759d-9243-8885-7c5f-667681b759c2@gmail.com>
	<14f91823-474e-1b46-d305-12229dac8967@gmail.com>
	<0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
	<fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<1537253993.20009.62.camel@infradead.org>
	<14067.1537285833@warthog.procyon.org.uk>
	<745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
	<19247.1537288419@warthog.procyon.org.uk>
	<23698.1537289705@warthog.procyon.org.uk>
In-Reply-To: <c33c759d-9243-8885-7c5f-667681b759c2@gmail.com>
To: linux-security-module@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> wrote:

> > Yes.  It shouldn't be much code, either.  You still have to check for X.509
> > DER since the kernel currently supports that.
> 
> For reasons of backward compatibility, correct?  The kernel also has
> mscode.asn1 which we would need to support as well.  Since we can't break
> compatibility then perhaps this doesn't buy us a whole lot in the end.

Don't worry about mscode - that's not an asymmetric key parser.  That's only
ever used directly from verify_pefile_signature().

Currently, we have to retain support for DER-encoded X.509.

But there's no reason we can't have a PEM parser that decodes the PEM and
selects X.509, PKCS#8 or TPM based on the ascii header in that.  PKCS#8 and
TPM don't need to take DER directly.

David
