From: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Date: Wed, 05 Dec 2018 20:32:52 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
	 <20181204092550.GT11614@hirez.programming.kicks-ass.net>
	 <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
In-Reply-To: <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>
Cc: "jmorris@namei.org" <jmorris@namei.org>, "Huang, Kai" <kai.huang@intel.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, Hansen, Alison <alison.schofield@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>

T24gVHVlLCAyMDE4LTEyLTA0IGF0IDEyOjQ2ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFR1ZSwgRGVjIDA0LCAyMDE4IGF0IDA5OjI1OjUwQU0gKzAwMDAsIFBldGVyIFpp
amxzdHJhIHdyb3RlOg0KPiA+IE9uIE1vbiwgRGVjIDAzLCAyMDE4IGF0IDExOjM5OjQ3UE0gLTA4
MDAsIEFsaXNvbiBTY2hvZmllbGQgd3JvdGU6DQo+ID4gPiAoTXVsdGktS2V5IFRvdGFsIE1lbW9y
eSBFbmNyeXB0aW9uKQ0KPiA+IA0KPiA+IEkgdGhpbmsgdGhhdCBNS1RNRSBpcyBhIGhvcnJpYmxl
IG5hbWUsIGFuZCBkb2Vzbid0IGFwcGVhciB0byBhY2N1cmF0ZWx5DQo+ID4gZGVzY3JpYmUgd2hh
dCBpdCBkb2VzIGVpdGhlci4gU3BlY2lmaWNhbGx5IHRoZSAndG90YWwnIHNlZW1zIG91dCBvZg0K
PiA+IHBsYWNlLCBpdCBkb2Vzbid0IHJlcXVpcmUgYWxsIG1lbW9yeSB0byBiZSBlbmNyeXB0ZWQu
DQo+IA0KPiBNS1RNRSBpbXBsaWVzIFRNRS4gVE1FIGlzIGVuYWJsZWQgYnkgQklPUyBhbmQgaXQg
ZW5jcnlwdHMgYWxsIG1lbW9yeSB3aXRoDQo+IENQVS1nZW5lcmF0ZWQga2V5LiBNS1RNRSBhbGxv
d3MgdG8gdXNlIG90aGVyIGtleXMgb3IgZGlzYWJsZSBlbmNyeXB0aW9uDQo+IGZvciBhIHBhZ2Uu
DQoNCldoZW4geW91IHNheSAiZGlzYWJsZSBlbmNyeXB0aW9uIHRvIGEgcGFnZSIgZG9lcyB0aGUg
ZW5jcnlwdGlvbiBnZXQNCmFjdHVhbGx5IGRpc2FibGVkIG9yIGRvZXMgdGhlIENQVSBqdXN0IGRl
Y3J5cHQgaXQgdHJhbnNwYXJlbnRseSBpLmUuDQp3aGF0IGhhcHBlbnMgcGh5c2ljYWxseT8NCg0K
PiBCdXQsIHllcywgbmFtZSBpcyBub3QgZ29vZC4NCg0KL0phcmtrbw0K
