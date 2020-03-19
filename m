From: David Howells <dhowells@redhat.com>
Date: Thu, 19 Mar 2020 15:13:31 +0000
Subject: Re: [PATCH] KEYS: check the certfile for ASN1 encoding before inserting
Message-Id: <3166605.1584630811@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Clay Chang <clayc@hpe.com> wrote:

> +	if (cert[0] != 0x30 && cert[1] != 0x82) {
> +		err("Invalid certfile.\n");
> +		exit(EXIT_FAILURE);
> +	}
> +

I wonder if this is a good enough check.  It might be better to actually run
it through a utility that will actually check the structure (eg. openssl
asn1parse or openssl x509) and check the error code.

David
