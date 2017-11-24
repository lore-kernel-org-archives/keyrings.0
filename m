From: David Howells <dhowells@redhat.com>
Date: Fri, 24 Nov 2017 21:24:30 +0000
Subject: Re: [PATCH] KEYS: remove unnecessary get/put of explicit dest_keyring
Message-Id: <5687.1511558670@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171120225757.96498-1-ebiggers3@gmail.com>
In-Reply-To: <20171120225757.96498-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

>  		if (dest_keyring) {
> -			construct_get_dest_keyring(&dest_keyring);

Actually, I think I have the order of these lines inverted.
construct_get_dest_keyring() can actually return without setting dest_keyring
to anything.  This didn't used to be the case, but now that the user-session
keyring is made lazily, there's no guaranteed fallback.

David
