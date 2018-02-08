From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Feb 2018 15:13:03 +0000
Subject: Re: [PATCH 6/9] PKCS#7: remove unnecessary check for NULL sinfo->sig->hash_algo
Message-Id: <17221.1518102783@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180207011012.5928-7-ebiggers3@gmail.com> <20180207011012.5928-1-ebiggers3@gmail.com>
In-Reply-To: <20180207011012.5928-7-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>

Eric Biggers <ebiggers3@gmail.com> wrote:

> The PKCS#7 parser is guaranteed to set ->sig->hash_algo for every
> SignerInfo, since pkcs7_sig_note_digest_algo() is a mandatory action in
> the PKCS#7 ASN.1 grammar, and it returns an error code if an
> unrecognized DigestAlgorithmIdentifier is given rather than leaving the
> algorithm as NULL.  Therefore, remove the unnecessary NULL check.

Actually, we might be better off deferring ENOPKG generation as we might have
multiple signatures, at least one of which does have a digest algorithm that
we can handle.

David
