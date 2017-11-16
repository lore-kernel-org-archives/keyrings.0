From: James Cowgill <james.cowgill@mips.com>
Date: Thu, 16 Nov 2017 14:10:15 +0000
Subject: Re: Apply "security/keys: add CONFIG_KEYS_COMPAT to Kconfig" to stable trees
Message-Id: <a1170aa3-91c3-e09c-19ed-36425e15d874@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <26f91532-a424-5449-bf5f-5682e47fb1c4@mips.com>
 <20171116131205.GA6447@kroah.com>
In-Reply-To: <20171116131205.GA6447@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, keyrings@vger.kernel.org

Hi,

On 16/11/17 13:12, Greg KH wrote:
> On Thu, Nov 16, 2017 at 11:57:27AM +0000, James Cowgill wrote:
>> Hi,
>>
>> Is it possible to apply this commit to the stable trees before 4.12?
>>
>> commit 47b2c3fff4932e6fc17ce13d51a43c6969714e20
>> Author: Bilal Amarni <bilal.amarni@gmail.com>
>> Date:   Thu Jun 8 14:47:26 2017 +0100
>>
>>     security/keys: add CONFIG_KEYS_COMPAT to Kconfig
>>
>> In commit 20f06ed9f61a ("KEYS: 64-bit MIPS needs to use
>> compat_sys_keyctl for 32-bit userspace"), the keyctl syscall for 32-bit
>> MIPS was "fixed" to point at compat_sys_keyctl instead of sys_keyctl.
>> Unfortunately this caused the syscall to always return ENOSYS because
>> CONFIG_KEYS_COMPAT was not enabled on MIPS. Instead of fixing this by
>> manually by enabling KEYS_COMPAT in the MIPS Kconfig, I think applying
>> the above commit is a better.
> 
> Sounds resonable, but how far back should it go?  4.9 makes sense, but
> stuff older than that?  4.4?  4.1?  3.16?

I'm most interested in 4.9, but I think it should go in all versions
which have 20f06ed9f61a applied, which includes all the current longterm
kernels as far as I can see.

Thanks,
James
