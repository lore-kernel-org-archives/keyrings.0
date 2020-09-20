From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 20 Sep 2020 00:14:41 +0000
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-Id: <CALCETrViwOdFia_aX4p4riE8aqop1zoOqVfiQtSAZEzheC+Ozg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <20200919224122.GJ3421308@ZenIV.linux.org.uk> <36CF3DE7-7B4B-41FD-9818-FDF8A5B440FB@amacapital.net>
 <20200919232411.GK3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200919232411.GK3421308@ZenIV.linux.org.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

T24gU2F0LCBTZXAgMTksIDIwMjAgYXQgNDoyNCBQTSBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4
Lm9yZy51az4gd3JvdGU6Cj4KPiBPbiBTYXQsIFNlcCAxOSwgMjAyMCBhdCAwMzo1Mzo0MFBNIC0w
NzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4KPiA+ID4gSXQgd291bGQgbm90IGJlIGEgd2lu
IC0gbW9zdCBvZiB0aGUgc3lzY2FsbHMgZG9uJ3QgZ2l2ZSBhIGRhbW4KPiA+ID4gYWJvdXQgMzJi
aXQgdnMuIDY0Yml0Li4uCj4gPgo+ID4gQW55IHJlYXNvbmFibGUgaW1wbGVtZW50YXRpb24gd291
bGQgb3B0aW1pemUgaXQgb3V0IGZvciBzeXNjYWxscyB0aGF0IGRvbuKAmXQgY2FyZS4gIE9yIGl0
IGNvdWxkIGJlIGV4cGxpY2l0Ogo+ID4KPiA+IERFRklORV9NVUxUSUFSQ0hfU1lTQ0FMTCguLi4p
Cj4KPiAxKSB3aGF0IHdvdWxkIHRoYXQgbG9vayBsaWtlPwoKSW4gZWZmZWN0LCBpdCB3b3VsZCB3
b3JrIGxpa2UgdGhpczoKCi8qIEFyY2gtc3BlY2lmaWMsIGJ1dCB0aGVyZSdzIGEgZ2VuZXJpYyBj
YXNlIGZvciBzYW5lIGFyY2hpdGVjdHVyZXMuICovCmVudW0gc3lzY2FsbF9hcmNoIHsKICBTWVND
QUxMX05BVElWRSwKICBTWVNDQUxMX0NPTVBBVCwKICBTWVNDQUxMX1gzMiwKfTsKCkRFRklORV9N
VUxUSUFSQ0hfU1lTQ0FMTG4oYXJncywgYXJjaCkKewogIGFyZ3MgYXJlIHRoZSBhcmdzIGhlcmUs
IGFuZCBhcmNoIGlzIHRoZSBhcmNoLgp9Cgo+IDIpIGhhdmUgeW91IGNvdW50ZWQgdGhlIHN5c2Nh
bGxzIHRoYXQgZG8gYW5kIGRvIG5vdCBuZWVkIHRoYXQ/CgpOby4KCj4gMykgaG93IG1hbnkgb2Yg
dGhvc2UgcmVhbGlzdGljYWxseSAqY2FuKiBiZSB1bmlmaWVkIHdpdGggdGhlaXIKPiBjb21wYXQg
Y291bnRlcnBhcnRzPyAgW2hpbnQ6IGlvY3RsKDIpIGNhbm5vdF0KClRoZXJlIHdvdWxkIGJlIG5v
IHJlcXVpcmVtZW50IHRvIHVuaWZ5IGFueXRoaW5nLiAgVGhlIGlkZWEgaXMgdGhhdAp3ZSdkIGdl
dCByaWQgb2YgYWxsIHRoZSBnbG9iYWwgc3RhdGUgZmxhZ3MuCgpGb3IgaW9jdGwsIHdlJ2QgaGF2
ZSBhIG5ldyBmaWxlX29wZXJhdGlvbjoKCmxvbmcgaW9jdGwoc3RydWN0IGZpbGUgKiwgdW5zaWdu
ZWQgaW50LCB1bnNpZ25lZCBsb25nLCBlbnVtIHN5c2NhbGxfYXJjaCk7CgpJJ20gbm90IHNheWlu
ZyB0aGlzIGlzIGVhc3ksIGJ1dCBJIHRoaW5rIGl0J3MgcG9zc2libGUgYW5kIHRoZSByZXN1bHQK
d291bGQgYmUgbW9yZSBvYnZpb3VzbHkgY29ycmVjdCB0aGFuIHdoYXQgd2UgaGF2ZSBub3cu
