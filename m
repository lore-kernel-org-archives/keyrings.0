From: "Huang, Kai" <kai.huang@intel.com>
Date: Mon, 17 Jun 2019 11:13:11 +0000
Subject: Re: [PATCH, RFC 20/62] mm/page_ext: Export lookup_page_ext() symbol
Message-Id: <1560769988.5187.20.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
         <20190508144422.13171-21-kirill.shutemov@linux.intel.com>
         <20190614111259.GA3436@hirez.programming.kicks-ass.net>
         <20190614224443.qmqolaigu5wnf75p@box>
         <20190617093054.GB3419@hirez.programming.kicks-ass.net>
         <1560769298.5187.16.camel@linux.intel.com>
In-Reply-To: <1560769298.5187.16.camel@linux.intel.com>
To: "kirill@shutemov.name" <kirill@shutemov.name>, "peterz@infradead.org" <peterz@infradead.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "keescook@chromium.org" <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Hansen, Dave" <dave.hansen@intel.com>, "luto@amacapital.net" <luto@amacapital.net>, "Schofield, Alison" <alison.schofield@intel.com>

T24gTW9uLCAyMDE5LTA2LTE3IGF0IDIzOjAxICsxMjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IE9u
IE1vbiwgMjAxOS0wNi0xNyBhdCAxMTozMCArMDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+
ID4gT24gU2F0LCBKdW4gMTUsIDIwMTkgYXQgMDE6NDQ6NDNBTSArMDMwMCwgS2lyaWxsIEEuIFNo
dXRlbW92IHdyb3RlOg0KPiA+ID4gT24gRnJpLCBKdW4gMTQsIDIwMTkgYXQgMDE6MTI6NTlQTSAr
MDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgTWF5IDA4LCAyMDE5
IGF0IDA1OjQzOjQwUE0gKzAzMDAsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gPiA+ID4g
PiBwYWdlX2tleWlkKCkgaXMgaW5saW5lIGZ1bmNhdGlvbiB0aGF0IHVzZXMgbG9va3VwX3BhZ2Vf
ZXh0KCkuIEtWTSBpcw0KPiA+ID4gPiA+IGdvaW5nIHRvIHVzZSBwYWdlX2tleWlkKCkgYW5kIHNp
bmNlIEtWTSBjYW4gYmUgYnVpbHQgYXMgYSBtb2R1bGUNCj4gPiA+ID4gPiBsb29rdXBfcGFnZV9l
eHQoKSBoYXMgdG8gYmUgZXhwb3J0ZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIF9yZWFsbHlfIGhh
dGUgaGF2aW5nIHRvIGV4cG9ydCB3b3JsZCtkb2cgZm9yIEtWTS4gVGhpcyBvbmUgbWlnaHQgbm90
DQo+ID4gPiA+IGJlIGEgcmVhbCBpc3N1ZSwgYnV0IEkgaXRjaCBldmVyeSB0aW1lIEkgc2VlIGFu
IGV4cG9ydCBmb3IgS1ZNIHRoZXNlDQo+ID4gPiA+IGRheXMuDQo+ID4gPiANCj4gPiA+IElzIHRo
ZXJlIGFueSBiZXR0ZXIgd2F5PyBEbyB3ZSBuZWVkIHRvIGludmVudCBFWFBPUlRfU1lNQk9MX0tW
TSgpPyA6UA0KPiA+IA0KPiA+IE9yIGRpc2FsbG93IEtWTSAob3IgcGFydHMgdGhlcmVvZikgZnJv
bSBiZWluZyBhIG1vZHVsZSBhbnltb3JlLg0KPiANCj4gRm9yIHRoaXMgcGFydGljdWxhciBzeW1i
b2wgZXhwb3NlLCBJIGRvbid0IHRoaW5rIGl0cyBmYWlyIHRvIGJsYW1lIEtWTSBzaW5jZSB0aGUg
ZnVuZGFtZW50YWwNCj4gcmVhc29uDQo+IGlzIGJlY2F1c2UgcGFnZV9rZXlpZCgpICh3aGljaCBj
YWxscyBsb29rdXBfcGFnZV9leHQoKSkgYmVpbmcgaW1wbGVtZW50ZWQgYXMgc3RhdGljIGlubGlu
ZQ0KPiBmdW5jdGlvbg0KPiBpbiBoZWFkZXIgZmlsZSwgc28gZXNzZW50aWFsbHkgaGF2aW5nIGFu
eSBvdGhlciBtb2R1bGUgd2hvIGNhbGxzIHBhZ2Vfa2V5aWQoKSB3aWxsIHRyaWdnZXIgdGhpcw0K
PiBwcm9ibGVtIC0tIGluIGZhY3QgSU9NTVUgZHJpdmVyIGNhbGxzIHBhZ2Vfa2V5aWQoKSB0b28g
c28gZXZlbiB3L28gS1ZNIGxvb2t1cF9wYWdlX2V4dCgpIG5lZWRzIHRvDQo+IGJlDQo+IGV4cG9z
ZWQuDQoNCk9vcHMgaXQgc2VlbXMgSW50ZWwgSU9NTVUgZHJpdmVyIGlzIG5vdCBhIG1vZHVsZSBi
dXQgYnVpbGRpbiBzbyB5ZXMgS1ZNIGlzIHRoZSBvbmx5IG1vZHVsZSB3aG8gY2FsbHMNCnBhZ2Vf
a2V5aWQoKSBub3cuIFNvcnJ5IG15IGJhZC4gQnV0IGlmIHRoZXJlJ3MgYW55IG90aGVyIG1vZHVs
ZSBjYWxscyBwYWdlX2tleWlkKCksIHRoaXMgcGF0Y2ggaXMNCnJlcXVpcmVkLg0KDQpUaGFua3Ms
DQotS2FpDQo+IA0KPiBUaGFua3MsDQo+IC1LYWkNCj4g
