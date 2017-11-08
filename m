From: David Howells <dhowells@redhat.com>
Date: Wed, 08 Nov 2017 13:01:26 +0000
Subject: Re: pkcs7_message: taint, no license
Message-Id: <31511.1510146086@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <fcecc880-dd7e-7d41-ad27-856ef94a5ae1@infradead.org>
In-Reply-To: <fcecc880-dd7e-7d41-ad27-856ef94a5ae1@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>, keyrings@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> [74785.692410] pkcs7_message: module license 'unspecified' taints kernel.
> [74785.692414] Disabling lock debugging due to kernel taint

Are you particularly using the pkcs#7 parser as a module?  I wonder if it
makes most sense to make this and the X.509 options 'bool' rather than
'tristate'.

David
