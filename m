From: David Howells <dhowells@redhat.com>
Date: Sat, 22 Sep 2018 00:03:40 +0000
Subject: Re: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name
Message-Id: <19867.1537574620@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180910150903.249031442dd7fe43e01812cf@linux-foundation.org>
	<0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
	<20180909220018.GH13219@asgard.redhat.com>
In-Reply-To: <20180910150903.249031442dd7fe43e01812cf@linux-foundation.org>
To: linux-security-module@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> Are there such programs?  Do they reference the `private' field?

They would use the keyutils.h header from keyutils package probably.  There
the field was named "priv" not "private".  The kernel's UAPI header should be
amended again to match that.

David
