From: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Date: Thu, 13 Dec 2018 05:49:22 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <191aa6bc11ec795d0108f3369c3f696cd8a43171.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
	 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
	 <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
	 <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
	 <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
	 <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
	 <655394650664715c39ef242689fbc8af726f09c3.camel@intel.com>
	 <CALCETrVztbuRUnp9MUz-Pp85NhY2htNZHGszS+mU_oWoXK3u6A@mail.gmail.com>
	 <42cb695e947e2c98a989285778d56a241fe67e7f.camel@intel.com>
	 <105F7BF4D0229846AF094488D65A098935553717@PGSMSX112.gar.corp.intel.com>
In-Reply-To: <105F7BF4D0229846AF094488D65A098935553717@PGSMSX112.gar.corp.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>, "luto@kernel.org" <luto@kernel.org>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>, "jmorris@namei.org" <jmorris@namei.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "bp@alien8.de" <bp@alien8.de>, "Hansen, Dave" <dave.hansen@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>

T24gVGh1LCAyMDE4LTEyLTEzIGF0IDA3OjI3ICswODAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IFRoaXMgYWxsIHNob3VsZCBiZSBzdW1tYXJpemVkIGluIHRoZSBkb2N1bWVudGF0aW9uIChoaWdo
LWxldmVsIG1vZGVsIGFuZA0KPiA+IGNvcm5lciBjYXNlcykuDQo+IA0KPiBJIGFtIG5vdCBzdXJl
IHdoZXRoZXIgaXQgaXMgbmVjZXNzYXJ5IHRvIGRvY3VtZW50IEwxVEYgZXhwbGljaXRseSwgc2lu
Y2UgaXQgaXMNCj4gcXVpdGUgb2J2aW91cyB0aGF0IE1LVE1FIGRvZXNuJ3QgcHJldmVudCB0aGF0
LiBJTUhPIGlmIG5lZWRlZCB3ZSBvbmx5IG5lZWQgdG8NCj4gbWVudGlvbiBNS1RNRSBkb2Vzbid0
IHByZXZlbnQgYW55IHNvcnQgb2YgY2FjaGUgYmFzZWQgYXR0YWNrLCBzaW5jZSBkYXRhIGluDQo+
IGNhY2hlIGlzIGluIGNsZWFyLg0KPiANCj4gSW4gZmFjdCBTR1ggZG9lc24ndCBwcmV2ZW50IHRo
aXMgZWl0aGVyLi4NCg0KU29ycnksIHdhcyBhIGJpdCB1bmNsZWFyLiBJIG1lYW50IHRoZSBhc3N1
bXB0aW9ucyBhbmQgZ29hbHMuDQoNCi9KYXJra28NCg=
