From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 09 May 2019 15:53:27 +0000
Subject: Re: [PATCH v10 08/12] ima: Factor xattr_verify() out of ima_appraise_measurement()
Message-Id: <1557417207.10635.67.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="maccentraleurope"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
         <20190418035120.2354-9-bauerman@linux.ibm.com>
In-Reply-To: <20190418035120.2354-9-bauerman@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>

T24gVGh1LCAyMDE5LTA0LTE4IGF0IDAwOjUxIC0wMzAwLCBUaGlhZ28gSnVuZyBCYXVlcm1hbm4g
d3JvdGU6Cj4gVmVyaWZ5IHhhdHRyIHNpZ25hdHVyZSBpbiBhIHNlcGFyYXRlIGZ1bmN0aW9uIHNv
IHRoYXQgdGhlIGxvZ2ljIGluCj4gaW1hX2FwcHJhaXNlX21lYXN1cmVtZW50KCkgcmVtYWlucyBj
bGVhciB3aGVuIGl0IGdhaW5zIHRoZSBhYmlsaXR5IHRvIGFsc28KPiB2ZXJpZnkgYW4gYXBwZW5k
ZWQgbW9kdWxlIHNpZ25hdHVyZS4KPiAKPiBUaGUgY29kZSBpbiB0aGUgc3dpdGNoIHN0YXRlbWVu
dCBpcyB1bmNoYW5nZWQgZXhjZXB0IGZvciBoYXZpbmcgdG8KPiBkZXJlZmVyZW5jZSB0aGUgc3Rh
dHVzIGFuZCBjYXVzZSB2YXJpYWJsZXMgKHNpbmNlIHRoZXkncmUgbm93IHBvaW50ZXJzKSwKPiBh
bmQgZml4aW5nIHRoZSBzdHlsZSBvZiBhIGJsb2NrIGNvbW1lbnQgdG8gYXBwZWFzZSBjaGVja3Bh
dGNoLgo+IAo+IFN1Z2dlc3RlZC1ieTogTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4K
PiBTaWduZWQtb2ZmLWJ5OiBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gPGJhdWVybWFuQGxpbnV4Lmli
bS5jb20+CgpSZXZpZXdlZC1ieTrCoMKgTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4K
