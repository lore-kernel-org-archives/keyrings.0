From: Denis Kenzior <denkenz@gmail.com>
Date: Mon, 14 May 2018 19:54:45 +0000
Subject: Re: [RFC PATCH 5/5] KEYS: add KPP ecdh parser
Message-Id: <25b6fb69-22cd-7006-a71f-e2c5329a0259@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228165230.18729-6-tudor.ambarus@microchip.com>
In-Reply-To: <20180228165230.18729-6-tudor.ambarus@microchip.com>
To: keyrings@vger.kernel.org

Hi Tudor,

On 02/28/2018 10:52 AM, Tudor Ambarus wrote:
> The ECDH private keys are expected to be encoded with the ecdh
> helpers from kernel.
> 
> Use the ecdh helpers to check if the key is valid. If valid,
> allocate a tfm and set the private key. There is a one-to-one
> binding between the private key and the tfm. The tfm is allocated
> once and used as many times as needed.
> 
> ECDH keys can be loaded like this:
>      # echo -n 020028000200200024d121ebe5cf2d83f6621b6e43843aa38be086c32019da92505303e1c0eab882 \

This part looks a bit scary.  Isn't this translating directly to 
kpp_secret data structure (in looks like little-endian order) followed 
curve_id, etc.

If the intent is to extend KPP with regular DH, DH + KDF, etc, then we 
might want to invent a proper format here?  I don't think that a Diffie 
Hellman or ECDH Private Key format was ever invented, similar to how 
PKCS8 is used for RSA.

Inventing an ASN.1 syntax would be logical but somewhat painful as D-H 
is frequently used with plain old random numbers and certificates are 
not stored on disk...

>          | xxd -r -p | keyctl padd asymmetric private @s
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>   crypto/asymmetric_keys/Kconfig      |   8 +++
>   crypto/asymmetric_keys/Makefile     |   5 ++
>   crypto/asymmetric_keys/kpp_parser.c | 124 ++++++++++++++++++++++++++++++++++++
>   include/crypto/asym_kpp_subtype.h   |   2 +
>   4 files changed, 139 insertions(+)
>   create mode 100644 crypto/asymmetric_keys/kpp_parser.c

Regards,
-Denis
