From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 13 Nov 2019 20:24:52 +0000
Subject: Re: [PATCH v6 1/3] IMA: Add KEY_CHECK func to measure keys
Message-Id: <1573676692.4843.20.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ibm852"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
         <20191113184658.2862-2-nramas@linux.microsoft.com>
         <1573676066.4843.18.camel@linux.ibm.com>
         <320826aa-f744-f2ae-8693-a6ce9461d886@linux.microsoft.com>
In-Reply-To: <320826aa-f744-f2ae-8693-a6ce9461d886@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTExLTEzIGF0IDEyOjIxIC0wODAwLCBMYWtzaG1pIFJhbWFzdWJyYW1hbmlh
biB3cm90ZToKPiBPbiAxMS8xMy8yMDE5IDEyOjE0IFBNLCBNaW1pIFpvaGFyIHdyb3RlOgo+IAo+
ID4+IEBAIC02NTUsNiArNjU1LDEzIEBAIHZvaWQgcHJvY2Vzc19idWZmZXJfbWVhc3VyZW1lbnQo
Y29uc3Qgdm9pZCAqYnVmLCBpbnQgc2l6ZSwKPiA+PiAgIAlpbnQgYWN0aW9uID0gMDsKPiA+PiAg
IAl1MzIgc2VjaWQ7Cj4gPj4gICAKPiA+PiArCS8qCj4gPj4gKwkgKiBJZiBJTUEgaXMgbm90IHll
dCBpbml0aWFsaXplZCBvciBJTUEgcG9saWN5IGlzIGVtcHR5Cj4gPj4gKwkgKiB0aGVuIHRoZXJl
IGlzIG5vIG5lZWQgdG8gbWVhc3VyZS4KPiA+PiArCSAqLwo+ID4+ICsJaWYgKCFpbWFfcG9saWN5
X2ZsYWcpCj4gPj4gKwkJcmV0dXJuOwo+ID4+ICsKPiA+IAo+ID4gVGhpcyBhZGRpdGlvbiBoYXMg
bm90aGluZyB0byBkbyB3aXRoIGRlZmluaW5nIGEgbmV3IElNQSBob29rIGFuZAo+ID4gc2hvdWxk
IGJlIGEgc2VwYXJhdGUgcGF0Y2guIMKgVGhpcyBjYW4gYmUgcG9zdGVkIGluZGVwZW5kZW50bHkg
b2YgdGhpcwo+ID4gcGF0Y2ggc2V0Lgo+ID4gCj4gPiBNaW1pCj4gCj4gSSdsbCBtb3ZlIHRoaXMg
Y2hhbmdlIHRvIGEgZGlmZmVyZW50IHBhdGNoLAo+IGJ1dCBpdCBoYXMgdG8gYmUgZWl0aGVyIHBh
cnQgb2YgdGhpcyBwYXRjaCBzZXQgb3IgdGhlIGFib3ZlIGNoYW5nZSBhbG9uZSAKPiBuZWVkcyB0
byBiZSB0YWtlbiBiZWZvcmUgdGhpcyBwYXRjaCBzZXQgZm9yIHRoZSBmb2xsb3dpbmcgcmVhc29u
Ogo+IAo+IFRoZSBJTUEgaG9vayBnZXRzIGNhbGxlZCBlYXJseSBpbiB0aGUgYm9vdCBwcm9jZXNz
IChmb3IgZXhhbXBsZSwgd2hlbiAKPiBidWlsdGluX3RydXN0ZWRfa2V5cyBhcmUgYWRkZWQpLiBJ
ZiB0aGUgYWJvdmUgY2hlY2sgaXMgbm90IHRoZXJlLCAKPiBpbWFfZ2V0X2FjdGlvbigpIGlzIGNh
bGxlZCBhbmQgY2F1c2VzIGtlcm5lbCBwYW5pYyAoc2luY2UgSU1BIGlzIG5vdCB5ZXQgCj4gaW5p
dGlhbGl6ZWQpLgoKSXQgd2lsbCBiZSB1cHN0cmVhbWVkIHByaW9yIHRvIHRoaXMgcGF0Y2ggc2V0
LgogCk1pbWkK
