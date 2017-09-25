From: David Howells <dhowells@redhat.com>
Date: Mon, 25 Sep 2017 14:18:57 +0000
Subject: Re: [PATCH v2 1/3] KEYS: fix cred refcount leak in request_key_auth_new()
Message-Id: <30852.1506349137@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170921205742.144596-2-ebiggers3@gmail.com>
	<20170921205742.144596-1-ebiggers3@gmail.com>
In-Reply-To: <20170921205742.144596-2-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> +	rka = kzalloc(sizeof(*rka), GFP_KERNEL);
> +	if (!rka)
> +		goto error_free_rka;

But you haven't allocated an rka if you're in the error path.  I'll fix that
to jump over the release.

David
