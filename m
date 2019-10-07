From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 07 Oct 2019 18:08:15 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <1570471695.5046.186.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ibm852"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <1570140491.5046.33.camel@linux.ibm.com>
         <1570147177.10818.11.camel@HansenPartnership.com>
         <20191004182216.GB6945@linux.intel.com>
         <1570213491.3563.27.camel@HansenPartnership.com>
         <20191004183342.y63qdvspojyf3m55@cantor>
         <1570214574.3563.32.camel@HansenPartnership.com>
         <20191004200728.xoj6jlgbhv57gepc@cantor>
         <20191004201134.nuesk6hxtxajnxh2@cantor>
         <1570227068.17537.4.camel@HansenPartnership.com>
         <1570322333.5046.145.camel@linux.ibm.com>
         <20191006235238.GA16641@linux.intel.com>
In-Reply-To: <20191006235238.GA16641@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Jerry Snitselaar <jsnitsel@redhat.com>, David Safford <david.safford@ge.com>, linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

T24gTW9uLCAyMDE5LTEwLTA3IGF0IDAyOjUyICswMzAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
Cj4gCj4gV2l0aCBURUUgY29taW5nIGluLCBUUE0gaXMgbm90IHRoZSBvbmx5IGhhcmR3YXJlIG1l
YXN1cmUgYW55bW9yZSBzZWFsaW5nCj4gdGhlIGtleXMgYW5kIHdlIGRvbid0IHdhbnQgYSBtZXNz
IHdoZXJlIGV2ZXJ5IGhhcmR3YXJlIGFzc2V0IGRvZXMgdGhlaXIKPiBvd24gcHJvcHJpZXRhcnkg
a2V5IGdlbmVyYXRpb24uIFRoZSBwcm9wcmlldGFyeSB0ZWNobm9sb2d5IHNob3VsZCBvbmx5Cj4g
dGFrZSBjYXJlIG9mIHRoZSBzZWFsaW5nIHBhcnQuCgpJJ20gZmluZSB3aXRoIHRoZSBjb25jZXB0
IG9mICJ0cnVzdGVkIiBrZXlzIGJlaW5nIGV4dGVuZGVkIGJleW9uZCBqdXN0ClRQTS4gwqBCdXQg
anVzdCBhcyB0aGUgVkZTIGxheWVyIGRlZmluZXMgYSBzZXQgb2YgY2FsbGJhY2tzIGFuZCBnZW5l
cmljCmZ1bmN0aW9ucywgd2hpY2ggY2FuIGJlIHVzZWQgaW4gbGlldSBvZiBmaWxlIHN5c3RlbSBz
cGVjaWZpYyBjYWxsYmFjawpmdW5jdGlvbnMsIGEgc2ltaWxhciBhcHByb2FjaCBjb3VsZCBiZSB1
c2VkIGhlcmUuCgpNaW1pCg==
