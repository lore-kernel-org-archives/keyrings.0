From: "Huang, Kai" <kai.huang@intel.com>
Date: Fri, 07 Dec 2018 10:12:47 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <1544177563.28511.34.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
	 <20181204092550.GT11614@hirez.programming.kicks-ass.net>
	 <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
	 <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
	 <20181206112255.4bbumbrf5nnz4t2z@kshutemo-mobl1>
	 <a0a1e0d2-ef32-8378-5363-b730afc99c03@intel.com>
In-Reply-To: <a0a1e0d2-ef32-8378-5363-b730afc99c03@intel.com>
To: "kirill@shutemov.name" <kirill@shutemov.name>, "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>, "jmorris@namei.org" <jmorris@namei.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Schofield, Alison" <alison.schofield@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>

T24gVGh1LCAyMDE4LTEyLTA2IGF0IDA2OjU5IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTIvNi8xOCAzOjIyIEFNLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+ID4gPiBXaGVu
IHlvdSBzYXkgImRpc2FibGUgZW5jcnlwdGlvbiB0byBhIHBhZ2UiIGRvZXMgdGhlIGVuY3J5cHRp
b24gZ2V0DQo+ID4gPiBhY3R1YWxseSBkaXNhYmxlZCBvciBkb2VzIHRoZSBDUFUganVzdCBkZWNy
eXB0IGl0IHRyYW5zcGFyZW50bHkgaS5lLg0KPiA+ID4gd2hhdCBoYXBwZW5zIHBoeXNpY2FsbHk/
DQo+ID4gDQo+ID4gWWVzLCBpdCBnZXRzIGRpc2FibGVkLiBQaHlzaWNhbGx5LiBJdCBvdmVycmlk
ZXMgVE1FIGVuY3J5cHRpb24uDQo+IA0KPiBJIGtub3cgTUtUTUUgaXRzZWxmIGhhcyBhIHJ1bnRp
bWUgb3ZlcmhlYWQgYW5kIHdlIGV4cGVjdCBpdCB0byBoYXZlIGENCj4gcGVyZm9ybWFuY2UgaW1w
YWN0IGluIHRoZSBsb3cgc2luZ2xlIGRpZ2l0cy4gIERvZXMgVE1FIGhhdmUgdGhhdA0KPiBvdmVy
aGVhZD8gIFByZXN1bWFibHkgTUtUTUUgcGx1cyBuby1lbmNyeXB0aW9uIGlzIG5vdCBleHBlY3Rl
ZCB0byBoYXZlDQo+IHRoZSBvdmVyaGVhZC4NCj4gDQo+IFdlIHNob3VsZCBwcm9iYWJseSBtZW50
aW9uIHRoYXQgaW4gdGhlIGNoYW5nZWxvZ3MgdG9vLg0KPiANCg0KSSBiZWxpZXZlIGluIHRlcm1z
IG9mIGhhcmR3YXJlIGNyeXB0byBvdmVyaGVhZCBNS1RNRSBhbmQgVE1FIHNob3VsZCBoYXZlIHRo
ZSBzYW1lIChleGNlcHQgTUtUTUUgbm8tDQplbmNyeXB0IGNhc2U/KS4gQnV0IE1LVE1FIG1pZ2h0
IGhhdmUgYWRkaXRpb25hbCBvdmVyaGVhZCBmcm9tIHNvZnR3YXJlIGltcGxlbWVudGF0aW9uIGlu
IGtlcm5lbD8NCg0KVGhhbmtzLA0KLUthaQ=
