From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 06 Jun 2019 14:57:27 +0000
Subject: Re: [PATCH 01/10] security: Override creds in __fput() with last fputter's creds [ver #3]
Message-Id: <176F8189-3BE9-4B8C-A4D5-8915436338FB@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: base64
List-Id: <keyrings.vger.kernel.org>
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk> <155981413016.17513.10540579988392555403.stgit@warthog.procyon.org.uk>
In-Reply-To: <155981413016.17513.10540579988392555403.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>, raven@themaw.net, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-block@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Cgo+IE9uIEp1biA2LCAyMDE5LCBhdCAyOjQyIEFNLCBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0By
ZWRoYXQuY29tPiB3cm90ZToKPiAKPiBTbyB0aGF0IHRoZSBMU00gY2FuIHNlZSB0aGUgY3JlZGVu
dGlhbHMgb2YgdGhlIGxhc3QgcHJvY2VzcyB0byBkbyBhbiBmcHV0KCkKPiBvbiBhIGZpbGUgb2Jq
ZWN0IHdoZW4gdGhlIGZpbGUgb2JqZWN0IGlzIGJlaW5nIGRpc21hbnRsZWQsIGRvIHRoZSBmb2xs
b3dpbmcKPiBzdGVwczoKPiAKCkkgc3RpbGwgbWFpbnRhaW4gdGhhdCB0aGlzIGlzIGEgZ2lhbnQg
ZGVzaWduIGVycm9yLiBDYW4gc29tZW9uZSBhdCBsZWFzdCBjb21lIHVwIHdpdGggYSBzaW5nbGUg
dmFsaWQgdXNlIGNhc2UgdGhhdCBpc27igJl0IGVudGlyZWx5IGZ1bGwgb2YgYnVncz8=
