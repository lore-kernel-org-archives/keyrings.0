From: David Howells <dhowells@redhat.com>
Date: Tue, 19 Sep 2017 15:46:08 +0000
Subject: Re: [PATCH] KEYS: fix cred refcount leak in request_key_auth_new()
Message-Id: <28352.1505835968@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170918183331.113261-1-ebiggers3@gmail.com>
In-Reply-To: <20170918183331.113261-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> In request_key_auth_new(), if alloc_key() or key_instantiate_and_link()
> were to fail, we would leak a reference to the 'struct cred'.  Currently
> this can only happen if alloc_key() fails to to allocate memory.  But it
> still should be fixed, as it is a more severe bug waiting to happen.

It might be better to combine request_key_auth_destroy() and the error path
that you're altering in request_key_auth_new() by pulling it into a separate
function.

David
