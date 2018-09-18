From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 18 Sep 2018 17:00:49 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <c33c759d-9243-8885-7c5f-667681b759c2@gmail.com>
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
	<23698.1537289705@warthog.procyon.org.uk>
In-Reply-To: <23698.1537289705@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Hi David,

On 09/18/2018 11:55 AM, David Howells wrote:
> Denis Kenzior <denkenz@gmail.com> wrote:
> 
>> In theory the PEM file already contains the type of the certificate, at least
>> at a high level.  E.g. private, public, tpm.  So if we accept PEM files
>> directly that could be potentially a faster way of determining the parser to
>> use and would still work with keyctl update/instantiate, right?
> 
> Yes.  It shouldn't be much code, either.  You still have to check for X.509
> DER since the kernel currently supports that.

For reasons of backward compatibility, correct?  The kernel also has 
mscode.asn1 which we would need to support as well.  Since we can't 
break compatibility then perhaps this doesn't buy us a whole lot in the end.

Regards,
-Denis
