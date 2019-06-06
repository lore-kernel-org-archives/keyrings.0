From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 06 Jun 2019 18:51:01 +0000
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications [ver #3]
Message-Id: <E7472FA4-886E-4325-87EA-9812D08CC2D3@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov> <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk> <3813.1559827003@warthog.procyon.org.uk> <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov> <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com> <CALCETrWn_C8oReKXGMXiJDOGoYWMs+jg2DWa5ZipKAceyXkx5w@mail.gmail.com> <7afe1a85-bf19-b5b4-fdf3-69d9be475dab@schaufler-ca.com>
In-Reply-To: <7afe1a85-bf19-b5b4-fdf3-69d9be475dab@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Andy Lutomirski <luto@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>, raven@themaw.net, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-block@vger.kernel.org, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>

Cgo+IE9uIEp1biA2LCAyMDE5LCBhdCAxMTozMyBBTSwgQ2FzZXkgU2NoYXVmbGVyIDxjYXNleUBz
Y2hhdWZsZXItY2EuY29tPiB3cm90ZToKPiAKPj4gT24gNi82LzIwMTkgMTA6MTEgQU0sIEFuZHkg
THV0b21pcnNraSB3cm90ZToKPj4+IE9uIFRodSwgSnVuIDYsIDIwMTkgYXQgOTo0MyBBTSBDYXNl
eSBTY2hhdWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+IHdyb3RlOgo+Pj4gLi4uCj4+PiBJ
IGRvbid0IGFncmVlLiBUaGF0IGlzLCBJIGRvbid0IGJlbGlldmUgaXQgaXMgc3VmZmljaWVudC4K
Pj4+IFRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IGJlaW5nIGFibGUgdG8gc2V0IGEgd2F0Y2gg
b24gYW4KPj4+IG9iamVjdCBpbXBsaWVzIHRoYXQgZXZlcnkgcHJvY2VzcyB0aGF0IGNhbiB0cmln
Z2VyIHRoZSBldmVudAo+Pj4gY2FuIHNlbmQgaXQgdG8geW91Lgo+Pj4gCj4+PiAgICAgICAgV2F0
Y2hlciBoYXMgU21hY2sgbGFiZWwgVwo+Pj4gICAgICAgIFRyaWdnZXJlciBoYXMgU21hY2sgbGFi
ZWwgVAo+Pj4gICAgICAgIFdhdGNoZWQgb2JqZWN0IGhhcyBTbWFjayBsYWJlbCBPCj4+PiAKPj4+
ICAgICAgICBSZWxldmFudCBTbWFjayBydWxlcyBhcmUKPj4+IAo+Pj4gICAgICAgIFcgTyBydwo+
Pj4gICAgICAgIFQgTyBydwo+Pj4gCj4+PiBUaGUgd2F0Y2hlciB3aWxsIGJlIGFibGUgdG8gc2V0
IHRoZSB3YXRjaCwKPj4+IHRoZSB0cmlnZ2VyZXIgd2lsbCBiZSBhYmxlIHRvIHRyaWdnZXIgdGhl
IGV2ZW50LAo+Pj4gYnV0IHRoZXJlIGlzIG5vdGhpbmcgdGhhdCB3b3VsZCBhbGxvdyB0aGUgd2F0
Y2hlcgo+Pj4gdG8gcmVjZWl2ZSB0aGUgZXZlbnQuIFRoaXMgaXMgbm90IGEgY2FzZSBvZiB3YXRj
aGVyCj4+PiByZWFkaW5nIHRoZSB3YXRjaGVkIG9iamVjdCwgYXMgdGhlIGV2ZW50IGlzIGRlbGl2
ZXJlZAo+Pj4gd2l0aG91dCBhbnkgYWN0aW9uIGJ5IHdhdGNoZXIuCj4+IEkgdGhpbmsgdGhpcyBp
cyBhbiBleGFtcGxlIG9mIGEgYm9ndXMgcG9saWN5IHRoYXQgc2hvdWxkIG5vdCBiZQo+PiBzdXBw
b3J0ZWQgYnkgdGhlIGtlcm5lbC4KPiAKPiBBdCB0aGlzIHBvaW50IGl0J3MgcHJldHR5IGhhcmQg
Zm9yIG1lIHRvIGNhcmUgbXVjaCB3aGF0Cj4geW91IHRoaW5rLiBZb3UgZG9uJ3Qgc2VlbSB0byBo
YXZlIGFueSBpbnNpZ2h0IGludG8gdGhlCj4gaW1wbGljYXRpb25zIG9mIHRoZSBmZWF0dXJlcyB5
b3UncmUgYWR2b2NhdGluZywgb3IgdGhlaXIKPiBwb3RlbnRpYWwgY29uc2VxdWVuY2VzLgo+IAo+
IAoKQ2FuIHlvdSB0cnkgdG8gc3BlbGwgaXQgb3V0LCB0aGVuPyAgQSBtb3N0bHkgb3IgZnVsbHkg
d29ya2VkIG91dCBleGFtcGxlIG1pZ2h0IGhlbHAuCgpBcyBTdGVwaGVuIHNhaWQsIGl0IGxvb2tz
IGxpa2UgeW91IGFyZSBjb25zaWRlcmluZyBjYXNlcyB3aGVyZSB0aGVyZSBpcyBhbHJlYWR5IGEg
ZnVsbCBjb21tdW5pY2F0aW9uIGNoYW5uZWwgYmV0d2VlbiB0d28gcHJvY2Vzc2VzLCBhbmQgeW91
4oCZcmUgY29uY2VybmVkIHRoYXQgdGhpcyBuZXcgbWVjaGFuaXNtIG1pZ2h0IGFkZCBhIHNpZGUg
Y2hhbm5lbCB0b28uICBJZiB0aGlzIGlzIHdyb25nLCBjYW4geW91IGV4cGxhaW4gaG93Pw==
