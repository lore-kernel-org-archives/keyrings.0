From: Milan Broz <gmazyland@gmail.com>
Date: Sat, 25 May 2019 07:04:02 +0000
Subject: Re: [PATCH] crypto: af_alg - implement keyring support
Message-Id: <217993a6-529a-804a-3212-588fb1ccd8e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190521100034.9651-1-omosnace@redhat.com>
 <20190525031028.GA18491@sol.localdomain>
In-Reply-To: <20190525031028.GA18491@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Stephan Mueller <smueller@chronox.de>, Milan Broz <gmazyland@gmail.com>, Ondrej Kozina <okozina@redhat.com>, Daniel Zatovic <dzatovic@redhat.com>

On 25/05/2019 05:10, Eric Biggers wrote:
> On Tue, May 21, 2019 at 12:00:34PM +0200, Ondrej Mosnacek wrote:
>> This patch adds new socket options to AF_ALG that allow setting key from
>> kernel keyring. For simplicity, each keyring key type (logon, user,
>> trusted, encrypted) has its own socket option name and the value is just
>> the key description string that identifies the key to be used. The key
>> description doesn't need to be NULL-terminated, but bytes after the
>> first zero byte are ignored.
>>
>> Note that this patch also adds three socket option names that are
>> already defined and used in libkcapi [1], but have never been added to
>> the kernel...
>>
>> Tested via libkcapi with keyring patches [2] applied (user and logon key
>> types only).
>>
>> [1] https://github.com/smuellerDD/libkcapi
>> [2] https://github.com/WOnder93/libkcapi/compare/f283458...1fb501c
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> 
> The "interesting" thing about this is that given a key to which you have only
> Search permission, you can request plaintext-ciphertext pairs with it using any
> algorithm from the kernel's crypto API.  So if there are any really broken
> algorithms and they happen to take the correct length key, you can effectively
> read the key.  That's true even if you don't have Read permission on the key
> and/or the key is of the "logon" type which doesn't have a ->read() method.

Yes, also if non-root user has access to some key in keyring, he can effectively
use it from another context (for example simulate dmcrypt and decrypt an image
of another user). But this is about policy of storing keys in keyrings.

> Since this is already also true for dm-crypt and maybe some other features in
> the kernel, and there will be a new API for fscrypt that doesn't rely on "logon"
> keys with Search access thus avoiding this problem and many others
> (https://patchwork.kernel.org/cover/10951999/), I don't really care much whether
> this patch is applied.  But I wonder whether this is something you've actually
> considered, and what security properties you think you are achieving by using
> the Linux keyrings.

We use what kernel provides now. If there is a better way, we can switch to it.

The reason for using keyring for dmcrypt was to avoid sending key in plain
in every device-mapper ioctl structure. We use process keyring here, so
the key in keyring actually disappears after the setup utility finished its job.

The patch for crypto API is needed mainly for the "trusted" key type, that we
would like to support in dmcrypt as well. For integration in LUKS we need
to somehow validate that the key for particular dm-crypt device is valid.
If we cannot calculate a key digest directly (as LUKS does), we need to provide
some operation with the key from userspace (like HMAC) and compare known output.

This was the main reason for this patch. But I can imagine a lot of other
use cases where key in keyring actually simplifies things.

Milan
