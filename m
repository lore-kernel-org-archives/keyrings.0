From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 04 Jul 2019 12:25:16 +0000
Subject: Re: Problem with the kernels trusted module on "inactive" TPM
Message-Id: <cb46e05d-f9bd-2d58-0996-390cfbf6f786@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CACnrVGfhkpsSWbCai4+5WEOhRukEr7JWDUnFdM-5D+FUyov+nQ@mail.gmail.com>
 <f4b36912-0fb0-1e83-1ad2-fb1d2313c08e@huawei.com>
 <4e3579a4d84aa7e2c80e5068eb1f7a30e17a655b.camel@linux.intel.com>
In-Reply-To: <4e3579a4d84aa7e2c80e5068eb1f7a30e17a655b.camel@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, CrazyT <crazyt2019+lml@gmail.com>, keyrings@vger.kernel.org
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, jejb@linux.ibm.com, zohar@linux.ibm.com

On 7/4/2019 12:42 PM, Jarkko Sakkinen wrote:
> On Mon, 2019-07-01 at 17:22 +0300, Roberto Sassu wrote:
>> Adding to the discussion Jarkko (the maintainer of the trusted key) and
>> the linux-integrity mailing list.
> 
> I'm a co-maintainer (added James and Mimi).
> 
>>> some people (including me) have problems with the "trusted" kernel module.
>>> As a result to this also the ecryptfs-module won't load.
>>> (https://bugs.archlinux.org/task/62678)
>>> If you use an "inactive" TPM module, the "trusted" module won't load
>>> anymore.
>>> The command modprobe just responds with "Bad address".
>>> The strace-command shows that init_module fails with EFAULT.
>>> I believe the reason for this is that the trusted-module handles
>>> inactive modules the same as active modules.
>>> This results in an error.
>>>
>>> For example:
>>>
> https://github.com/torvalds/linux/commit/0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400#diff-c01228e6d386afb29df6aac17d9dd7abR1251
>>>
>>> My guess is that init_digests(); returns EFAULT in that case.
>>> The " if (!chip)" check above probably needs to check if the chip is
>>> "inactive".
>>>
>>> "inactive" = still visible to the system, but not functional.
>>> It seems to be the default bios-setting for TPM on thinkpad.
>>> (btw.: i have no clue why anybody would need something like that)
>>>
>>> Sadly i have no idea how you would check for an inactive chip,else i
>>> would have send a patch instead.
>>> But I hope the info i wrote is enough to get it fixed by somebody.
>>
>> Thanks for the report. If you see -EFAULT, tpm_get_random() is probably
>> returning 0.
>>
>> Jarkko, we could consider it as non-critical error, and handle it as if
>> the TPM is not found. What do you think?
> 
> Not sure I get this. Wasn't the issue fixed in c78719203fc6 or is there
> something missing?

It seems it is not enough. A TPM is found but does not return data to
tpm_get_random(), I think.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
