From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 28 Oct 2019 14:58:36 +0000
Subject: Re: [PATCH v2 1/4] KEYS: Defined an ima hook for measuring keys on key create or update
Message-Id: <1d7730ff-9847-c6be-4f4f-8cf1e90a71f2@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
 <20191023233950.22072-2-nramas@linux.microsoft.com>
 <1572032428.4532.72.camel@linux.ibm.com>
 <c1de8055-89a7-25dd-d99a-427e2c2c4c59@linux.microsoft.com>
 <1572187644.4532.211.camel@linux.ibm.com>
In-Reply-To: <1572187644.4532.211.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 10/27/19 7:47 AM, Mimi Zohar wrote:

>>> There's no reason to define a new variable to determine if IMA is
>>> initialized.  Use ima_policy_flag.
>>
>> Please correct me if I am wrong -
>>
>> ima_policy_flag will be set to 0 if IMA is not yet initialized
>> OR
>> IMA is initialized, but ima_policy_flag could be still set to 0 (say,
>> due to the configured policy).
>>
>> In the latter case the measurement request should be a NOP immediately.
> 
> I'm not sure.  The builtin keys most likely will be loaded prior to a
> custom IMA policy containing "keyring" rules are defined.
> 
> Mimi

I am not sure if I described it clearly - let me clarify:

Say, we use ima_policy_flag to determine whether to
measure the key immediately or
queue the key for measurement and, measure when IMA is initialized.

We can incorrectly keep queuing keys in the case when IMA is 
initialized, but due to the way IMA policy is configured ima_policy_flag 
is still 0.

That's why I feel a separate boolean flag would be needed to know 
whether IMA is initialized or not.

If IMA is initialized, ima_policy_flag will dictate whether to measure 
the key or not.

thanks,
  -lakshmi
