From: Yihao Wu <wuyihao@linux.alibaba.com>
Date: Sat, 31 Aug 2019 08:27:13 +0000
Subject: Re: [PATCH RESEND] KEYS: pass expiry from X.509 cert to key structure
Message-Id: <959cfc7f-515a-de95-c7a1-fa785c06223a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <9453.1567178718@warthog.procyon.org.uk>
In-Reply-To: <9453.1567178718@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org

On 2019/8/30 11:54 PM, David Howells wrote:
> Yihao Wu <wuyihao@linux.alibaba.com> wrote:
> 
>> +    prep->expiry = cert->valid_to;
> 
> Note that this patch has whitespace breakage, but I can fix that up by hand.
> 
> David
> 

Thanks!

Yihao
