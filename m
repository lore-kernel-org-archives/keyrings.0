From: James Morris <jmorris@namei.org>
Date: Thu, 28 Sep 2017 09:11:27 +0000
Subject: Re: [PATCH v2 0/2] Fix y2038 issues for security/keys subsystem
Message-Id: <alpine.LRH.2.21.1709281910430.6300@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1505960744.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1505960744.git.baolin.wang@linaro.org>
To: linux-security-module@vger.kernel.org

On Thu, 21 Sep 2017, Baolin Wang wrote:

> Since 'time_t', 'timeval' and 'timespec' types are not year 2038 safe on
> 32 bits system, this patchset tries to fix this issues for security/keys
> subsystem.
> 
> Changes since v1:
>  - Add reviewed tag from Arnd.
>  - Drop Patch 3 which had been merged into kernel 4.14 by David.
> 
> Baolin Wang (2):
>   security: keys: Replace time_t/timespec with time64_t
>   security: keys: Replace time_t with time64_t for struct
>     key_preparsed_payload
> 
>  include/linux/key-type.h     |    2 +-
>  include/linux/key.h          |    7 ++++---
>  security/keys/gc.c           |   20 ++++++++++----------
>  security/keys/internal.h     |    8 ++++----
>  security/keys/key.c          |   27 ++++++++++-----------------
>  security/keys/keyring.c      |   18 +++++++++---------
>  security/keys/permission.c   |    3 +--
>  security/keys/proc.c         |   20 ++++++++++----------
>  security/keys/process_keys.c |    2 +-
>  9 files changed, 50 insertions(+), 57 deletions(-)

David, have you taken these into your tree?  I can apply them to mine if 
needed.


-- 
James Morris
<jmorris@namei.org>

