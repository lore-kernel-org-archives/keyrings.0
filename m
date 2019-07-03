From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Date: Wed, 03 Jul 2019 11:20:22 +0000
Subject: Re: [PATCH v3] scripts: use pkg-config to locate libcrypto
Message-Id: <1c808a33-e16c-f57d-64a1-9c96d75464b7@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20538915.Wj2CyUsUYa@devpool35> <1811702.YVQuMqyDZo@devpool35>
In-Reply-To: <1811702.YVQuMqyDZo@devpool35>
To: Rolf Eike Beer <eb@emlix.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On 03.07.19 11:57, Rolf Eike Beer wrote:
>> From 71e19be4247fbaa2540dfb321e2b148234680a13 Mon Sep 17 00:00:00 2001
>> From: Rolf Eike Beer <eb@emlix.com>
>> Date: Thu, 22 Nov 2018 16:40:49 +0100
>> Subject: [PATCH] scripts: use pkg-config to locate libcrypto
>>
>> Otherwise build fails if the headers are not in the default location. While
>> at it also ask pkg-config for the libs, with fallback to the existing
>> value.
> 
> Ping?

Maybe repost ?

In general i think it's a good idea to use pkg-config.

Actually, I'd prefer exclusively using pkg-config instead of hardcoded
pathes - it's a wonderful central knob for doing those kind of site-
specific customizations.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
