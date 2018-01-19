From: =?ISO-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Date: Fri, 19 Jan 2018 09:16:53 +0000
Subject: Re: [PATCH 3/3] encrypted-keys: document new fscrypt key format
Message-Id: <1516353413.28972.119.camel@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1258"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <20180110124418.24385-1-git@andred.net>
	 <20180110124418.24385-3-git@andred.net>
	 <20180111044801.GB943@zzz.localdomain>
	 <1516199939.28972.101.camel@andred.net> <20180117180537.GB6948@thunk.org>
In-Reply-To: <20180117180537.GB6948@thunk.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Biggers <ebiggers3@gmail.com>, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-doc@vger.kernel.org

VGhhbmsgeW91IFRlZCwKCk9uIFdlZCwgMjAxOC0wMS0xNyBhdCAxMzowNSAtMDUwMCwgVGhlb2Rv
cmUgVHMnbyB3cm90ZToKPiBPbiBXZWQsIEphbiAxNywgMjAxOCBhdCAwMjozODo1OVBNICswMDAw
LCBBbmRyw6kgRHJhc3ppayB3cm90ZToKPiA+ID4gPiBbLi4uXQo+ID4gPiAKPiA+ID4gUGxlYXNl
IGJlIHZlcnkgY2xlYXIgYWJvdXQgZXhhY3RseSB3aGF0IHNlY3VyaXR5IHByb3BlcnRpZXMgYXJl
Cj4gPiA+IGFjaGlldmVkCj4gPiA+IGJ5Cj4gPiA+IHVzaW5nIGVuY3J5cHRlZC1rZXlzLgo+ID4g
Cj4gPiBJJ3ZlIGxlZnQgb3V0IGFsbCBvZiB0aGlzIGluIHRoZSB1cGRhdGVkIGRvY3VtZW50YXRp
b24sIGFzIGFueSBzdWNoCj4gPiBpbmZvcm1hdGlvbiBzaG91bGQgcHJvYmFibHkgYmUgaW4gRG9j
dW1lbnRhdGlvbi9zZWN1cml0eS9rZXlzL3RydXN0ZWQtCj4gPiBlbmNyeXB0ZWQucnN0IGluIHRo
ZSBmaXJzdCBwbGFjZS4KPiAKPiBXaGVyZSBpcyB0aGlzIGRvY3VtZW50IGdvaW5nIHRvIGJlIGZv
dW5kIC8gd2hlbiB3aWxsIGl0IGJlIHdyaXR0ZW4/Cj4gSXQgc2VlbXMgcmVhbGx5IG9kZCB0byBi
ZSByZXF1ZXN0aW5nIGEgZG8gY29kZSByZXZpZXcgd2hlbiB0aGUKPiBzcGVjaWZpY2F0aW9ucyBh
cmVuJ3QgYXZhaWxhYmxlIGFuZC9vciBoYXZlbid0IGJlZW4gd3JpdHRlbiB5ZXQuICBJCj4gcHJl
ZmVyIHRvIHJldmlldyB0aGUgKmRlc2lnbiogZmlyc3QsIGFzIG9wcG9zZWQgdG8gdHJ5aW5nIHRv
IGJvdGgKPiByZXZpZXcgdGhlIGNvZGUgYW5kIHRyeSB0byBndWVzcyBhdCB0aGUgZGVzaWduIGFu
ZCByZXZpZXcgbXkgZ3Vlc3Mgb2YKPiB0aGUgZGVzaWduIGF0IHRoZSBzYW1lIHRpbWUuLi4uCgpE
b2VzIHYzJ3MgY29tbWl0IG1lc3NhZ2UgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRj
aC8xMDE3MzE4OS8gc2VydmUKYXMgYSBnb29kIGVub3VnaCBkZXNpZ24gZG9jdW1lbnQ/CgpDaGVl
cnMsCkFuZHJlJwoKLS0KVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxp
bmUgInVuc3Vic2NyaWJlIGtleXJpbmdzIiBpbgp0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFq
b3Jkb21vQHZnZXIua2VybmVsLm9yZwpNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdl
ci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWw=
