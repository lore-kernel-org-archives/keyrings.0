From: Eric Biggers <ebiggers3@gmail.com>
Date: Fri, 24 Nov 2017 20:37:50 +0000
Subject: Re: [PATCH] KEYS: remove unnecessary get/put of explicit dest_keyring
Message-Id: <20171124203750.GA559@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171120225757.96498-1-ebiggers3@gmail.com>
	<23022.1511538725@warthog.procyon.org.uk>
In-Reply-To: <23022.1511538725@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Fri, Nov 24, 2017 at 03:52:05PM +0000, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > -			construct_get_dest_keyring(&dest_keyring);
> 
> This will break.  construct_get_dest_keyring() does other things than just
> getting a ref on whatever dest_keyring points to.
> 

Not if dest_keyring is non-NULL (i.e. explicitly specified), which it is in this
case.

Eric
