From: David Howells <dhowells@redhat.com>
Date: Wed, 04 Oct 2017 14:34:30 +0000
Subject: Re: [PATCH v3 1/7] KEYS: don't let add_key() update an uninstantiated key
Message-Id: <3019.1507127670@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170927195047.122358-2-ebiggers3@gmail.com>
	<20170927195047.122358-1-ebiggers3@gmail.com>
In-Reply-To: <20170927195047.122358-2-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> +	if ((key->flags & ((1 << KEY_FLAG_INVALIDATED) |
> +			   (1 << KEY_FLAG_REVOKED) |
> +			   (1 << KEY_FLAG_INSTANTIATED))) !> +	    (1 << KEY_FLAG_INSTANTIATED)) {

Does this need READ_ONCE(), I wonder?

David
