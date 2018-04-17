From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Date: Tue, 17 Apr 2018 15:07:37 +0000
Subject: Re: [PATCH v2] X.509: unpack RSA signatureValue field from BIT STRING
Message-Id: <f29df54e-48e1-12e0-f2d2-fd8353cc445f@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CGME20180417134032epcas3p21dbb2d3a6d8650cd64e147d2ce89e6ea@epcas3p2.samsung.com>
        <6f5cdb8a-809e-6651-0e32-711d415a8b38@maciej.szmigiero.name>
In-Reply-To: <6f5cdb8a-809e-6651-0e32-711d415a8b38@maciej.szmigiero.name>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org



On 17.04.2018 15:39, Maciej S. Szmigiero wrote:
> The signatureValue field of a X.509 certificate is encoded as a BIT STRING.
> For RSA signatures this BIT STRING is of so-called primitive subtype, which
> contains a u8 prefix indicating a count of unused bits in the encoding.
> 
> We have to strip this prefix from signature data, just as we already do for
> key data in x509_extract_key_data() function.
> 
> This wasn't noticed earlier because this prefix byte is zero for RSA key
> sizes divisible by 8. Since BIT STRING is a big-endian encoding adding zero
> prefixes has no bearing on its value.
> 
> The signature length, however was incorrect, which is a problem for RSA
> implementations that need it to be exactly correct (like AMD CCP).
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

your e-mail address looks incorrect

[...]

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

