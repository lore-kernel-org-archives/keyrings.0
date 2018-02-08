From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Feb 2018 15:27:09 +0000
Subject: Re: [PATCH 8/9] X.509: remove dead code that set ->unsupported_sig
Message-Id: <17830.1518103629@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180207011012.5928-9-ebiggers3@gmail.com> <20180207011012.5928-1-ebiggers3@gmail.com>
In-Reply-To: <20180207011012.5928-9-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>

Eric Biggers <ebiggers3@gmail.com> wrote:

> The X.509 parser is guaranteed to set cert->sig->pkey_algo and
> cert->sig->hash_algo, since x509_note_pkey_algo() is a mandatory action
> in the X.509 ASN.1 grammar, and it returns an error code if an
> unrecognized AlgorithmIdentifier is given rather than leaving the
> algorithms as NULL.

I'm leaning towards ENOPKG production here being deferred so that X.509 certs
that we can't verify can still be built into the kernel or loaded from
'trusted' sources.

Let me think about this a bit more.

David
