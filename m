From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 21 Nov 2019 00:03:05 +0000
Subject: Re: [PATCH v8 4/5] IMA: Add support to limit measuring keys
Message-Id: <fef8fc67-643d-e579-9628-6516fd02b4db@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-5-nramas@linux.microsoft.com>
 <1574291957.4793.144.camel@linux.ibm.com>
In-Reply-To: <1574291957.4793.144.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 11/20/2019 3:19 PM, Mimi Zohar wrote:

Hi Mimi,

>> The above can be used to correlate the key measurement IMA entry,
>> ima-sig and ima-modsig entries using the same key.
> 
> True, but associating the public key measurement with the file
> signature requires information from the certificate (e.g. issuer,
> serial number, and/or subject, subject keyid).
> 
> For a regression test, it would be nice if the key measurement,
> itself, contained everything needed in order to validate the file
> signatures in the measurement list.

I am just trying to understand your asks - Please clarify:

1, My change includes only the public key and not the entire certificate 
information in the measured buffer.

Should I update this current patch set to measure the entire cert. Or, 
can that be done as a separate patch set?

2, Should a regression test be part of this patch set for the key 
measurement changes to be accepted?

thanks,
  -lakshmi
