From: Sasha Levin <sashal@kernel.org>
Date: Thu, 31 Oct 2019 15:36:00 +0000
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key create or update
Message-Id: <20191031153600.GR1554@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
 <20191031011910.2574-2-nramas@linux.microsoft.com>
 <20191031091041.GO1554@sasha-vm>
 <af591616-ac80-c862-6822-d11addeabb91@linux.microsoft.com>
In-Reply-To: <af591616-ac80-c862-6822-d11addeabb91@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, prsriva@linux.microsoft.com

On Thu, Oct 31, 2019 at 08:27:47AM -0700, Lakshmi Ramasubramanian wrote:
>On 10/31/19 2:10 AM, Sasha Levin wrote:
>
>Hi Sasha,
>
>>On Wed, Oct 30, 2019 at 06:19:02PM -0700, Lakshmi Ramasubramanian wrote:
>>>Asymmetric keys used for verifying file signatures or certificates
>>>are currently not included in the IMA measurement list.
>>>
>>>This patch defines a new IMA hook namely ima_post_key_create_or_update()
>>>to measure asymmetric keys.
>>>
>>>Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>
>>What are the prerequisites for this patch?
>
>I built this patch set on kernel v5.3
>
>I applied the following patch provided by Nayna Jain@IBM and then 
>added my changes:
>
>	[PATCH v9 5/8] ima: make process_buffer_measurement() generic

$ git checkout v5.3
HEAD is now at 4d856f72c10ec Linux 5.3
$ git am ~/incoming/_PATCH_v9_5-8_ima_make_process_buffer_measurement__generic.patch
Applying: ima: make process_buffer_measurement() generic
error: patch failed: security/integrity/ima/ima.h:217
error: security/integrity/ima/ima.h: patch does not apply

What am I missing?

-- 
Thanks,
Sasha
