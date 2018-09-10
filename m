From: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Date: Mon, 10 Sep 2018 18:24:20 +0000
Subject: Re: [RFC 10/12] x86/pconfig: Program memory encryption keys on a system-wide basis
Message-Id: <73c60d4f8a953476f1e29aaccbeb7f732c209190.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1536356108.git.alison.schofield@intel.com>
	 <0947e4ad711e8b7c1f581a446e808f514620b49b.1536356108.git.alison.schofield@intel.com>
In-Reply-To: <0947e4ad711e8b7c1f581a446e808f514620b49b.1536356108.git.alison.schofield@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "Schofield, Alison" <alison.schofield@intel.com>, "dhowells@redhat.com" <dhowells@redhat.com>
Cc: "Shutemov, Kirill" <kirill.shutemov@intel.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "jmorris@namei.org" <jmorris@namei.org>, "Huang,
 Kai" <kai.huang@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>

T24gRnJpLCAyMDE4LTA5LTA3IGF0IDE1OjM4IC0wNzAwLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPiBUaGUga2VybmVsIG1hbmFnZXMgdGhlIE1LVE1FIChNdWx0aS1LZXkgVG90YWwgTWVtb3J5
IEVuY3J5cHRpb24pIEtleXMNCj4gYXMgYSBzeXN0ZW0gd2lkZSBzaW5nbGUgcG9vbCBvZiBrZXlz
LiBUaGUgaGFyZHdhcmUsIGhvd2V2ZXIsIG1hbmFnZXMNCj4gdGhlIGtleXMgb24gYSBwZXIgcGh5
c2ljYWwgcGFja2FnZSBiYXNpcy4gRWFjaCBwaHlzaWNhbCBwYWNrYWdlDQo+IG1haW50YWlucyBh
IGtleSB0YWJsZSB0aGF0IGFsbCBDUFUncyBpbiB0aGF0IHBhY2thZ2Ugc2hhcmUuDQo+IA0KPiBJ
biBvcmRlciB0byBtYWludGFpbiB0aGUgY29uc2lzdGVudCwgc3lzdGVtIHdpZGUgdmlldyB0aGF0
IHRoZSBrZXJuZWwNCj4gcmVxdWlyZXMsIHByb2dyYW0gYWxsIHBoeXNpY2FsIHBhY2thZ2VzIGR1
cmluZyBhIGtleSBwcm9ncmFtIHJlcXVlc3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlzb24g
U2Nob2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4NCg0KSnVzdCBraW5kIG9mIGNo
ZWNraW5nIHRoYXQgYXJlIHlvdSB0YWxraW5nIGFib3V0IG11bHRpcGxlIGNvcmVzIGluDQphIHNp
bmdsZSBwYWNrYWdlIG9yIHJlYWxseSBtdWx0aXBsZSBwYWNrYWdlcz8NCg0KL0phcmtrbw=
