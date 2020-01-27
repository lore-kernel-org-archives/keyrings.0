From: David Howells <dhowells@redhat.com>
Date: Mon, 27 Jan 2020 11:39:34 +0000
Subject: Re: [PATCH 1/1] proc_keys_next should increase position index
Message-Id: <1451508.1580125174@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <af9dcaa7-6e4f-281a-2bae-fb605cc55d2d@virtuozzo.com>
In-Reply-To: <af9dcaa7-6e4f-281a-2bae-fb605cc55d2d@virtuozzo.com>
To: Vasily Averin <vvs@virtuozzo.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>

I don't see the effect you're talking about with /proc/keys.  I see the
following:

	[root@andromeda ~]# dd if=/proc/keys bs@ skip=1
	dd: /proc/keys: cannot skip to specified offset

and then it follows up with the normal content with no obvious duplicates (the
lines are numbered ascendingly in the first column).

I think I may be being confused by what you mean by "the last line".

David
