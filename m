From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Dec 2018 19:39:57 +0000
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Message-Id: <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0000000000001c3ace057d3cf3bf"
List-Id: <keyrings.vger.kernel.org>
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
 <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com> <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
To: ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com

--0000000000001c3ace057d3cf3bf
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 17, 2018 at 11:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, for being about "security", all of this code seems to be
> doing some really questionable things with all those Opt_xyz enums.

Yeah, at least security/keys/trusted.c ends up mixing that enum and
just using "int" completely randomly, and you have datablob_parse()
returning either a negative integer _or_ an "Opt_xyz" value, so having
Opt_err be -1 is doubly confusing there (it would also be "-EPERM"
depending on how you treat it).

There doesn't seem to be any _actual_ confusion (because Opt_err is
always turned into an actual real error code), but it's  just another
sign of "those enums should not be negative".

So on the whole, I think that the "Opt_err = -1" is a serious mistake,
but at least for now, ima_policy.c clearly has (bogus) code that
relies on it.

But the two cases that use "test_and_set_bit()" do not seem to have
any reason to use that -1 enum, so while we can't do the "just remove
-1" in general, I do think the proper fix is to just do it for those
two files.

Eric, mind testing a patch like that? Untested patch attached just for
completeness..

                    Linus

--0000000000001c3ace057d3cf3bf
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jpsq0m8p0>
X-Attachment-Id: f_jpsq0m8p0

IHNlY3VyaXR5L2tleXMva2V5Y3RsX3BrZXkuYyB8IDIgKy0KIHNlY3VyaXR5L2tleXMvdHJ1c3Rl
ZC5jICAgICB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2tleXMva2V5Y3RsX3BrZXkuYyBiL3NlY3Vy
aXR5L2tleXMva2V5Y3RsX3BrZXkuYwppbmRleCA3ODM5Nzg4NDJmMTMuLjcwZTY1YTJmZjIwNyAx
MDA2NDQKLS0tIGEvc2VjdXJpdHkva2V5cy9rZXljdGxfcGtleS5jCisrKyBiL3NlY3VyaXR5L2tl
eXMva2V5Y3RsX3BrZXkuYwpAQCAtMjUsNyArMjUsNyBAQCBzdGF0aWMgdm9pZCBrZXljdGxfcGtl
eV9wYXJhbXNfZnJlZShzdHJ1Y3Qga2VybmVsX3BrZXlfcGFyYW1zICpwYXJhbXMpCiB9CiAKIGVu
dW0gewotCU9wdF9lcnIgPSAtMSwKKwlPcHRfZXJyLAogCU9wdF9lbmMsCQkvKiAiZW5jPTxlbmNv
ZGluZz4iIGVnLiAiZW5jPW9hZXAiICovCiAJT3B0X2hhc2gsCQkvKiAiaGFzaD08ZGlnZXN0LW5h
bWU+IiBlZy4gImhhc2g9c2hhMSIgKi8KIH07CmRpZmYgLS1naXQgYS9zZWN1cml0eS9rZXlzL3Ry
dXN0ZWQuYyBiL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC5jCmluZGV4IGZmNjc4OTM2NWExMi4uNjk3
YmZjNmM4MTkyIDEwMDY0NAotLS0gYS9zZWN1cml0eS9rZXlzL3RydXN0ZWQuYworKysgYi9zZWN1
cml0eS9rZXlzL3RydXN0ZWQuYwpAQCAtNzExLDcgKzcxMSw3IEBAIHN0YXRpYyBpbnQga2V5X3Vu
c2VhbChzdHJ1Y3QgdHJ1c3RlZF9rZXlfcGF5bG9hZCAqcCwKIH0KIAogZW51bSB7Ci0JT3B0X2Vy
ciA9IC0xLAorCU9wdF9lcnIsCiAJT3B0X25ldywgT3B0X2xvYWQsIE9wdF91cGRhdGUsCiAJT3B0
X2tleWhhbmRsZSwgT3B0X2tleWF1dGgsIE9wdF9ibG9iYXV0aCwKIAlPcHRfcGNyaW5mbywgT3B0
X3BjcmxvY2ssIE9wdF9taWdyYXRhYmxlLAo=
--0000000000001c3ace057d3cf3bf--
