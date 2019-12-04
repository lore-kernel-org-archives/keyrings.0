From: "Zhao, Shirley" <shirley.zhao@intel.com>
Date: Wed, 04 Dec 2019 06:39:50 +0000
Subject: RE: One question about trusted key of keyring in Linux kernel.
Message-Id: <A888B25CD99C1141B7C254171A953E8E4909E8B8@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
         <1575057916.6220.7.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
         <1575260220.4080.17.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909D360@shsmsx102.ccr.corp.intel.com>
         <1575267453.4080.26.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E381@shsmsx102.ccr.corp.intel.com>
         <1575269075.4080.31.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
         <1575312932.24227.13.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E62E@shsmsx102.ccr.corp.intel.com>
         <1575342724.24227.41.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E877@shsmsx102.ccr.corp.intel.com>
 <1575430389.14163.27.camel@linux.ibm.com>
In-Reply-To: <1575430389.14163.27.camel@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

T2gsIGdldCB5b3UsIEphbWVzLiANClVuZGVyc3RhbmQsIHRoYW5rcyBmb3IgeW91ciBmZWVkYmFj
ay4gDQpMb29raW5nIGZvcndhcmQgZm9yIHlvdXIgcHJvcG9zZWQgQVBJLiANCg0KLSBTaGlybGV5
IA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFtZXMgQm90dG9tbGV5IDxq
ZWpiQGxpbnV4LmlibS5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciA0LCAyMDE5IDEx
OjMzIEFNDQpUbzogWmhhbywgU2hpcmxleSA8c2hpcmxleS56aGFvQGludGVsLmNvbT47IE1pbWkg
Wm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+OyBKYXJra28gU2Fra2luZW4gPGphcmtrby5zYWtr
aW5lbkBsaW51eC5pbnRlbC5jb20+OyBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pg0K
Q2M6IGxpbnV4LWludGVncml0eUB2Z2VyLmtlcm5lbC5vcmc7IGtleXJpbmdzQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgJ01hdXJvIENhcnZhbGhvIENoZWhhYicgPG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwub3Jn
PjsgWmh1LCBCaW5nIDxiaW5nLnpodUBpbnRlbC5jb20+OyBDaGVuLCBMdWhhaSA8bHVoYWkuY2hl
bkBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogT25lIHF1ZXN0aW9uIGFib3V0IHRydXN0ZWQga2V5
IG9mIGtleXJpbmcgaW4gTGludXgga2VybmVsLg0KDQpPbiBXZWQsIDIwMTktMTItMDQgYXQgMDM6
MDEgKzAwMDAsIFpoYW8sIFNoaXJsZXkgd3JvdGU6DQo+IEhpLCBKYW1lcywNCj4gDQo+IFVzaW5n
IHBvbGljeSBkaWdlc3QgdG8gcmVsb2FkIHRydXN0ZWQga2V5LCBkb2Vzbid0IHdvcmssIGVpdGhl
ci4gDQo+IFBsZWFzZSBjaGVjayB0aGUgc3RlcHMgYmVsb3cuIA0KPiBJIHRoaW5rIHBvbGljeSBk
aWdlc3Qgc2hvdWxkIGJlIGNhbGN1bGF0ZWQgYnkgVFBNIHdoZW4gdmVyaWZ5aW5nIHRoZSANCj4g
cG9saWN5IHRvIHJlbG9hZCBrZXkuDQoNCllvdSBtaXN1bmRlcnN0YW5kIG15IG1lYW5pbmc6IHRo
ZSBBUEkgd2UgaGF2ZSBub3cgZG9lc24ndCB3b3JrOyB0aGUga2V5IGJsb2IgdGhlIGtlcm5lbCBy
ZXR1cm5zIGN1cnJlbnRseSBhZnRlciBrZXkgY3JlYXRlIHdvbid0IHJlbG9hZCBiZWNhdXNlIGl0
IGNvbnRhaW5zIGV4dHJhbmVvdXMgZGF0YS4gIEkgd2FzIHByb3Bvc2luZyBhIHdvcmtpbmcgQVBJ
IEkgdGhvdWdodCBtaWdodCByZXBsYWNlIGl0LCBidXQgb2J2aW91c2x5IGl0IGhhcyB0byBiZSBj
b2RlZCB1cCBhbmQgYWNjZXB0ZWQgaW50byBhIGtlcm5lbCB2ZXJzaW9uIGJlZm9yZSB5b3UgY2Fu
IHVzZSBpdC4NCg0KSWYgeW91IHdhbnQgdG8gZ2V0IHRydXN0ZWQga2V5cyB3b3JraW5nIHRvZGF5
LCBJIHRoaW5rIHRoZSBUUE0gMS4yIEFQSSBzdGlsbCB3b3JrcyBpZiB5b3UgaGF2ZSBhIFRQTSAx
LjIgc3lzdGVtLg0KDQpKYW1lcw0KDQo
