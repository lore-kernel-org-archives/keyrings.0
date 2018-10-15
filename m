From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 15 Oct 2018 09:26:02 +0000
Subject: RE: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <0180360cfcb5458d8ff099744e8884d4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
In-Reply-To: <20181011203126.15338-1-ndesaulniers@google.com>
To: "'ndesaulniers@google.com'" <ndesaulniers@google.com>, "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>, "dhowells@redhat.com" <dhowells@redhat.com>
Cc: "natechancellor@gmail.com" <natechancellor@gmail.com>, "ebiggers@google.com" <ebiggers@google.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

RnJvbTogbmRlc2F1bG5pZXJzQGdvb2dsZS5jb20NCj4gU2VudDogMTEgT2N0b2JlciAyMDE4IDIx
OjMxDQouLi4NCj4gYnkgc3dhcHBpbmcgaDIgYW5kIGgzLg0KPiANCj4gc2VjdXJpdHkva2V5cy90
cnVzdGVkLmM6MTQ2OjE3OiB3YXJuaW5nOiBwYXNzaW5nIGFuIG9iamVjdCB0aGF0DQo+IHVuZGVy
Z29lcyBkZWZhdWx0DQo+ICAgICAgIGFyZ3VtZW50IHByb21vdGlvbiB0byAndmFfc3RhcnQnIGhh
cyB1bmRlZmluZWQgYmVoYXZpb3IgWy1XdmFyYXJnc10NCj4gICAgICAgICB2YV9zdGFydChhcmdw
LCBoMyk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiBzZWN1cml0eS9rZXlzL3RydXN0
ZWQuYzoxMjY6Mzc6IG5vdGU6IHBhcmFtZXRlciBvZiB0eXBlICd1bnNpZ25lZA0KPiBjaGFyJyBp
cyBkZWNsYXJlZCBoZXJlDQo+IHVuc2lnbmVkIGNoYXIgKmgyLCB1bnNpZ25lZCBjaGFyIGgzLCAu
Li4pDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+IFNwZWNpZmljYWxseSwg
aXQgc2VlbXMgdGhhdCBib3RoIHRoZSBDOTAgKDQuOC4xLjEpIGFuZCBDMTEgKDcuMTYuMS40KQ0K
PiBzdGFuZGFyZHMgZXhwbGljaXRseSBjYWxsIHRoaXMgb3V0IGFzIHVuZGVmaW5lZCBiZWhhdmlv
cjoNCg0KSSBndWVzcyB0aGF0IHByb2JsZW1zIGFyaXNlIHdoZW4gYWxsIHRoZSBhcmd1bWVudHMg
YXJlIHN0YWNrZWQNCmFuZCB2YV9zdGFydC92YV9hcmcgdXNlIG5haXZlIHBvaW50ZXIgbWFuaXB1
bGF0aW9uLg0KSW4gdGhhdCBjYXNlICZoMyBtaWdodCBiZSA0biszIGFsaWduZWQgc28gdmFfYXJn
KCkgd2lsbCBhY2Nlc3MNCm1pc2FsaWduZWQgc3RhY2sgbG9jYXRpb25zLg0KDQpJIGRvdWJ0IGFu
eSBtb2Rlcm4gY29tcGlsZXJzICh3aGVyZSB2YV9zdGFydCBhbmQgdmFfYXJnIGFyZSBidWlsdGlu
cykNCndpbGwgZ2V0IHRoaXMgJ3dyb25nJyBldmVuIHdoZW4gYWxsIGFyZ3VtZW50cyBhcmUgc3Rh
Y2tlZC4NCg0KU2VlbXMgY2xhbmcgaXMgYmVpbmcgb3ZlciBjYXV0aW91cy4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg=
