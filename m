Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368F3F39DE
	for <keyrings@vger.kernel.org>; Thu,  9 Jul 2026 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590599; cv=none; b=IlTKqg1tC991T5Rv6W+9NqwRjGuSDZLjD3bkUew4kPueSvheLCRax0bPemSEQS4FglPkcD4HwXKyVx3svQbUXRX1/TFpMBYMzoUdgV6ooaiG8/aM2J3KeDH2B5OylTAz/lgla1rWkD/PF8IwgW0Wl0XspwORF1MmINB4gvM7hbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590599; c=relaxed/simple;
	bh=jTFvyUggpn9b7ir5dJXF/0vV6aESSqllkJsE1EJX8x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+laCmgZ/nwhB+4sfO89IG8ek6hvJv4VgAFG/gvYpXOrpjD8pJ5hSGANPeuMEbYSa0gcpX9M0HVHnx9b5Y8OLdPHrM2aF6AiK3waVlHO1FoFNytMgedha8A+U/HdUa2YTNpjSeA3+dNQSjfhimDforrVbZTBw0X5dHMsjLltO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PovcRIVX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PovcRIVX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so15647455e9.1
        for <keyrings@vger.kernel.org>; Thu, 09 Jul 2026 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783590589; x=1784195389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
        b=PovcRIVXEPSF/FJeQlxhlzoXjqZOrbs3CiE5bUYuum/kokSouOcrfuWzkJz+QZ+EEU
         bXZutBCPHghMPuDpORpgqEkhwf9ItYai/C2Wls7hXpV8JBACI0ISAzSZohMkmVLXApNn
         fZlxwp5LQbRlt1W9WkBqq04596J259cyQGkTEsx5D5ai1Vpe/8NCZrLqgzS5soekf8Zd
         N1CUWCeoaHYptaJl5ecJ1ZzDp9e7jZkz7Z27dZDIG4LQ8N1cI1J5HRitdDR0mFAuAiJK
         tCK2hnhPLuoPo29pU3Y3TxhIiW33KldSOjrnaQ78LbO8JgLXI4Yv8EB+9OvmBldN7dCE
         StRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590589; x=1784195389;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
        b=lP0rj57oHpTrx6/7FcXaVWjyovyY+ryhXJlE8WlooVPE1oZVrI1/NWGRwWDUo6OOhV
         OYPzEgRl9uBCZ+LGhIJquzsvXdqvi3JayWDU41o7n6I0M2kVKHK4T+pWCeB+J1ifXDrM
         dJ7zubzs9E5XtnqtMyFnW/yiyKyoedKsTr/u08DoyYeAMNL5/7PunZVSvP8Okv3CdPeE
         ix8chlqOtdW0Q5q60HF2cyi3sIgGcC9RjmRtqqIcOSEAOhIO4Q3A9VjW6oFYoIyqhRqd
         tMNjFXjOHAkTjHpzGFBK/K+UA1L+BfWWnNpwe8kNqr4u5v7bC7G6bMDAAIaLGkHWBMAr
         GrZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmSsVHpQ6UHA7tmBLT4ojhA1Y9JAvhfEvgoyJSMHJY+Ze2xr04QxYANFVv9qF+LB1euwRSDfKlqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3O4X+MOn/hjRh3W7L5y0eOVM2hIFMvUh4p3dgA1PgMHGX5Di/
	kT1rpcZGssO8P0bkEddYmYsSK0KPs4qv+6Ny2vkZN/AeLfon+IwsKUS1LSbNBzHa9/8=
X-Gm-Gg: AfdE7cm7jjxJKBtHLXouCoxaKirCOsUSY0p/T3SPY6QwUadhBrCqhDVqn1GaC8XYO5F
	3MHPjs5gVGZFOm0KBqXg6KNlWMXXBUBGYWqOte73O3ojTaMEAo90bCCLaD8psS2WqV3fksgySF3
	pbxtR8UxMW9m4wtwwJqOg5GWphz2kiMPz8RglIjYyU1IXzAKhCl3KM2M3Ra8D2dFcEoxymPwBWD
	8rboJDtUMuX5izm8jjQskSg1Df3yl4tDGrsWHjpnbQR9tU6ZtnHRZBoJA2+At0LVaD4tez76NE9
	oM9wGxxoV4KtlI9IJMgUAYMvQRuhki0eYyb6xkJD7G6mYVr3/naiHKKAa9eUzgLlQiEZcXm311Z
	q2+3Hh1vFhRtT4xA0U66DiBoWbvC5WeHdSEQ8SIfuUAbIHY/YnZKUtnWoDB87nrywVFBzDvmhSg
	sLJUxNxEeYmZF+Ohdu+9Y/94gQfY/ApPab+w==
X-Received: by 2002:a05:600c:c1d7:20b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-493e68c3535mr47652155e9.25.1783590588957;
        Thu, 09 Jul 2026 02:49:48 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm47837275e9.6.2026.07.09.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:49:48 -0700 (PDT)
Message-ID: <3e2ae6e8-41ad-45f0-a885-131a5711c276@suse.com>
Date: Thu, 9 Jul 2026 11:49:45 +0200
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
 <ak6STbqZd-Q-c56v@localhost.localdomain>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ak6STbqZd-Q-c56v@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/26 8:13 PM, Michal Koutný wrote:
> Hi Petr.
> 
> On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> wrote:
>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>> index a4337c9b5287..60eb994c32ae 100644
>> --- a/kernel/cgroup/cgroup-v1.c
>> +++ b/kernel/cgroup/cgroup-v1.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/pid_namespace.h>
>>  #include <linux/cgroupstats.h>
>>  #include <linux/fs_parser.h>
>> +#include <linux/umh.h>
>>  
>>  #include <trace/events/cgroup.h>
> 
> There is kmod.h in here too but it's unnecessary, no module lazy loading
> in this code.

You're right. I'll remove the kmod.h include from
kernel/cgroup/cgroup-v1.c. I went through all the files again and it
seems this was the only place I missed.

-- 
Thanks,
Petr
