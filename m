From: David Howells <dhowells@redhat.com>
Date: Tue, 18 Sep 2018 16:55:05 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <23698.1537289705@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <14f91823-474e-1b46-d305-12229dac8967@gmail.com>
	<0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
	<fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<1537253993.20009.62.camel@infradead.org>
	<14067.1537285833@warthog.procyon.org.uk>
	<745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
	<19247.1537288419@warthog.procyon.org.uk>
In-Reply-To: <14f91823-474e-1b46-d305-12229dac8967@gmail.com>
To: linux-security-module@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> wrote:

> In theory the PEM file already contains the type of the certificate, at least
> at a high level.  E.g. private, public, tpm.  So if we accept PEM files
> directly that could be potentially a faster way of determining the parser to
> use and would still work with keyctl update/instantiate, right?

Yes.  It shouldn't be much code, either.  You still have to check for X.509
DER since the kernel currently supports that.

David
