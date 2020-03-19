From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 19 Mar 2020 21:15:28 +0000
Subject: Re: [PATCH v3] KEYS: reaching the keys quotas correctly
Message-Id: <20200319211528.GA167847@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1582864911-30823-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
In-Reply-To: <1582864911-30823-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
To: keyrings@vger.kernel.org

On Thu, Mar 19, 2020 at 03:08:21PM +0000, David Howells wrote:
> How about:
> 
> 	keys: Fix the keys quotas limit check
> 
> It's a bit unfortunate that "key" is also usable as an adjective.
> 
> David

Unfortunately it is already hanging here:

https://www.lkml.org/lkml/2020/3/15/314

/Jarkko
