From: Stephan Mueller <smueller@chronox.de>
Date: Wed, 09 Jan 2019 06:27:28 +0000
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Message-Id: <3239276.QO2kezntxR@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190103143227.9138-1-jlee@suse.com> <1565399.7ulKdI1fm5@tauon.chronox.de> <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
In-Reply-To: <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>

Am Mittwoch, 9. Januar 2019, 00:54:22 CET schrieb Andy Lutomirski:

Hi Andy,
> 
> I think that, if the crypto API is going to grow a KDF facility, it should
> be done right. Have a key type or flag or whatever that says “this key may
> *only* be used to derive keys using such-and-such algorithm”, and have a
> helper to derive a key.  That helper should take some useful parameters and
> mix them in:
> 
> - What type of key is being derived?  ECDSA signing key?  HMAC key?  AES
> key?
> 
> - Can user code access the derived key?
> 
> - What is the key’s purpose?  “Encrypt and authenticate a hibernation image”
> would be a purpose.
> 
> - Number of bytes.
> 
> All of these parameters should be mixed in to the key derivation.
> 
> Also, an AE key, even for AES+HMAC, should be just one derived key.  If you
> need 512 bits, ask for a 512-bit key, not two 256-bit keys.

I concur with your requirements. However, is the kernel crypto API the right 
place to enforce such policies? To me, the kernel crypto API is a tinker-toy 
set of ciphers.

The real policy enforcer would or should be the keyring facility. Thus, may I 
propose to:

- implement the cryptographic primitive of the KDF in the kernel crypto API

- implement the policy system how to use the KDF in the keyring facility

Ciao
Stephan
