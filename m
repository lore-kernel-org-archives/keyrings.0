From: David Howells <dhowells@redhat.com>
Date: Tue, 28 Nov 2017 10:13:01 +0000
Subject: Re: [PATCH] KEYS: add missing permission check for request_key() destination
Message-Id: <7849.1511863981@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171120225830.96642-1-ebiggers3@gmail.com>
In-Reply-To: <20171120225830.96642-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> +		if (do_perm_check) {
> +			ret = key_permission(make_key_ref(dest_keyring, 1),
> +					     KEY_NEED_WRITE);

dest_keyring may be NULL at this point as alloc_uid() doesn't automatically
create keyrings.

David
