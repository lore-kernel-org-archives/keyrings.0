From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 19 Sep 2020 22:41:22 +0000
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-Id: <20200919224122.GJ3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="ibm852"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <20200919220920.GI3421308@ZenIV.linux.org.uk>
 <AA2CFC7E-E685-4596-84AD-0E314137B93F@amacapital.net>
In-Reply-To: <AA2CFC7E-E685-4596-84AD-0E314137B93F@amacapital.net>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

T24gU2F0LCBTZXAgMTksIDIwMjAgYXQgMDM6MjM6NTRQTSAtMDcwMCwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOgo+IAo+ID4gT24gU2VwIDE5LCAyMDIwLCBhdCAzOjA5IFBNLCBBbCBWaXJvIDx2aXJv
QHplbml2LmxpbnV4Lm9yZy51az4gd3JvdGU6Cj4gPiAKPiA+IO+7v09uIEZyaSwgU2VwIDE4LCAy
MDIwIGF0IDA1OjE2OjE1UE0gKzAyMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+ID4+PiBP
biBGcmksIFNlcCAxOCwgMjAyMCBhdCAwMjo1ODoyMlBNICswMTAwLCBBbCBWaXJvIHdyb3RlOgo+
ID4+PiBTYWlkIHRoYXQsIHdoeSBub3QgcHJvdmlkZSBhIHZhcmlhbnQgdGhhdCB3b3VsZCB0YWtl
IGFuIGV4cGxpY2l0Cj4gPj4+ICJpcyBpdCBjb21wYXQiIGFyZ3VtZW50IGFuZCB1c2UgaXQgdGhl
cmU/ICBBbmQgaGF2ZSB0aGUgbm9ybWFsCj4gPj4+IG9uZSBwYXNzIGluX2NvbXBhdF9zeXNjYWxs
KCkgdG8gdGhhdC4uLgo+ID4+IAo+ID4+IFRoYXQgd291bGQgaGVscCB0byBub3QgaW50cm9kdWNl
IGEgcmVncmVzc2lvbiB3aXRoIHRoaXMgc2VyaWVzIHllcy4KPiA+PiBCdXQgaXQgd291bGRuJ3Qg
Zml4IGV4aXN0aW5nIGJ1Z3Mgd2hlbiBpb191cmluZyBpcyB1c2VkIHRvIGFjY2Vzcwo+ID4+IHJl
YWQgb3Igd3JpdGUgbWV0aG9kcyB0aGF0IHVzZSBpbl9jb21wYXRfc3lzY2FsbCgpLiAgT25lIGV4
YW1wbGUgdGhhdAo+ID4+IEkgcmVjZW50bHkgcmFuIGludG8gaXMgZHJpdmVycy9zY3NpL3NnLmMu
Cj4gPiAKPiA+IFNvIHNjcmV3IHN1Y2ggcmVhZC93cml0ZSBtZXRob2RzIC0gZG9uJ3QgdXNlIHRo
ZW0gd2l0aCBpb191cmluZy4KPiA+IFRoYXQsIEJUVywgaXMgb25lIG9mIHRoZSByZWFzb25zIEkn
bSBzY2VwdGljYWwgYWJvdXQgYnVyeWluZyB0aGUKPiA+IGRlY2lzaW9ucyBkZWVwIGludG8gdGhl
IGNhbGxjaGFpbiAtIHdlIGRvbid0IF93YW50XyBkaWZmZXJlbnQKPiA+IGRhdGEgbGF5b3V0cyBv
biByZWFkL3dyaXRlIGRlcGVuZGluZyB1cG9uIHRoZSAzMmJpdCB2cy4gNjRiaXQKPiA+IGNhbGxl
ciwgbGV0IGFsb25lIHRoZSBwb2ludGVyLWNoYXNpbmcgZ2FyYmFnZSB0aGF0IGlzIC9kZXYvc2cu
Cj4gCj4gV2VsbCwgd2UgY291bGQgcmVtb3ZlIGluX2NvbXBhdF9zeXNjYWxsKCksIGV0YyBhbmQg
aW5zdGVhZCBoYXZlIGFuIGltcGxpY2l0IHBhcmFtZXRlciBpbiBERUZJTkVfU1lTQ0FMTC4gIFRo
ZW4gZXZlcnl0aGluZyB3b3VsZCBoYXZlIHRvIGJlIGV4cGxpY2l0LiAgVGhpcyB3b3VsZCBwcm9i
YWJseSBiZSBhIHdpbiwgYWx0aG91Z2ggaXQgY291bGQgYmUgcXVpdGUgYSBiaXQgb2Ygd29yay4K
Ckl0IHdvdWxkIG5vdCBiZSBhIHdpbiAtIG1vc3Qgb2YgdGhlIHN5c2NhbGxzIGRvbid0IGdpdmUg
YSBkYW1uCmFib3V0IDMyYml0IHZzLiA2NGJpdC4uLg==
