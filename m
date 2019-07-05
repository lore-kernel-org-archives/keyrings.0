From: Nayna <nayna@linux.vnet.ibm.com>
Date: Fri, 05 Jul 2019 15:20:53 +0000
Subject: Re: [PATCH] Revert "tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()"
Message-Id: <abcc3748-8471-8965-046e-9d9431b4f0e9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190701131505.17759-1-msuchanek@suse.de>
 <8e4cc105b748c5395132b4d3d29d0d9b30a8720c.camel@linux.intel.com>
 <cf2ea579-41c2-42da-2df3-0b1f12e1c639@huawei.com>
 <1562240882.6165.78.camel@linux.ibm.com>
 <1562255201.6165.143.camel@linux.ibm.com> <20190704195857.GB6105@elm>
In-Reply-To: <20190704195857.GB6105@elm>
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Michal Suchanek <msuchanek@suse.de>, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, James Bottomley <jejb@linux.ibm.com>, David Howells <dhowells@redhat.com>, Tomas Winkler <tomas.winkler@intel.com>, Armijn Hemel <armijn@tjaldur.nl>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Jerry Snitselaar <jsnitsel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org

Hi Tyler,


On 07/04/2019 03:58 PM, Tyler Hicks wrote:
> Hey Mimi!
>
> On 2019-07-04 11:46:41, Mimi Zohar wrote:
>> Hi Jarkko,
>>
>> On Thu, 2019-07-04 at 07:48 -0400, Mimi Zohar wrote:
>>> On Thu, 2019-07-04 at 13:28 +0200, Roberto Sassu wrote:
>>>> On 7/4/2019 12:03 PM, Jarkko Sakkinen wrote:
>>>>> On Mon, 2019-07-01 at 15:15 +0200, Michal Suchanek wrote:
>>>>>> This reverts commit 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400 to avoid
>>>>>> following crash:
>>>>> Thank you. I think this the right choice for the moment. I fixed
>>>>> a trivial checkpatch.pl error and added the mandatory tags. Can
>>>>> you check quickly v2 (just posted)?
>>>>>
>>>>> I already made it available in my master and next.
>>>> Could you please wait few days? I would prefer to fix this issue instead
>>>> of reverting the whole patch.
>>> Nayna posted a patch late yesterday titled "tpm: fixes uninitialized
>>> allocated banks for IBM vtpm driver", which addresses this bug.
>> Now with my review, and with Sachin Sant's and Michal Suchánek
>> testing, instead of reverting this patch could you pick up Nayna's
>> patch instead?
> It looks to me like the revert would also fix a bug that is keeping the
> eCryptfs module from loading when the TPM is in an "inactive" state:
>
>    https://bugzilla.kernel.org/show_bug.cgi?id 3953
>
> I just noticed that it was recently discussed here, too:
>
>    https://lore.kernel.org/linux-integrity/1562244125.6165.95.camel@linux.ibm.com/T/#t
>
> I believe that the revert would fix it because the call to
> init_digests()/tpm_get_random() would no longer be in the path of
> loading ecryptfs.ko (which depends on encrypted-keys.ko, which depends
> on trusted.ko).
>
> If the revert isn't used, we'll need a different fix for bug 203953. It
> should be an easy fix but I don't want it to be forgotten.


I think if TPM is inactive/disabled, it needs to be handled during 
tpm_chip_register() itself. However, probably that needs more analysis 
and discussion. For now, in context of the trusted.ko module, it seems 
init_trusted() should "put_device", but continue even if init_digests() 
fails, that will fix the issue.


Thanks & Regards,
         - Nayna
