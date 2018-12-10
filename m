From: David Howells <dhowells@redhat.com>
Date: Mon, 10 Dec 2018 16:58:08 +0000
Subject: Re: [RFC][PATCH 08/12] KEYS: PGP-based public key signature verification
Message-Id: <17488.1544461088@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <e55a9f80-d2ea-f28f-06ab-3d99786096c4@huawei.com> <20181112102423.30415-9-roberto.sassu@huawei.com> <20181112102423.30415-1-roberto.sassu@huawei.com> <19985.1542026635@warthog.procyon.org.uk>
In-Reply-To: <e55a9f80-d2ea-f28f-06ab-3d99786096c4@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, davem@davemloft.net, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

Roberto Sassu <roberto.sassu@huawei.com> wrote:

> > You need to consider what it is that the patch trying to achieve.
> 
> I understood that the purpose is to check PGP signatures with built-in
> keys or keys provided by the user. Since using the session keyring
> caused the issue I reported, I thought it was ok to use the user
> keyring.
> 
> Just a note: the original patches were relying on KEY_FLAG_TRUSTED to
> determine if a key is trusted; now the trustworthiness depends on the
> type of keyring passed to pgp_verify_sig(). I removed the additional key
> search in the user (session) keyring to prevent that signature
> verification is done with a key provided by the user even when the
> caller of pgp_verify_sig() expects that a trusted key is used. The
> search in the session keyring is done if the caller of pgp_verify_sig()
> sets the keyring pointer to NULL.

Thinking about these patches further, as you point out, the way that trust is
computed has changed.  There is no no KEY_FLAG_TRUSTED; rather, a key is
assumed to be trusted if it's on a trusted keyring.

*Getting* it onto that trusted keyring is then the trick.  There are two ways:

 (1) A key can be loaded from a trusted source during boot (say a compiled in
     set of keys).

 (2) A key can be added to that keyring later, provided that the key is
     verified by a key already in the ring and the ring hasn't been closed.

What do we need to check PGP signatures?  Blobs or keys as well?

Why does the user keyring need to be a fallback?  (I know the session keyring
used to be a fallback when I first did these, but things have changed since
then).

Should we have a separate built-in keyring for PGP keys?  Actually, I suspect
we should probably mark keys in some way with what they're permitted to be
used for.

David
