From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Mon, 12 Mar 2018 17:07:53 +0000
Subject: in-kernel user of ecdsa
Message-Id: <0f698592-8ade-14d4-7891-1c35501c6285@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, dwmw2@infradead.org, keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>

Hi,

Would you consider using ECDSA in the kernel module signing facility?
When compared with RSA, ECDSA has shorter keys, the key generation
process is faster, the sign operation is faster, but the verify
operation is slower than with RSA.

Smaller key sizes imply reduced memory footprint and bandwidth that are
especially attractive for memory constrained devices. I'm working with
such a device, capable of generating ecc keys, secure key storage and
ecdsa/ecdh crypto acceleration. I'm trying to find an in-kernel user of
ecdsa.


ECDSA and RSA comparison
------------------------
-> ECDSA requires a much smaller key length in order to provide the same
security strength as RSA [1]:

Security Strength    RSA (bits)        ECDSA (bits)
112                   2048             224 - 255
128                   3072             256 - 383
192                   7680             384 - 511
256                  15360             512+

7680 and 15360  keys are not included in the NIST standards for
interoperability and efficiency reasons, the keys are just too big.

-> key generation: ECC key generation is faster than IFC (Integer -
Factorization Cryptography). RSA private key is based on large prime
numbers, while for ECDSA any positive integer less than n is a valid
private key.

-> ECDSA sign operations are faster than RSA, but verify operations are
slower. Here's an openssl speed test that I've run on my computer:

                   sign    verify    sign/s verify/s
rsa 2048 bits 0.000604s 0.000018s   1656.3  56813.7
rsa 4096 bits 0.004027s 0.000062s    248.3  16052.5

                              sign    verify    sign/s verify/s
256 bit ecdsa (nistp256)   0.0000s   0.0001s  28986.4  13516.3
384 bit ecdsa (nistp384)   0.0002s   0.0008s   5541.0   1322.2
521 bit ecdsa (nistp521)   0.0003s   0.0006s   3104.2   1756.2

Best,
ta

[1] NIST SP 800-57 Pt. 1 Rev. 4, Recommendation for key management
