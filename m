From: David Howells <dhowells@redhat.com>
Date: Wed, 20 Feb 2019 14:09:55 +0000
Subject: Re: [PATCH] KEYS: user: Align the payload buffer
Message-Id: <16012.1550671795@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <6bf441ffc1a54d06ad27ed01c6d06a58@AcuMS.aculab.com> <155066953188.21038.12015964986007814182.stgit@warthog.procyon.org.uk>
In-Reply-To: <6bf441ffc1a54d06ad27ed01c6d06a58@AcuMS.aculab.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: dhowells@redhat.com, "jmorris@namei.org" <jmorris@namei.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Eric Biggers <ebiggers@google.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

David Laight <David.Laight@ACULAB.COM> wrote:

> I'd make the 'datalen' field 'unsigned int' at the same time.
> It will use some of the hole you've made and generate better
> code on most arches.

Most arches?  I though most, if not all, arches had a load-word instruction.

Do you want to send me a patch for that?  I'd rather not alter this patch at
this point.  I can pass the additional patch to James for the next merge
window.

David
