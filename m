From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Date: Tue, 18 Jun 2019 02:02:00 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <ac6c02da-5439-1f24-1975-7ba626599d14@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-46-kirill.shutemov@linux.intel.com>
 <CALCETrVCdp4LyCasvGkc0+S6fvS+dna=_ytLdDPuD2xeAr5c-w@mail.gmail.com>
 <3c658cce-7b7e-7d45-59a0-e17dae986713@intel.com>
 <CALCETrUPSv4Xae3iO+2i_HecJLfx4mqFfmtfp+cwBdab8JUZrg@mail.gmail.com>
 <5cbfa2da-ba2e-ed91-d0e8-add67753fc12@intel.com>
 <1560815959.5187.57.camel@linux.intel.com>
 <cbbc6af7-36f8-a81f-48b1-2ad4eefc2417@amd.com>
 <CALCETrWq98--AgXXj=h1R70CiCWNncCThN2fEdxj2ZkedMw6=A@mail.gmail.com>
In-Reply-To: <CALCETrWq98--AgXXj=h1R70CiCWNncCThN2fEdxj2ZkedMw6=A@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Kai Huang <kai.huang@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

T24gNi8xNy8xOSA4OjQwIFBNLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6DQo+IE9uIE1vbiwgSnVu
IDE3LCAyMDE5IGF0IDY6MzQgUE0gTGVuZGFja3ksIFRob21hcw0KPiA8VGhvbWFzLkxlbmRhY2t5
QGFtZC5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIDYvMTcvMTkgNjo1OSBQTSwgS2FpIEh1YW5nIHdy
b3RlOg0KPj4+IE9uIE1vbiwgMjAxOS0wNi0xNyBhdCAxMToyNyAtMDcwMCwgRGF2ZSBIYW5zZW4g
d3JvdGU6DQo+IA0KPj4+DQo+Pj4gQW5kIHllcyBmcm9tIG15IHJlYWRpbmcgKGJldHRlciB0byBo
YXZlIEFNRCBndXlzIHRvIGNvbmZpcm0pIFNFViBndWVzdCB1c2VzIGFub255bW91cyBtZW1vcnks
IGJ1dCBpdA0KPj4+IGFsc28gcGlucyBhbGwgZ3Vlc3QgbWVtb3J5IChieSBjYWxsaW5nIEdVUCBm
cm9tIEtWTSAtLSBTRVYgc3BlY2lmaWNhbGx5IGludHJvZHVjZWQgMiBLVk0gaW9jdGxzIGZvcg0K
Pj4+IHRoaXMgcHVycG9zZSksIHNpbmNlIFNFViBhcmNoaXRlY3R1cmFsbHkgY2Fubm90IHN1cHBv
cnQgc3dhcHBpbmcsIG1pZ3JhaXRvbiBvZiBTRVYtZW5jcnlwdGVkIGd1ZXN0DQo+Pj4gbWVtb3J5
LCBiZWNhdXNlIFNNRS9TRVYgYWxzbyB1c2VzIHBoeXNpY2FsIGFkZHJlc3MgYXMgInR3ZWFrIiwg
YW5kIHRoZXJlJ3Mgbm8gd2F5IHRoYXQga2VybmVsIGNhbg0KPj4+IGdldCBvciB1c2UgU0VWLWd1
ZXN0J3MgbWVtb3J5IGVuY3J5cHRpb24ga2V5LiBJbiBvcmRlciB0byBzd2FwL21pZ3JhdGUgU0VW
LWd1ZXN0IG1lbW9yeSwgd2UgbmVlZCBTR1gNCj4+PiBFUEMgZXZpY3Rpb24vcmVsb2FkIHNpbWls
YXIgdGhpbmcsIHdoaWNoIFNFViBkb2Vzbid0IGhhdmUgdG9kYXkuDQo+Pg0KPj4gWWVzLCBhbGwg
dGhlIGd1ZXN0IG1lbW9yeSBpcyBjdXJyZW50bHkgcGlubmVkIGJ5IGNhbGxpbmcgR1VQIHdoZW4g
Y3JlYXRpbmcNCj4+IGFuIFNFViBndWVzdC4NCj4gDQo+IEljay4NCj4gDQo+IFdoYXQgaGFwcGVu
cyBpZiBRRU1VIHRyaWVzIHRvIHJlYWQgdGhlIG1lbW9yeT8gIERvZXMgaXQganVzdCBzZWUNCj4g
Y2lwaGVydGV4dD8gIElzIGNhY2hlIGNvaGVyZW5jeSBsb3N0IGlmIFFFTVUgd3JpdGVzIGl0Pw0K
DQpJZiBRRU1VIHRyaWVzIHRvIHJlYWQgdGhlIG1lbW9yeSBpcyB3b3VsZCBqdXN0IHNlZSBjaXBo
ZXJ0ZXh0LiBJJ2xsDQpkb3VibGUgY2hlY2sgb24gdGhlIHdyaXRlIHNpdHVhdGlvbiwgYnV0IEkg
dGhpbmsgeW91IHdvdWxkIGVuZCB1cCB3aXRoDQphIGNhY2hlIGNvaGVyZW5jeSBpc3N1ZSBiZWNh
dXNlIHRoZSB3cml0ZSBieSBRRU1VIHdvdWxkIGJlIHdpdGggdGhlDQpoeXBlcnZpc29yIGtleSBh
bmQgdGFnZ2VkIHNlcGFyYXRlbHkgaW4gdGhlIGNhY2hlIGZyb20gdGhlIGd1ZXN0IGNhY2hlDQpl
bnRyeS4gU0VWIHByb3ZpZGVzIGNvbmZpZGVudGlhbGl0eSBvZiBndWVzdCBtZW1vcnkgZnJvbSB0
aGUgaHlwZXJ2aXNvciwNCml0IGRvZXNuJ3QgcHJldmVudCB0aGUgaHlwZXJ2aXNvciBmcm9tIHRy
YXNoaW5nIHRoZSBndWVzdCBtZW1vcnkuDQoNCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo
