From: David Howells <dhowells@redhat.com>
Date: Fri, 24 Nov 2017 15:52:05 +0000
Subject: Re: [PATCH] KEYS: remove unnecessary get/put of explicit dest_keyring
Message-Id: <23022.1511538725@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171120225757.96498-1-ebiggers3@gmail.com>
In-Reply-To: <20171120225757.96498-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> -			construct_get_dest_keyring(&dest_keyring);

This will break.  construct_get_dest_keyring() does other things than just
getting a ref on whatever dest_keyring points to.

David
