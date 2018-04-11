From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 11 Apr 2018 11:08:11 +0000
Subject: Re: [RFC PATCH 0/5] KEYS: add kpp keyctl operations
Message-Id: <f8b1d01e-5845-e02a-f312-e5ae2d3cdff8@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228165230.18729-1-tudor.ambarus@microchip.com>
In-Reply-To: <20180228165230.18729-1-tudor.ambarus@microchip.com>
To: keyrings@vger.kernel.org

Hi,

There was a long discussion about which interface to chose to export
akcipher and kpp to user-space. This series came as an alternative to
what Stephan proposed for af_alg[1]. I would like some feedback before
diving into tpm.

Best,
ta

[1] https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg27255.html

On 02/28/2018 06:52 PM, Tudor Ambarus wrote:
> This series provides keyctl access for kpp operations, including
> a query function, a function to generate the public key that is
> associated with the private key and a function to compute the
> shared secret.
> 
> I've added a KPP ecdh parser so that you can load an ECDH private
> key into the kernel. The ECDH private keys are expected to be encoded
> with the ecdh helpers from kernel. If the private key is valid, the
> parser will allocate a tfm and set the private key. There is a
> one-to-one binding between the private key and the tfm. The tfm will be
> associated with the key for the entire life of the key. The tfm is
> allocated once and used as many times as needed.
> 
> The kernel patches can be found here also:
> 
> https://github.com/ambarus/linux/commits/keys-kpp
> 
> The keyutils changes can be found here:
> 
> https://github.com/ambarus/keyutils/commits/keys-kpp
> 
> These patches are similar to what David Howells proposed for akcipher:
> 
> https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg19915.html
> 
> I've ported David's patches on top of keys-next and then I've added my
> patches on top of them.
> 
> Both proposals, David's and mine, lack support for accessing TPM.
> Before getting familiar with TPM, please let me know how you feel
> about this series.
> 
> Tudor Ambarus (5):
>    KEYS: Provide key type operations for kpp ops
>    KEYS: Provide keyctls to drive the new key type ops for kpp
>    KEYS: Provide missing asym kpp subops for new key type ops
>    KEYS: add asymmetric kpp subtype
>    KEYS: add KPP ecdh parser
> 
>   Documentation/security/keys/core.rst     | 113 +++++++++++++++++
>   crypto/asymmetric_keys/Kconfig           |  15 +++
>   crypto/asymmetric_keys/Makefile          |   6 +
>   crypto/asymmetric_keys/asym_kpp.c        | 142 +++++++++++++++++++++
>   crypto/asymmetric_keys/asymmetric_type.c |  77 ++++++++++++
>   crypto/asymmetric_keys/kpp_parser.c      | 124 +++++++++++++++++++
>   include/crypto/asym_kpp_subtype.h        |  14 +++
>   include/keys/asymmetric-subtype.h        |  12 ++
>   include/linux/key-type.h                 |   7 ++
>   include/linux/keyctl.h                   |  11 ++
>   include/uapi/linux/keyctl.h              |  19 +++
>   security/keys/Makefile                   |   1 +
>   security/keys/compat.c                   |  10 ++
>   security/keys/internal.h                 |  28 +++++
>   security/keys/keyctl.c                   |  13 ++
>   security/keys/keyctl_kpp.c               | 205 +++++++++++++++++++++++++++++++
>   16 files changed, 797 insertions(+)
>   create mode 100644 crypto/asymmetric_keys/asym_kpp.c
>   create mode 100644 crypto/asymmetric_keys/kpp_parser.c
>   create mode 100644 include/crypto/asym_kpp_subtype.h
>   create mode 100644 security/keys/keyctl_kpp.c
> 
