From: David Howells <dhowells@redhat.com>
Date: Tue, 18 Sep 2018 16:33:39 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <19247.1537288419@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
	<fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<1537253993.20009.62.camel@infradead.org>
	<14067.1537285833@warthog.procyon.org.uk>
	<745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
In-Reply-To: <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
To: linux-security-module@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:

> You are passing the raw DER to the kernel in both cases, right?

I haven't put a PEM stripper and base64 decoder into the kernel, though we
certainly could do that.  We could even do the decode in-place in the same
buffer since the resulting data would be smaller than the original.

> And the kernel just happens to know that if it receives a bare OCTET-STRING
> it's supposed to treat it as a TPMv1.2 key?

It passes it to each parser in turn till one says it can parse it.  It's not
ideal, but it seems to work - so far.  Better would be to annotate it in some
way.  I have considered annotating the type field so that the payload doesn't
have to have it added:

	keyctl padd asymmetric.x509 "" @s </tmp/foo.x509
	keyctl padd asymmetric.pkcs#8 ...
	keyctl padd asymmetric.tpm ...

However, this doesn't work with "keyctl update" or "keyctl instantiate".

David
