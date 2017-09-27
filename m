From: James Morris <jmorris@namei.org>
Date: Wed, 27 Sep 2017 23:14:58 +0000
Subject: Re: [GIT PULL] KEYS: Fixes and crypto fixes
Message-Id: <alpine.LRH.2.21.1709280912400.12069@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <28036.1506547164@warthog.procyon.org.uk>
In-Reply-To: <28036.1506547164@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@google.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Michael Halcrow <mhalcrow@google.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 27 Sep 2017, David Howells wrote:

>  (2) Fixing big_key to use safe crypto from Jason A. Donenfeld.
> 

I'm concerned about the lack of crypto review mentioned by Jason -- I 
wonder if we can get this rewrite any more review from crypto folk.

Also, are there any tests for this code?  If not, it would be good to make 
some.


-- 
James Morris
<jmorris@namei.org>

