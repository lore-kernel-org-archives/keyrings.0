From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 18 Sep 2018 05:41:59 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <2c5a34af-c2ae-b98c-e5d3-d89462ad3a20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<1537253993.20009.62.camel@infradead.org>
	<14067.1537285833@warthog.procyon.org.uk>
	<745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
	<0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
In-Reply-To: <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
To: linux-security-module@vger.kernel.org

Hi David,

On 09/18/2018 11:17 AM, David Woodhouse wrote:
> On Tue, 2018-09-18 at 00:24 -0500, Denis Kenzior wrote:
>> Hi David,
>>
>> On 09/18/2018 10:50 AM, David Howells wrote:
>>> Denis Kenzior <denkenz@gmail.com> wrote:
>>>
>>>>      openssl asn1parse -inform pem -in /tmp/privkey.2048.tpm -noout \
>>>>                        -out /tmp/privkey.2048.der
>>>
>>> You can use "... -out - | ..." instead.
>>
>> Aha! okay, that is even more elegant.  Your openssl-fu is better than
>> mine :)
> 
> 'grep -v ^----- | base64 -d' also works most of the time :)
> 
> You are passing the raw DER to the kernel in both cases, right? And the
> kernel just happens to know that if it receives a bare OCTET-STRING
> it's supposed to treat it as a TPMv1.2 key?
> 

Short answer: right.

Long answer: The kernel runs all the registered parsers until all fail 
or one of them recognizes the format.  All the currently supported 
asymmetric key formats are DER based, e.g. PKCS8, PKCS7, TPM-1.2, etc. 
All these have a very specific DER structure with the TPM-1.2 being the 
simplest format.

Regards,
-Denis
