From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 19 Sep 2020 22:23:54 +0000
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-Id: <AA2CFC7E-E685-4596-84AD-0E314137B93F@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="ibm852"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <20200919220920.GI3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200919220920.GI3421308@ZenIV.linux.org.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

Cj4gT24gU2VwIDE5LCAyMDIwLCBhdCAzOjA5IFBNLCBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4
Lm9yZy51az4gd3JvdGU6Cj4gCj4g77u/T24gRnJpLCBTZXAgMTgsIDIwMjAgYXQgMDU6MTY6MTVQ
TSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+PiBPbiBGcmksIFNlcCAxOCwgMjAy
MCBhdCAwMjo1ODoyMlBNICswMTAwLCBBbCBWaXJvIHdyb3RlOgo+Pj4gU2FpZCB0aGF0LCB3aHkg
bm90IHByb3ZpZGUgYSB2YXJpYW50IHRoYXQgd291bGQgdGFrZSBhbiBleHBsaWNpdAo+Pj4gImlz
IGl0IGNvbXBhdCIgYXJndW1lbnQgYW5kIHVzZSBpdCB0aGVyZT8gIEFuZCBoYXZlIHRoZSBub3Jt
YWwKPj4+IG9uZSBwYXNzIGluX2NvbXBhdF9zeXNjYWxsKCkgdG8gdGhhdC4uLgo+PiAKPj4gVGhh
dCB3b3VsZCBoZWxwIHRvIG5vdCBpbnRyb2R1Y2UgYSByZWdyZXNzaW9uIHdpdGggdGhpcyBzZXJp
ZXMgeWVzLgo+PiBCdXQgaXQgd291bGRuJ3QgZml4IGV4aXN0aW5nIGJ1Z3Mgd2hlbiBpb191cmlu
ZyBpcyB1c2VkIHRvIGFjY2Vzcwo+PiByZWFkIG9yIHdyaXRlIG1ldGhvZHMgdGhhdCB1c2UgaW5f
Y29tcGF0X3N5c2NhbGwoKS4gIE9uZSBleGFtcGxlIHRoYXQKPj4gSSByZWNlbnRseSByYW4gaW50
byBpcyBkcml2ZXJzL3Njc2kvc2cuYy4KPiAKPiBTbyBzY3JldyBzdWNoIHJlYWQvd3JpdGUgbWV0
aG9kcyAtIGRvbid0IHVzZSB0aGVtIHdpdGggaW9fdXJpbmcuCj4gVGhhdCwgQlRXLCBpcyBvbmUg
b2YgdGhlIHJlYXNvbnMgSSdtIHNjZXB0aWNhbCBhYm91dCBidXJ5aW5nIHRoZQo+IGRlY2lzaW9u
cyBkZWVwIGludG8gdGhlIGNhbGxjaGFpbiAtIHdlIGRvbid0IF93YW50XyBkaWZmZXJlbnQKPiBk
YXRhIGxheW91dHMgb24gcmVhZC93cml0ZSBkZXBlbmRpbmcgdXBvbiB0aGUgMzJiaXQgdnMuIDY0
Yml0Cj4gY2FsbGVyLCBsZXQgYWxvbmUgdGhlIHBvaW50ZXItY2hhc2luZyBnYXJiYWdlIHRoYXQg
aXMgL2Rldi9zZy4KCldlbGwsIHdlIGNvdWxkIHJlbW92ZSBpbl9jb21wYXRfc3lzY2FsbCgpLCBl
dGMgYW5kIGluc3RlYWQgaGF2ZSBhbiBpbXBsaWNpdCBwYXJhbWV0ZXIgaW4gREVGSU5FX1NZU0NB
TEwuICBUaGVuIGV2ZXJ5dGhpbmcgd291bGQgaGF2ZSB0byBiZSBleHBsaWNpdC4gIFRoaXMgd291
bGQgcHJvYmFibHkgYmUgYSB3aW4sIGFsdGhvdWdoIGl0IGNvdWxkIGJlIHF1aXRlIGEgYml0IG9m
IHdvcmsu
