From: Alexey Krasikov <alexey_krasikov@mail.ru>
Date: Mon, 13 Jul 2020 11:53:02 +0000
Subject: Re: [RFC PATCH 0/1] security/keys: remove possessor verify after key
Message-Id: <530d953e-53af-8bcf-cbab-488b1e0415ef@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200529081527.GC1376838@linux.intel.com>
In-Reply-To: <20200529081527.GC1376838@linux.intel.com>
To: keyrings@vger.kernel.org

On 7/3/20 4:14 AM, Jarkko Sakkinen wrote:
> On Sun, Jun 28, 2020 at 03:27:37AM +0300, Alexey Krasikov wrote:
>> On 6/23/20 4:28 AM, Jarkko Sakkinen wrote:
>>> On Mon, Jun 22, 2020 at 02:30:28PM +0200, Greg KH wrote:
>>>> On Mon, Jun 22, 2020 at 12:04:29PM +0300, Alexey Krasikov wrote:
>>>>> On 6/15/20 8:00 PM, Jarkko Sakkinen wrote:
>>>>>> On Tue, Jun 02, 2020 at 01:30:52PM +0300, Alexey Krasikov wrote:
>>>>>>> On Mon, June 1, 2020 at 08:34PM +300, Jarkko Sakkinen wrote:
>>>>>>>> On Fri, May 29, 2020 at 09:00:39AM +0300, Alexey Krasikov wrote:
>>>>>>>>> $ KEYID=$(keyctl add user john smith @u)
>>>>>>>>> $ keyctl describe $KEYID
>>>>>>>>> 5927639: alswrv-----v------------  1000  1000 user: john
>>>>>>>>> $ keyctl setperm $KEYID 0x3d000000
>>>>>>>>> $ keyctl describe $KEYID
>>>>>>>>> 5927639: alsw-v-----v------------  1000  1000 user: john
>>>>>>>>> $ keyctl print $KEYID
>>>>>>>>> smith
>>>>>>>> A keyring default permissions are 0x3f3f0000.
>>>>>>>> A key default permissions are 0x3f010000.
>>>>>>>>
>>>>>>>> Because of this:
>>>>>>>>
>>>>>>>> $ KEYID=$(keyctl add user john smith @u)
>>>>>>>> $ keyctl setperm $KEYID 0x3d000000
>>>>>>>> keyctl_setperm: Permission denied
>>>>>>>>
>>>>>>>> Are you sure that your example is correct?
>>>>>>>>
>>>>>>>> /Jarkko
>>>>>>> Yes, this example works correctly.
>>>>>>>
>>>>>>> Why do you think, that the current keyring and key rights
>>>>>>>
>>>>>>> shoukd not allow this to be done?
>>>>>> I'm just saying that I cannot figure out your point in the cover letter.
>>>>>> It contains random dumps of keyctl output.
>>>>>>
>>>>>> Maybe a better idea would be to write a test script that demonstrates
>>>>>> the issue?
>>>>>>
>>>>>> /Jarkko
>>>>> + alexey_krasikov@mail.ru
>>>>>
>>>>> Possible you may not be able to reproduce the problem because you have a
>>>>> different version of Linux.
>>>>>
>>>>> I get to reproduce the problem on two systems:
>>>>>
>>>>> Linux 4.14.74-28+yc11.91
>>>>>
>>>>> and
>>>>>
>>>>> Linux ubuntu 4.15.0-106-generic
>>>> Both of those are distro-specific kernels, can you reproduce this on
>>>> 5.8-rc2 or 5.7 as released from kernel.org?
>>> Alexey,
>>>
>>> A shell script containing the keyctl command chain with some output, and
>>> then your version of the output when running the script would be also
>>> very useful for better comparison.
>>>
>>> /Jarkko
>> Ok. I have the following script:
>>
>> ----------------------------------------------------------------------------
>> #!/usr/bin/sh
>>
>> uname -r
>>
>> KEYID=$(keyctl add user john smith @u)
>> keyctl describe $KEYID
>> keyctl setperm $KEYID 0x3d000000
>> keyctl describe $KEYID
>> keyctl print $KEYID
> pam_keyinit.so should create user keyring when the login session is
> created. If the user space stack is working correclty, you should not
> end up to be the possessor for the user keyring.
>
> However, I can simulate your environment with the session keyring:
>
> KEYID=`keyctl add user john smith @s`
>
> keyctl describe $KEYID
> keyctl setperm $KEYID 0x3d000000
> keyctl describe $KEYID
> keyctl print $KEYID
>
> And yes I do get:
>
> 564302411: alswrv-----v------------  1000  1000 user: john
> 564302411: alsw-v------------------  1000  1000 user: john
> smith
>
> Here's another sequence that also removes setattr:
>
> KEYID=`keyctl add user john smith @s`
>
> keyctl describe $KEYID
> keyctl setperm $KEYID 0x08000000
> keyctl describe $KEYID
> keyctl print $KEYID
>
> 700153280: alswrv-----v------------  1000  1000 user: john
> keyctl_describe_alloc: Permission denied
> smith
>
> David, this look at least with a quick sight somewhat weird: my
> possessor permissions are only "search", so why does reading the
> payload succeed?
>
> /Jarkko
ping

/Alexey
