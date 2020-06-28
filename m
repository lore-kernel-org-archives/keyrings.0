From: Alexey Krasikov <alexey_krasikov@mail.ru>
Date: Sun, 28 Jun 2020 00:27:37 +0000
Subject: Re: [RFC PATCH 0/1] security/keys: remove possessor verify after key
Message-Id: <5b6f4d9c-ef6f-d456-096f-4673c85d4dbd@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200529081527.GC1376838@linux.intel.com>
In-Reply-To: <20200529081527.GC1376838@linux.intel.com>
To: keyrings@vger.kernel.org

On 6/23/20 4:28 AM, Jarkko Sakkinen wrote:
> On Mon, Jun 22, 2020 at 02:30:28PM +0200, Greg KH wrote:
>> On Mon, Jun 22, 2020 at 12:04:29PM +0300, Alexey Krasikov wrote:
>>> On 6/15/20 8:00 PM, Jarkko Sakkinen wrote:
>>>> On Tue, Jun 02, 2020 at 01:30:52PM +0300, Alexey Krasikov wrote:
>>>>> On Mon, June 1, 2020 at 08:34PM +300, Jarkko Sakkinen wrote:
>>>>>> On Fri, May 29, 2020 at 09:00:39AM +0300, Alexey Krasikov wrote:
>>>>>>> $ KEYID=$(keyctl add user john smith @u)
>>>>>>> $ keyctl describe $KEYID
>>>>>>> 5927639: alswrv-----v------------  1000  1000 user: john
>>>>>>> $ keyctl setperm $KEYID 0x3d000000
>>>>>>> $ keyctl describe $KEYID
>>>>>>> 5927639: alsw-v-----v------------  1000  1000 user: john
>>>>>>> $ keyctl print $KEYID
>>>>>>> smith
>>>>>> A keyring default permissions are 0x3f3f0000.
>>>>>> A key default permissions are 0x3f010000.
>>>>>>
>>>>>> Because of this:
>>>>>>
>>>>>> $ KEYID=$(keyctl add user john smith @u)
>>>>>> $ keyctl setperm $KEYID 0x3d000000
>>>>>> keyctl_setperm: Permission denied
>>>>>>
>>>>>> Are you sure that your example is correct?
>>>>>>
>>>>>> /Jarkko
>>>>> Yes, this example works correctly.
>>>>>
>>>>> Why do you think, that the current keyring and key rights
>>>>>
>>>>> shoukd not allow this to be done?
>>>> I'm just saying that I cannot figure out your point in the cover letter.
>>>> It contains random dumps of keyctl output.
>>>>
>>>> Maybe a better idea would be to write a test script that demonstrates
>>>> the issue?
>>>>
>>>> /Jarkko
>>> + alexey_krasikov@mail.ru
>>>
>>> Possible you may not be able to reproduce the problem because you have a
>>> different version of Linux.
>>>
>>> I get to reproduce the problem on two systems:
>>>
>>> Linux 4.14.74-28+yc11.91
>>>
>>> and
>>>
>>> Linux ubuntu 4.15.0-106-generic
>> Both of those are distro-specific kernels, can you reproduce this on
>> 5.8-rc2 or 5.7 as released from kernel.org?
> Alexey,
>
> A shell script containing the keyctl command chain with some output, and
> then your version of the output when running the script would be also
> very useful for better comparison.
>
> /Jarkko

Ok. I have the following script:

----------------------------------------------------------------------------
#!/usr/bin/sh

uname -r

KEYID=$(keyctl add user john smith @u)
keyctl describe $KEYID
keyctl setperm $KEYID 0x3d000000
keyctl describe $KEYID
keyctl print $KEYID
----------------------------------------------------------------------------

I installed the Manjaro distribution, updated the kernel to version 5.7.0-3,
and when running this script, I got the following output:

****************************************************************************
5.7.0-3-MANJARO
914983072: alswrv-----v------------  1000  1000 user: john
914983072: alsw-v------------------  1000  1000 user: john
smith
****************************************************************************

In fairness, I note that none of these distro-specific kernels
does not change the work logic of the Linux keyring.

/Alexey
