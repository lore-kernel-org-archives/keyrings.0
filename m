From: David Howells <dhowells@redhat.com>
Date: Thu, 12 Oct 2017 15:27:07 +0000
Subject: Re: [PATCH v3 1/7] KEYS: don't let add_key() update an uninstantiated key
Message-Id: <22673.1507822027@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170927195047.122358-2-ebiggers3@gmail.com>
	<20170927195047.122358-1-ebiggers3@gmail.com>
In-Reply-To: <20170927195047.122358-2-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Therefore, change find_key_to_update() to return NULL if the found key
> is uninstantiated, so that add_key() replaces the key rather than
> instantiating it.  This seems to be better than fixing __key_update() to
> call __key_instantiate_and_link(), since given all the bugs noted above
> as well as that the existing behavior was undocumented and
> keyctl_instantiate() is supposed to be used instead, I doubt anyone was
> relying on the existing behavior.

keyctl_instantiate() can only be called from an upcall.  It can't be called in
the same context as keyctl_update().

I would be okay with making key_update() wait for completion of construction
in this case.

David
