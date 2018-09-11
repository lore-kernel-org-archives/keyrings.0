From: David Howells <dhowells@redhat.com>
Date: Tue, 11 Sep 2018 23:01:51 +0000
Subject: Re: [RFC 11/12] keys/mktme: Add a new key service type for memory encryption keys
Message-Id: <31294.1536706911@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180911223933.GA2638@alison-desk.jf.intel.com> <1a14a6feb02f968c5e6b98360f6f16106b633b58.1536356108.git.alison.schofield@intel.com> <cover.1536356108.git.alison.schofield@intel.com> <27768.1536703395@warthog.procyon.org.uk>
In-Reply-To: <20180911223933.GA2638@alison-desk.jf.intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, Kai Huang <kai.huang@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, Kirill Shutemov <kirill.shutemov@intel.com>, Dave Hansen <dave.hansen@intel.com>, Jarkko Sakkinen <jarkko.sakkinen@intel.com>, jmorris@namei.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-mm@kvack.org

Alison Schofield <alison.schofield@intel.com> wrote:

> If a preparse routine handles all the above, then if any of the
> above failures occur, the key service has less backing out to do.
> Is that the point?

Yes.  Ideally, ->instantiate() would never fail.

> How do I make the connection between the preparse and the instantiate? 
> Do I just put what I need to remember about this key request in the
> payload.data during preparse, so I can examine it again during
> instantiate?

Have a look at user_preparse().  It attaches the contribution to the supplied
key_preparsed_payload struct, which is then passed to ->instantiate() and
->update() as appropriate.  generic_key_instantiate() is used by the user key
type.

David
