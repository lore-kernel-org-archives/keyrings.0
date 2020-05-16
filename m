From: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Date: Sat, 16 May 2020 13:01:01 +0000
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-Id: <fc542b516c9ddf0e13a68bb52728035c37a1fdf2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515191758.ieojyk5xhsx2hzzd@cantor>
         <1589571278.3653.22.camel@HansenPartnership.com>
         <1589573417.3653.28.camel@HansenPartnership.com>
In-Reply-To: <1589573417.3653.28.camel@HansenPartnership.com>
To: "jsnitsel@redhat.com" <jsnitsel@redhat.com>, "James.Bottomley@HansenPartnership.com" <James.Bottomley@HansenPartnership.com>
Cc: "dhowells@redhat.com" <dhowells@redhat.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>

T24gRnJpLCAyMDIwLTA1LTE1IGF0IDEzOjEwIC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
DQo+IE9uIEZyaSwgMjAyMC0wNS0xNSBhdCAxMjozNCAtMDcwMCwgSmFtZXMgQm90dG9tbGV5IHdy
b3RlOg0KPiA+IE9uIEZyaSwgMjAyMC0wNS0xNSBhdCAxMjoxNyAtMDcwMCwgSmVycnkgU25pdHNl
bGFhciB3cm90ZToNCj4gPiA+IE9uIEZyaSBNYXkgMTUgMjAsIEphcmtrbyBTYWtraW5lbiB3cm90
ZToNCj4gPiA+ID4gT24gVGh1LCBNYXkgMTQsIDIwMjAgYXQgMDg6NDQ6MjNQTSAtMDcwMCwgSmFt
ZXMgQm90dG9tbGV5IHdyb3RlOg0KPiA+ID4gPiA+IE9uIEZyaSwgMjAyMC0wNS0xNSBhdCAwNToy
MiArMDMwMCwgSmFya2tvIFNha2tpbmVuIHdyb3RlOg0KPiA+IA0KPiA+IFsuLi5dDQo+ID4gPiA+
ID4gPiBzdWRvIC4va2V5Y3RsLXNtb2tlLnNoDQo+ID4gPiA+ID4gPiA1NjYyMDEwNTMgKDB4ODAw
MDAwMDApDQo+ID4gPiA+ID4gPiBrZXljdGxfcmVhZF9hbGxvYzogUGVybWlzc2lvbiBkZW5pZWQN
Cj4gPiA+IA0KPiA+ID4gSSBnZXQga2V5Y3RsX3JlYWRfYWxsb2MgLUVQRVJNIHdoZW4gSSAnc3Vk
byBzdScgYW5kIHRyeSB0byBwbGF5DQo+ID4gPiB3aXRoDQo+ID4gPiBrZXljdGwgcHJpbnQuDQo+
ID4gPiBJZiBJICdzdWRvIHN1IC0nIGFuZCB0aGVuIHRyeSBpdCB3b3JrcyBhcyBleHBlY3RlZC4g
QWxzbyB3b3JrcyBmb3INCj4gPiA+IG5vcm1hbCB1c2VyLg0KPiA+IA0KPiA+IE9LLCBJIGNvbmZp
cm0gb24gZGViaWFuIGFzIHdlbGwuICBJZiBJIGNyZWF0ZSBhIGtleSBhcyByZWFsIHJvb3QgYW5k
DQo+ID4gdGhlbiB0cnkgdG8gc3VkbyBzdSBrZXljdGwgcGlwZSBpdCBhcyBhbiBvcmRpbmFyeSB1
c2VyLCBJIGdldCBFUEVSTS4NCj4gPiANCj4gPiBJdCBzbWVsbHMgbGlrZSBhIGNvY2t1cCBpbiBy
ZWFsIHZzIGVmZmVjdGl2ZSBwZXJtaXNzaW9ucyBzb21ld2hlcmUgaW4NCj4gPiB0aGUga2V5Y3Rs
IGhhbmRsZXIuDQo+IA0KPiBPSywgc28gdGhlIHByb2JsZW0gaXMNCj4gDQo+IHN1ZG8ga2V5Y3Rs
IGxpc3QgQHMNCj4gDQo+IFN0aWxsIHNob3dzIHRoZSBzZXNzaW9uIGtleXMgb2YgdGhlIHByZXZp
b3VzIHVzZXINCj4gDQo+IHRoYXQgY2F1c2VzIHN1ZG8ga2V5Y3RsIHNob3cgb24gYSByb290IG93
bmVkIGtleSB0byBmYWlsIHRoZQ0KPiBpc19rZXlfcG9zc2Vzc2VkKCkgY2hlY2ssIHJldHVybmlu
ZyAtRUFDQ0VTUyB3aGljaCBnZXRzIHRyYW5zbGF0ZWQgdG8NCj4gRVBFUk0NCj4gDQo+IGlmIHlv
dSBkbw0KPiANCj4gc3VkbyBzdSAtDQo+IA0KPiBUaGVuIGtleWN0bCBsaXN0IEBzIHNob3dzIHRo
ZSByb290IHNlc3Npb24ga2V5cmluZyBhbmQgZXZlcnl0aGluZyB3b3Jrcw0KPiANCj4gSSB0aGlu
ayB0aGF0IG1lYW5zIHRoZSBzb2x1dGlvbiBpcyBub3QgdG8gcnVuIHRoZSBzbW9rZSB0ZXN0IHVu
ZGVyIHN1ZG8NCj4gYnV0IHRvIGRvIHN1ZG8gLXMgYW5kIHRoZW4gcnVuIGl0Lg0KDQpSaWdodCwg
bWFrZXMgc2Vuc2UgYW5kIEkgY2FuIGFsc28gY29uZmlybSB0aGlzIGluIG15IGVudmlyb25tZW50
Lg0KVGhhbmtzIQ0KDQovSmFya2tvDQo
