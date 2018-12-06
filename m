From: Dave Hansen <dave.hansen@intel.com>
Date: Thu, 06 Dec 2018 19:31:37 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <7116c946-4e4b-c7cf-e28a-1a2b932f61f2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com>
 <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
 <5e97e1bf-536c-ef73-576e-54145eee1ae9@intel.com>
 <CALCETrVPhay-ziRVjL9dDCwJQHhr4HfG5aGJzYh06k6HEMZTiQ@mail.gmail.com>
In-Reply-To: <CALCETrVPhay-ziRVjL9dDCwJQHhr4HfG5aGJzYh06k6HEMZTiQ@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>, Matthew Wilcox <willy@infradead.org>, Dan Williams <dan.j.williams@intel.com>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, kai.huang@intel.com, Jun Nakajima <jun.nakajima@intel.com>, "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>

T24gMTIvNi8xOCAxMToxMCBBTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOgo+PiBPbiBEZWMgNiwg
MjAxOCwgYXQgNzozOSBBTSwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4gd3Jv
dGU6Cj4+VGhlIGNvaGVyZW5jeSBpcyAiZmluZSIgdW5sZXNzIHlvdSBoYXZlIHdyaXRlYmFjayBv
ZiBhbiBvbGRlcgo+PiBjYWNoZWxpbmUgdGhhdCBibG93cyBhd2F5IG5ld2VyIGRhdGEuICBDUFVz
IHRoYXQgc3VwcG9ydCBNS1RNRSBhcmUKPj4gZ3VhcmFudGVlZCB0byBuZXZlciBkbyB3cml0ZWJh
Y2sgb2YgdGhlIGxpbmVzIHRoYXQgY291bGQgYmUgZXN0YWJsaXNoZWQKPj4gc3BlY3VsYXRpdmVs
eSBvciBmcm9tIHByZWZldGNoaW5nLgo+IAo+IEhvdyBpcyB0aGF0IHN1ZmZpY2llbnQ/ICBTdXBw
b3NlIEkgaGF2ZSBzb21lIHBoeXNpY2FsIHBhZ2UgbWFwcGVkIHdpdGgKPiBrZXlzIDEgYW5kIDIu
ICMxIGlzIGxvZ2ljYWxseSBsaXZlIGFuZCBJIHdyaXRlIHRvIGl0LiAgVGhlbiBJIHByZWZldGNo
Cj4gb3Igb3RoZXJ3aXNlIHBvcHVsYXRlIG1hcHBpbmcgMiBpbnRvIHRoZSBjYWNoZSAoaW4gdGhl
IFMgc3RhdGUsCj4gcHJlc3VtYWJseSkuICBOb3cgSSBjbGZsdXNoIG1hcHBpbmcgMSBhbmQgcmVh
ZCAyLiAgSXQgY29udGFpbnMgZ2FyYmFnZQo+IGluIHRoZSBjYWNoZSwgYnV0IHRoZSBnYXJiYWdl
IGluIHRoZSBjYWNoZSBpcyBpbmNvbnNpc3RlbnQgd2l0aCB0aGUKPiBnYXJiYWdlIGluIG1lbW9y
eS4gIFRoaXMgY2Fu4oCZdCBiZSBhIGdvb2QgdGhpbmcsIGV2ZW4gaWYgbm8gd3JpdGViYWNrCj4g
b2NjdXJzLgo+IAo+IEkgc3VwcG9zZSB0aGUgcmlnaHQgZml4IGlzIHRvIGNsZmx1c2ggdGhlIG9s
ZCBtYXBwaW5nIGFuZCB0aGVuIHRvIHplcm8KPiB0aGUgbmV3IG1hcHBpbmcuCgpZZXAuICBQcmFj
dGljYWxseSwgeW91IG5lZWQgdG8gd3JpdGUgdG8gdGhlIG5ldyBtYXBwaW5nIHRvIGdpdmUgaXQg
YW55Cm1lYW5pbmcuICBUaG9zZSB3cml0ZXMgZWZmZWN0aXZlbHkgYmxvdyBhd2F5IGFueSBwcmV2
aW91c2x5IGNhY2hlZCwKZ2FyYmFnZSBjb250ZW50cy4KCkkgdGhpbmsgeW91J3JlIHJpZ2h0LCB0
aG91Z2gsIHRoYXQgdGhlIGNhY2hlZCBkYXRhIG1pZ2h0IG5vdCBiZQpfY29uc2lzdGVudF8gd2l0
aCB3aGF0IGlzIGluIG1lbW9yeS4gIEl0IGZlZWxzIHJlYWxseSBkaXJ0eSwgYnV0IEkgY2FuJ3QK
dGhpbmsgb2YgYW55IHByb2JsZW1zIHRoYXQgaXQgYWN0dWFsbHkgY2F1c2VzLg==
