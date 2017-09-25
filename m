From: David Howells <dhowells@redhat.com>
Date: Mon, 25 Sep 2017 14:14:53 +0000
Subject: Re: [PATCH v2 2/3] KEYS: don't revoke uninstantiated key in request_key_auth_new()
Message-Id: <30194.1506348893@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170921205742.144596-3-ebiggers3@gmail.com>
	<20170921205742.144596-1-ebiggers3@gmail.com>
In-Reply-To: <20170921205742.144596-3-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Fix this by removing the call to key_revoke().  key_put() is sufficient,
> as it's not possible for an uninstantiated authkey to have been used for
> anything yet.

Note that the owner can call keyctl_describe() upon it, though that shouldn't
wait because KEY_LOOKUP_PARTIAL would be specified.

However, this is probably fair enough, and it should be gc'd quickly because
it'll lose its last ref.

David
