From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 21 Nov 2019 01:32:03 +0000
Subject: Re: [PATCH v8 2/5] IMA: Define an IMA hook to measure keys
Message-Id: <21c08fdf-43d7-67e0-1cb5-66bdbce1b6ad@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-3-nramas@linux.microsoft.com>
 <ED63593E-BE9B-40B7-B7FD-9DE772DC2EB1@oracle.com>
 <98eeec95-cc19-2900-b96e-eadaac1b4a68@linux.microsoft.com>
 <1574299330.4793.158.camel@linux.ibm.com>
In-Reply-To: <1574299330.4793.158.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Eric Snowberg <eric.snowberg@oracle.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 11/20/19 5:22 PM, Mimi Zohar wrote:

>> I had the following check in process_buffer_measurement() as part of my
>> patch, but removed it since it is being upstreamed separately (by Mimi)
>>
>>    if (!ima_policy_flag)
>>    	return;
> 
> Did you post it as a separate patch?  I can't seem to find it.
> 
> Mimi

No - I removed the above change from my patch since you mentioned it's 
being upstreamed separately.

I didn't realize you wanted me to include the above change alone in a 
separate patch (in my patch set). Sorry - I guess I misunderstood.

I can do that when I send an update - I expect to by the end of this week.

thanks,
  -lakshmi
