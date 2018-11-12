From: David Howells <dhowells@redhat.com>
Date: Mon, 12 Nov 2018 12:43:55 +0000
Subject: Re: [RFC][PATCH 08/12] KEYS: PGP-based public key signature verification
Message-Id: <19985.1542026635@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181112102423.30415-9-roberto.sassu@huawei.com> <20181112102423.30415-1-roberto.sassu@huawei.com>
In-Reply-To: <20181112102423.30415-9-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, davem@davemloft.net, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

Roberto Sassu <roberto.sassu@huawei.com> wrote:

> - switch from session to user keyring (Roberto Sassu)
> - search user keyring only if no keyring was provided, so that the
>   trustworthiness of the signature depends on the type of keyring
>   containing the key used for signature verification (Roberto Sassu)

Er.  No.  You should search the session keyring.  This may contain a link to
the user keyring (pam_keyinit emplaces one).

You need to consider what it is that the patch trying to achieve.

David
