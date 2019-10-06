From: Mimi Zohar <zohar@linux.ibm.com>
Date: Sun, 06 Oct 2019 00:38:53 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <1570322333.5046.145.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ibm852"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <1570128827.5046.19.camel@linux.ibm.com>
         <20191003215125.GA30511@linux.intel.com>
         <20191003215743.GB30511@linux.intel.com>
         <1570140491.5046.33.camel@linux.ibm.com>
         <1570147177.10818.11.camel@HansenPartnership.com>
         <20191004182216.GB6945@linux.intel.com>
         <1570213491.3563.27.camel@HansenPartnership.com>
         <20191004183342.y63qdvspojyf3m55@cantor>
         <1570214574.3563.32.camel@HansenPartnership.com>
         <20191004200728.xoj6jlgbhv57gepc@cantor>
         <20191004201134.nuesk6hxtxajnxh2@cantor>
         <1570227068.17537.4.camel@HansenPartnership.com>
In-Reply-To: <1570227068.17537.4.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Jerry Snitselaar <jsnitsel@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Safford <david.safford@ge.com>, linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

T24gRnJpLCAyMDE5LTEwLTA0IGF0IDE1OjExIC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
Cgo+ICsKPiArLyoqCj4gKyAqIHRwbV9nZXRfcmFuZG9tKCkgLSBnZXQgcmFuZG9tIGJ5dGVzIGlu
Zmx1ZW5jZWQgYnkgdGhlIFRQTSdzIFJORwo+ICsgKiBAY2hpcDoJYSAmc3RydWN0IHRwbV9jaGlw
IGluc3RhbmNlLCAlTlVMTCBmb3IgdGhlIGRlZmF1bHQgY2hpcAo+ICsgKiBAb3V0OglkZXN0aW5h
dGlvbiBidWZmZXIgZm9yIHRoZSByYW5kb20gYnl0ZXMKPiArICogQG1heDoJdGhlIG1heCBudW1i
ZXIgb2YgYnl0ZXMgdG8gd3JpdGUgdG8gQG91dAo+ICsgKgo+ICsgKiBVc2VzIHRoZSBUUE0gYXMg
YSBzb3VyY2Ugb2YgaW5wdXQgdG8gdGhlIGtlcm5lbCByYW5kb20gbnVtYmVyCj4gKyAqIGdlbmVy
YXRvciBhbmQgdGhlbiB0YWtlcyBAbWF4IGJ5dGVzIGRpcmVjdGx5IGZyb20gdGhlIGtlcm5lbC4g
IEluCj4gKyAqIHRoZSB3b3JzdCAobm8gb3RoZXIgZW50cm9weSkgY2FzZSwgdGhpcyB3aWxsIHJl
dHVybiB0aGUgcHVyZSBUUE0KPiArICogcmFuZG9tIG51bWJlciwgYnV0IGlmIHRoZSBrZXJuZWwg
Uk5HIGhhcyBhbnkgZW50cm9weSBhdCBhbGwgaXQgd2lsbAo+ICsgKiByZXR1cm4gYSBtaXhlZCBl
bnRyb3B5IG91dHB1dCB3aGljaCBkb2Vzbid0IHJlbHkgb24gYSBzaW5nbGUKPiArICogc291cmNl
Lgo+ICsgKgo+ICsgKiBSZXR1cm46IG51bWJlciBvZiByYW5kb20gYnl0ZXMgcmVhZCBvciBhIG5l
Z2F0aXZlIGVycm9yIHZhbHVlLgo+ICsgKi8KPiAraW50IHRwbV9nZXRfcmFuZG9tKHN0cnVjdCB0
cG1fY2hpcCAqY2hpcCwgdTggKm91dCwgc2l6ZV90IG1heCkKPiArewo+ICsJaW50IHJjOwo+ICsK
PiArCXJjID0gX190cG1fZ2V0X3JhbmRvbShjaGlwLCBvdXQsIG1heCk7Cj4gKwlpZiAocmMgPD0g
MCkKPiArCQlyZXR1cm4gcmM7Cj4gKwkvKgo+ICsJICogYXNzdW1lIHRoZSBUUE0gcHJvZHVjZXMg
cHVyZSByYW5kb21uZXNzLCBzbyB0aGUgYW1vdW50IG9mCj4gKwkgKiBlbnRyb3B5IGlzIHRoZSBu
dW1iZXIgb2YgYml0cyByZXR1cm5lZAo+ICsJICovCj4gKwlhZGRfaHdnZW5lcmF0b3JfcmFuZG9t
bmVzcyhvdXQsIHJjLCByYyAqIDgpOwo+ICsJZ2V0X3JhbmRvbV9ieXRlcyhvdXQsIHJjKTsKClVz
aW5nIHRoZSBUUE0gYXMgYSBzb3VyY2Ugb2YgaW5wdXQgdG8gdGhlIGtlcm5lbCByYW5kb20gbnVt
YmVyCmdlbmVyYXRvciBpcyBmaW5lLCBidXQgcGxlYXNlIGRvbid0IGNoYW5nZSB0aGUgbWVhbmlu
ZyBvZiB0cnVzdGVkCmtleXMuIMKgVGhlIHRydXN0ZWQtZW5jcnlwdGVkIGtleXMgZG9jdW1lbnRh
dGlvbiBjbGVhcmx5IHN0YXRlcwoiVHJ1c3RlZCBLZXlzIHVzZSBhIFRQTSBib3RoIHRvIGdlbmVy
YXRlIGFuZCB0byBzZWFsIHRoZSBrZXlzLiIKCklmIHlvdSByZWFsbHkgd2FudCB0byB1c2UgYSBk
aWZmZXJlbnQgcmFuZG9tIG51bWJlciBzb3VyY2UgaW5zdGVhZCBvZgp0aGUgVFBNLCB0aGVuIGRl
ZmluZSBhIG5ldyB0cnVzdGVkIGtleSBvcHRpb24gKGVnLiBybmc9a2VybmVsKSwgd2l0aAp0aGUg
ZGVmYXVsdCBiZWluZyB0aGUgVFBNLgoKTWltaQoKCj4gKwo+ICsJcmV0dXJuIHJjOwo+ICt9Cj4g
IEVYUE9SVF9TWU1CT0xfR1BMKHRwbV9nZXRfcmFuZG9tKTsK
