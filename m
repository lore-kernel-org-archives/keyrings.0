From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 27 Feb 2020 16:26:23 +0000
Subject: Re: [PATCH] KEYS: reaching the keys quotas correctly when instanttiating
Message-Id: <20200227162623.GG5140@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1582799145-16073-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
In-Reply-To: <1582799145-16073-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
To: keyrings@vger.kernel.org

On Thu, Feb 27, 2020 at 06:25:45PM +0800, Yang Xu wrote:
> I wrote a regression test[1]to test commit a08bf91ce28ed
> ("KEYS: allow reaching the keys quotas exactly"), but it
> failed even I used lastest kernel. It looks like the previous
> patch doesn't remove "=" when we instantiate the key.
> 
> [1]http://lists.linux.it/pipermail/ltp/2020-February/015331.html
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

1. Describe the failure and how this patch fixes in the commit
   message.
2. Add a fixes tag.

/Jarkko
