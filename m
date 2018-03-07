From: David Howells <dhowells@redhat.com>
Date: Wed, 07 Mar 2018 16:03:18 +0000
Subject: Re: [PATCH 1/3] certs: define a trusted platform keyring
Message-Id: <31489.1520438598@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
In-Reply-To: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org

Nayna Jain <nayna@linux.vnet.ibm.com> wrote:

> +		key = key_create_or_update(make_key_ref(keyring, 1),
> +				"asymmetric",
> +				NULL,
> +				p,
> +				plen,
> +				((KEY_POS_ALL & ~KEY_POS_SETATTR) |
> +				 KEY_USR_VIEW | KEY_USR_READ),
> +				KEY_ALLOC_NOT_IN_QUOTA |
> +				KEY_ALLOC_BUILT_IN |
> +				KEY_ALLOC_BYPASS_RESTRICTION);

There's no need to reindent here.  Please line up all the arguments: either
push the first argument over onto the next line if you need to or line them
all up with the char after the opening bracket.

David
