From: David Woodhouse <dwmw2@infradead.org>
Date: Tue, 10 Dec 2019 22:37:31 +0000
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
Message-Id: <35B37965-359E-40E0-8F44-836A56EC4756@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1575984010.3459.4.camel@HansenPartnership.com> <1575936272.31378.50.camel@HansenPartnership.com> <1575936367.31378.52.camel@HansenPartnership.com> <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org> <10037.1575986929@warthog.procyon.org.uk> <1576004020.3647.13.camel@HansenPartnership.com>
In-Reply-To: <1576004020.3647.13.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, David Howells <dhowells@redhat.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org



On 10 December 2019 18:53:40 GMT, James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>On Tue, 2019-12-10 at 14:08 +0000, David Howells wrote:
>>   Please therefore put bounds checking and error handling in it.  And
>> please *don't* just produce broken ASN.1 when something goes wrong.
>
>OK, I'll make it return an error and add a wrapper for my use case that
>warns on error and causes the function to bail.

Traditionally we call that "error handling" :p

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
