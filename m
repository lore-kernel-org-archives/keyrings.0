From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 08 Nov 2017 16:44:08 +0000
Subject: Re: pkcs7_message: taint, no license
Message-Id: <ea753090-c874-e253-2852-8cdda2d3da6a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <fcecc880-dd7e-7d41-ad27-856ef94a5ae1@infradead.org>
 <31511.1510146086@warthog.procyon.org.uk>
In-Reply-To: <31511.1510146086@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, keyrings@vger.kernel.org

On 11/08/2017 05:01 AM, David Howells wrote:
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> [74785.692410] pkcs7_message: module license 'unspecified' taints kernel.
>> [74785.692414] Disabling lock debugging due to kernel taint
> 
> Are you particularly using the pkcs#7 parser as a module?  I wonder if it
> makes most sense to make this and the X.509 options 'bool' rather than
> 'tristate'.

Yes, it's built as a loadable module.
'bool' would certainly prevent that.

-- 
~Randy
