From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 10 Aug 2017 02:00:31 +0000
Subject: Re: [PATCH 0/3] Fix y2038 issues for security/keys subsystem
Message-Id: <CAMz4ku+u8tidyW6EuGSxXy6GBL39F22OGRUToiCQJvk61RDvdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1502246501.git.baolin.wang@linaro.org>
	<CAK8P3a1erR4ToZTH09p_KcNo5cNbOuUpmZG9ststD=gf6zfwsw@mail.gmail.com>
In-Reply-To: <CAK8P3a1erR4ToZTH09p_KcNo5cNbOuUpmZG9ststD=gf6zfwsw@mail.gmail.com>
To: linux-security-module@vger.kernel.org

Hi Arnd,

On 9 August 2017 at 16:44, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Aug 9, 2017 at 4:51 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Since 'time_t', 'timeval' and 'timespec' types are not year 2038 safe on
>> 32 bits system, this patchset tries to fix this issues for security/keys
>> subsystem and net/rxrpc subsystem which is connected with security/keys
>> subsystem.
>>
>> Baolin Wang (3):
>>   security: keys: Replace time_t/timespec with time64_t
>>   security: keys: Replace time_t with time64_t for struct
>>     key_preparsed_payload
>>   net: rxrpc: Replace time_t type with time64_t type
>
> Hi David,
>
> I did a private review before Baolin posted these patches, this version look
> correct to me, though I would like to see some clarification from you for the
> rxrpc portion, I'll reply there separately.
>
> All three patches
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your reviewed tag.

-- 
Baolin.wang
Best Regards
