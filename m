From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 04 Jul 2019 15:46:41 +0000
Subject: Re: [PATCH] Revert "tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()"
Message-Id: <1562255201.6165.143.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ibm852"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <20190701131505.17759-1-msuchanek@suse.de>
         <8e4cc105b748c5395132b4d3d29d0d9b30a8720c.camel@linux.intel.com>
         <cf2ea579-41c2-42da-2df3-0b1f12e1c639@huawei.com>
         <1562240882.6165.78.camel@linux.ibm.com>
In-Reply-To: <1562240882.6165.78.camel@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Michal Suchanek <msuchanek@suse.de>, linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, James Bottomley <jejb@linux.ibm.com>, David Howells <dhowells@redhat.com>, Tomas Winkler <tomas.winkler@intel.com>, Armijn Hemel <armijn@tjaldur.nl>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Jerry Snitselaar <jsnitsel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org

SGkgSmFya2tvLAoKT24gVGh1LCAyMDE5LTA3LTA0IGF0IDA3OjQ4IC0wNDAwLCBNaW1pIFpvaGFy
IHdyb3RlOgo+IE9uIFRodSwgMjAxOS0wNy0wNCBhdCAxMzoyOCArMDIwMCwgUm9iZXJ0byBTYXNz
dSB3cm90ZToKPiA+IE9uIDcvNC8yMDE5IDEyOjAzIFBNLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
Cj4gPiA+IE9uIE1vbiwgMjAxOS0wNy0wMSBhdCAxNToxNSArMDIwMCwgTWljaGFsIFN1Y2hhbmVr
IHdyb3RlOgo+ID4gPj4gVGhpcyByZXZlcnRzIGNvbW1pdCAwYjZjZjZiOTdiN2VmMWZhM2M3ZmVm
YWIwY2FjODk3YTFjNGEzNDAwIHRvIGF2b2lkCj4gPiA+PiBmb2xsb3dpbmcgY3Jhc2g6Cj4gPiA+
IAo+ID4gPiBUaGFuayB5b3UuIEkgdGhpbmsgdGhpcyB0aGUgcmlnaHQgY2hvaWNlIGZvciB0aGUg
bW9tZW50LiBJIGZpeGVkCj4gPiA+IGEgdHJpdmlhbCBjaGVja3BhdGNoLnBsIGVycm9yIGFuZCBh
ZGRlZCB0aGUgbWFuZGF0b3J5IHRhZ3MuIENhbgo+ID4gPiB5b3UgY2hlY2sgcXVpY2tseSB2MiAo
anVzdCBwb3N0ZWQpPwo+ID4gPiAKPiA+ID4gSSBhbHJlYWR5IG1hZGUgaXQgYXZhaWxhYmxlIGlu
IG15IG1hc3RlciBhbmQgbmV4dC4KPiA+IAo+ID4gQ291bGQgeW91IHBsZWFzZSB3YWl0IGZldyBk
YXlzPyBJIHdvdWxkIHByZWZlciB0byBmaXggdGhpcyBpc3N1ZSBpbnN0ZWFkCj4gPiBvZiByZXZl
cnRpbmcgdGhlIHdob2xlIHBhdGNoLgo+IAo+IE5heW5hIHBvc3RlZCBhIHBhdGNoIGxhdGUgeWVz
dGVyZGF5IHRpdGxlZCAidHBtOiBmaXhlcyB1bmluaXRpYWxpemVkCj4gYWxsb2NhdGVkIGJhbmtz
IGZvciBJQk0gdnRwbSBkcml2ZXIiLCB3aGljaCBhZGRyZXNzZXMgdGhpcyBidWcuCgpOb3cgd2l0
aCBteSByZXZpZXcsIGFuZCB3aXRoIFNhY2hpbiBTYW50J3MgYW5kIE1pY2hhbCBTdWNow6FuZWsK
dGVzdGluZywgaW5zdGVhZCBvZiByZXZlcnRpbmcgdGhpcyBwYXRjaCBjb3VsZCB5b3UgcGljayB1
cCBOYXluYSdzCnBhdGNoIGluc3RlYWQ/Cgp0aGFua3MhCgpNaW1pCg==
