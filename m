From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 15 Jun 2017 16:00:56 +0000
Subject: Re: [PATCH v2 3/6] ima: Log the same audit cause whenever a file has no signature
Message-Id: <1497542456.4287.57.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="maccentraleurope"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
         <1496886555-10082-4-git-send-email-bauerman@linux.vnet.ibm.com>
In-Reply-To: <1496886555-10082-4-git-send-email-bauerman@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-security-module@vger.kernel.org
Cc: linux-ima-devel@lists.sourceforge.net, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>

T24gV2VkLCAyMDE3LTA2LTA3IGF0IDIyOjQ5IC0wMzAwLCBUaGlhZ28gSnVuZyBCYXVlcm1hbm4g
d3JvdGU6Cj4gSWYgdGhlIGZpbGUgZG9lc24ndCBoYXZlIGFuIHhhdHRyLCBpbWFfYXBwcmFpc2Vf
bWVhc3VyZW1lbnQgc2V0cyBjYXVzZSB0bwo+ICJtaXNzaW5nLWhhc2giIHdoaWxlIGlmIHRoZXJl
J3MgYW4geGF0dHIgYnV0IGl0J3MgYSBkaWdlc3QgaW5zdGVhZCBvZiBhCj4gc2lnbmF0dXJlIGl0
IHNldHMgY2F1c2UgdG8gIklNQS1zaWduYXR1cmUtcmVxdWlyZWQiLgo+IAo+IEZpeCBpdCBieSBz
ZXR0aW5nIGNhdXNlIHRvICJJTUEtc2lnbmF0dXJlLXJlcXVpcmVkIiBpbiBib3RoIGNhc2VzLgo+
IAo+IFNpZ25lZC1vZmYtYnk6IFRoaWFnbyBKdW5nIEJhdWVybWFubiA8YmF1ZXJtYW5AbGludXgu
dm5ldC5pYm0uY29tPgoKVGhhbmsgeW91LsKgwqBRdWV1ZWQgdG8gYmUgdXBzdHJlYW1lZC4KCk1p
bWkKPiAtLS0KPiAgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfYXBwcmFpc2UuYyB8IDMgKyst
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfYXBwcmFpc2UuYyBiL3NlY3Vy
aXR5L2ludGVncml0eS9pbWEvaW1hX2FwcHJhaXNlLmMKPiBpbmRleCBlYTM2YTRmMTM0ZjQuLjgw
OWJhNzBmYmJiZiAxMDA2NDQKPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcHBy
YWlzZS5jCj4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfYXBwcmFpc2UuYwo+IEBA
IC0yMTcsNyArMjE3LDggQEAgaW50IGltYV9hcHByYWlzZV9tZWFzdXJlbWVudChlbnVtIGltYV9o
b29rcyBmdW5jLAo+ICAJCWlmIChyYyAmJiByYyAhPSAtRU5PREFUQSkKPiAgCQkJZ290byBvdXQ7
Cj4gCj4gLQkJY2F1c2UgPSAibWlzc2luZy1oYXNoIjsKPiArCQljYXVzZSA9IGlpbnQtPmZsYWdz
ICYgSU1BX0RJR1NJR19SRVFVSVJFRCA/Cj4gKwkJCQkiSU1BLXNpZ25hdHVyZS1yZXF1aXJlZCIg
OiAibWlzc2luZy1oYXNoIjsKPiAgCQlzdGF0dXMgPSBJTlRFR1JJVFlfTk9MQUJFTDsKPiAgCQlp
ZiAob3BlbmVkICYgRklMRV9DUkVBVEVEKQo+ICAJCQlpaW50LT5mbGFncyB8PSBJTUFfTkVXX0ZJ
TEU7CgotLQpUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5z
dWJzY3JpYmUga2V5cmluZ3MiIGluCnRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9A
dmdlci5rZXJuZWwub3JnCk1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5l
bC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA==
