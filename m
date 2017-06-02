From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Jun 2017 15:34:44 +0000
Subject: Re: [PATCH 1/5] KEYS: sanitize add_key() and keyctl() key payloads
Message-Id: <5744.1496417684@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170421083037.12746-2-ebiggers3@gmail.com>
	<20170421083037.12746-1-ebiggers3@gmail.com>
In-Reply-To: <20170421083037.12746-2-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

>  error2:
> +	memzero_explicit(payload, plen);

Isn't that wrong?  payload can be NULL.

David
