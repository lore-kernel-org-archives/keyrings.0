From: David Howells <dhowells@redhat.com>
Date: Tue, 18 Sep 2018 15:02:11 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <20342.1537282931@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1537253993.20009.62.camel@infradead.org>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
In-Reply-To: <1537253993.20009.62.camel@infradead.org>
To: linux-security-module@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:

> Those examples aren't equivalent

No one said that they are.

But if you really can't figure it out, I can add:

	openssl genrsa -out private_key.pem 2048

at the front of the PKCS#8 example;-)

I can even change the examples to have the same private key name.

> For the PKCS#8 blob you are first using openssl to convert from an encrypted
> PKCS#8 PEM to unencrypted DER, presumably because you haven't added
> decryption support (or base64 decode) to keyctl yet.

It would probably be done in the kernel rather than keyctl.  If it's done in
userspace, there's no need to do it in keyctl.  The PKCS#8 parser is primarily
a test port - especially as it doesn't need anything like a TPM.

It's of limited real utility, I think, because even if the blob is encrypted
and you can pass the decryption password to the kernel, the password still has
to be present in userspace, however briefly.

> For the TPM example though, you are also showing the *generation* of
> the key, and importing it into the TPM. And then I'm confused by the
> 'openssl asn1parse' line there... what is that actually doing?

It's meant to be stripping off the PEM wrapper and outputting the DER, but see
below.

> If I run it on a '-----BEGIN TSS KEY BLOB-----' file I have lying around, I
> get no output at all.

I lost a bit from the cover note.  It needs "-out -" attaching.

	openssl asn1parse -inform pem -in modulekey1.priv -noout -out - | wc -c

David
