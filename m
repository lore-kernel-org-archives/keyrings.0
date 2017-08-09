From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 09 Aug 2017 08:44:13 +0000
Subject: Re: [PATCH 0/3] Fix y2038 issues for security/keys subsystem
Message-Id: <CAK8P3a1erR4ToZTH09p_KcNo5cNbOuUpmZG9ststD=gf6zfwsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1502246501.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1502246501.git.baolin.wang@linaro.org>
To: linux-security-module@vger.kernel.org

On Wed, Aug 9, 2017 at 4:51 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> Since 'time_t', 'timeval' and 'timespec' types are not year 2038 safe on
> 32 bits system, this patchset tries to fix this issues for security/keys
> subsystem and net/rxrpc subsystem which is connected with security/keys
> subsystem.
>
> Baolin Wang (3):
>   security: keys: Replace time_t/timespec with time64_t
>   security: keys: Replace time_t with time64_t for struct
>     key_preparsed_payload
>   net: rxrpc: Replace time_t type with time64_t type

Hi David,

I did a private review before Baolin posted these patches, this version look
correct to me, though I would like to see some clarification from you for the
rxrpc portion, I'll reply there separately.

All three patches

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
