From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 30 Jan 2020 08:42:21 +0000
Subject: Re: [PATCH 1/1] proc_keys_next should increase position index
Message-Id: <0683e4921abc42f94800b3a91490a39bbb7d4cb1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <af9dcaa7-6e4f-281a-2bae-fb605cc55d2d@virtuozzo.com>
         <1451508.1580125174@warthog.procyon.org.uk>
In-Reply-To: <1451508.1580125174@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, Vasily Averin <vvs@virtuozzo.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Mon, 2020-01-27 at 11:39 +0000, David Howells wrote:
> I don't see the effect you're talking about with /proc/keys.  I see the
> following:
> 
> 	[root@andromeda ~]# dd if=/proc/keys bs@ skip=1
> 	dd: /proc/keys: cannot skip to specified offset
> 
> and then it follows up with the normal content with no obvious duplicates (the
> lines are numbered ascendingly in the first column).
> 
> I think I may be being confused by what you mean by "the last line".
> 
> David


The commit message is completely lacking cause and effect. For
similar TPM commit I gave the following remarks:

https://patchwork.kernel.org/patch/11346943/

/Jarkko
