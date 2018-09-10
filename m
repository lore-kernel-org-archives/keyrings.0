From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 10 Sep 2018 22:09:03 +0000
Subject: Re: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name
Message-Id: <20180910150903.249031442dd7fe43e01812cf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
	<20180909220018.GH13219@asgard.redhat.com>
In-Reply-To: <20180909220018.GH13219@asgard.redhat.com>
To: linux-security-module@vger.kernel.org

On Mon, 10 Sep 2018 00:00:18 +0200 Eugene Syromiatnikov <esyr@redhat.com> wrote:

> On Tue, Aug 28, 2018 at 04:34:04PM -0700, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Since this header is in "include/uapi/linux/", apparently people
> > want to use it in userspace programs -- even in C++ ones.
> > However, the header uses a C++ reserved keyword ("private"),
> > so change that to "dh_private" instead to allow the header file
> > to be used in C++ userspace.
> 
> This change breaks all existing C programs that rely on <linux/keyctl.h>
> uapi header in order to get struct keyctl_dh_params definition, however.

Are there such programs?  Do they reference the `private' field?
