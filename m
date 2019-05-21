From: Ondrej Kozina <okozina@redhat.com>
Date: Tue, 21 May 2019 11:30:34 +0000
Subject: Re: [PATCH] crypto: af_alg - implement keyring support
Message-Id: <265b6c1b-3ea9-15f6-29d4-3e5988248db1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190521100034.9651-1-omosnace@redhat.com>
 <A3BC3B07-6446-4631-862A-F661FB9D63B9@holtmann.org>
 <CAFqZXNtCNG2s_Rk_v332HJA5HVXsJYXDsyzfTNgSU_MJ-mMByA@mail.gmail.com>
In-Reply-To: <CAFqZXNtCNG2s_Rk_v332HJA5HVXsJYXDsyzfTNgSU_MJ-mMByA@mail.gmail.com>
To: Ondrej Mosnacek <omosnace@redhat.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Stephan Mueller <smueller@chronox.de>, Milan Broz <gmazyland@gmail.com>, Daniel Zatovic <dzatovic@redhat.com>

On 5/21/19 1:02 PM, Ondrej Mosnacek wrote:
> Hi Marcel,
> 
> On Tue, May 21, 2019 at 12:48 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Ondrej,
>>
>>> This patch adds new socket options to AF_ALG that allow setting key from
>>> kernel keyring. For simplicity, each keyring key type (logon, user,
>>> trusted, encrypted) has its own socket option name and the value is just
>>> the key description string that identifies the key to be used. The key
>>> description doesn't need to be NULL-terminated, but bytes after the
>>> first zero byte are ignored.
>>
>> why use the description instead the actual key id? I wonder if a single socket option and a struct providing the key type and key id might be more useful.
> 
> I was basing this on the approach taken by dm-crypt/cryptsetup, which
> is actually the main target consumer for this feature (cryptsetup
> needs to be able to encrypt/decrypt data using a keyring key (possibly
> unreadable by userspace) without having to create a temporary dm-crypt
> mapping, which requires CAP_SYSADMIN). I'm not sure why they didn't
> just use key IDs there... @Milan/Ondrej, what was you motivation for
> using key descriptions rather than key IDs?
> 
We decided to use key descriptions so that we could identify more 
clearly devices managed by cryptsetup (thus 'cryptsetup:' prefix in our 
descriptions put in dm-crypt table). I understood numeric ids were too 
generic for this purpose. Also cryptsetup uses by default thread keyring 
to upload keys in kernel. Such keys are obsolete the moment cryptsetup 
process finishes.

I don't think it's any problem to go with IDs for your patch. IIUC, as 
long as process has permission to access key metadata it can obtain also 
current key id so it's not a big problem for as to adapt when we use kcapi.

Regards
O.
