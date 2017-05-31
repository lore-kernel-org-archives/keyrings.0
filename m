From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 31 May 2017 19:07:42 +0000
Subject: Re: [PATCH] KEYS: fix freeing uninitialized memory in key_update()
Message-Id: <20170531190742.GA72735@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170401223645.29528-1-ebiggers3@gmail.com>
	<3742.1491234534@warthog.procyon.org.uk>
In-Reply-To: <3742.1491234534@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Mon, Apr 03, 2017 at 04:48:54PM +0100, David Howells wrote:
> Pulled.

David, where was this pulled to?  It's not in keys-next at
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git.  Nor did
it show up in v4.12-rc1.
