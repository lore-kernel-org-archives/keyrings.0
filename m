From: David Howells <dhowells@redhat.com>
Date: Tue, 27 Jun 2017 09:37:18 +0000
Subject: Re: [PATCH] KEYS: Add documentation for asymmetric keyring restrictions
Message-Id: <7850.1498556238@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170626204518.13138-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20170626204518.13138-1-mathew.j.martineau@linux.intel.com>
To: keyrings@vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

> +signature of the key being linked. Keys without a valid signature are not

Two spaces after a full stop, exclamation mark or question mark at the end of
a sentence, please.

> +	keyctl add keyring root-certs "" @s > root-id

Maybe:

	root_id=`keyctl add keyring root-certs "" @s`

then:

	keyctl padd asymmetric "" $root_id < root1.cert

sort of thing (and the same for chain-id).

> +     If the final end-entity certificate is successfully added to the "chain"
> +     keyring,

"we can be certain that" maybe?

> it has a valid signing chain going back to one of the root
> +     certificates.

btw, in asymmetric-keys.txt, "Keyring link restrictions." needs adding to the
contents.

Looks okay otherwise.

David
