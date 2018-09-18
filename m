From: David Howells <dhowells@redhat.com>
Date: Tue, 18 Sep 2018 15:50:33 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <14067.1537285833@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<1537253993.20009.62.camel@infradead.org>
In-Reply-To: <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
To: linux-security-module@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> wrote:

>   openssl asn1parse -inform pem -in /tmp/privkey.2048.tpm -noout \
> 			-out /tmp/privkey.2048.der

You can use "... -out - | ..." instead.

David
