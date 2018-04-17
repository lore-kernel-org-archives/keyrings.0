From: David Miller <davem@davemloft.net>
Date: Tue, 17 Apr 2018 18:24:37 +0000
Subject: Re: [PATCH RESEND net-next v2] KEYS: DNS: limit the length of option strings
Message-Id: <20180417.142437.1105065334888296683.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180416212922.233194-1-ebiggers3@gmail.com>
        <20180417.134316.1413649044013070735.davem@davemloft.net>
        <20180417182340.GB9237@gmail.com>
In-Reply-To: <20180417182340.GB9237@gmail.com>
To: ebiggers3@gmail.com
Cc: netdev@vger.kernel.org, keyrings@vger.kernel.org, mark.rutland@arm.com, ebiggers@google.com

From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 17 Apr 2018 11:23:40 -0700

> Can you queue this up for stable too?  syzbot has been hitting this on older
> kernel versions.

If you want a patch bound for stable, it must show up in Linus's tree
first which means you should target 'net' rather than 'net-next'.
