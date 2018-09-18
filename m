From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 18 Sep 2018 05:51:07 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <14f91823-474e-1b46-d305-12229dac8967@gmail.com>
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
	<19247.1537288419@warthog.procyon.org.uk>
In-Reply-To: <19247.1537288419@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Hi David,

> It passes it to each parser in turn till one says it can parse it.  It's not
> ideal, but it seems to work - so far.  Better would be to annotate it in some
> way.  I have considered annotating the type field so that the payload doesn't
> have to have it added:
> 
> 	keyctl padd asymmetric.x509 "" @s </tmp/foo.x509
> 	keyctl padd asymmetric.pkcs#8 ...
> 	keyctl padd asymmetric.tpm ...
> 
> However, this doesn't work with "keyctl update" or "keyctl instantiate".
> 

In theory the PEM file already contains the type of the certificate, at 
least at a high level.  E.g. private, public, tpm.  So if we accept PEM 
files directly that could be potentially a faster way of determining the 
parser to use and would still work with keyctl update/instantiate, right?

Regards,
-Denis
