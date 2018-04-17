From: David Miller <davem@davemloft.net>
Date: Tue, 17 Apr 2018 18:52:51 +0000
Subject: Re: [PATCH RESEND net-next v2] KEYS: DNS: limit the length of option strings
Message-Id: <20180417.145251.2147558317390246687.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180417182340.GB9237@gmail.com>
        <20180417.142437.1105065334888296683.davem@davemloft.net>
        <20180417183736.GC9237@gmail.com>
In-Reply-To: <20180417183736.GC9237@gmail.com>
To: ebiggers3@gmail.com
Cc: netdev@vger.kernel.org, keyrings@vger.kernel.org, mark.rutland@arm.com, ebiggers@google.com

From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 17 Apr 2018 11:37:36 -0700

> On Tue, Apr 17, 2018 at 02:24:37PM -0400, David Miller wrote:
>> From: Eric Biggers <ebiggers3@gmail.com>
>> Date: Tue, 17 Apr 2018 11:23:40 -0700
>> 
>> > Can you queue this up for stable too?  syzbot has been hitting this on older
>> > kernel versions.
>> 
>> If you want a patch bound for stable, it must show up in Linus's tree
>> first which means you should target 'net' rather than 'net-next'.
> 
> Okay, can you move the patch there, or do I need to resend, or is it too late
> already?  It's a clean cherry-pick.  Sorry, I'm not too familiar with the quirks
> of net and netdev -- most other maintainers do things differently.

It's already in net-next, so submit another copy based on net.
