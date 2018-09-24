From: Lubomir Rintel <lkundrak@v3.sk>
Date: Mon, 24 Sep 2018 12:26:19 +0000
Subject: Re: [PATCH 2/2] keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h
Message-Id: <36648a680e0e7ebd4ce77f3a13056f38ac7ade36.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk>
	<153779152340.28003.6461494237075964365.stgit@warthog.procyon.org.uk>
In-Reply-To: <153779152340.28003.6461494237075964365.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Mon, 2018-09-24 at 13:18 +0100, David Howells wrote:
> The keyctl_dh_params struct in uapi/linux/keyctl.h contains the
> symbol
> "private" which means that the header file will cause compilation
> failure
> if #included in to a C++ program.  Further, the patch that added the
> same
> struct to the keyutils package named the symbol "priv", not
> "private".
> 
> The previous attempt to fix this (commit 8a2336e549d3) did so by
> simply
> renaming the kernel's copy of the field to dh_private, but this then
> breaks
> existing userspace and as such has to be reverted (which is done by
> the
> preceding patch).
> 
> [And note, to those who think that wrapping the struct in extern "C"
> {}
>  will work: it won't; that only changes how symbol names are
> presented to
>  the assembler and linker.].
> 
> Instead, insert an anonymous union around the "private" member and
> add a
> second member in there with the name "priv" to match the one in the
> keyutils package.  The "private" member is then wrapped in
> !__cplusplus
> cpp-conditionals to hide it from C++.
> 
> Fixes: ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")
> Fixes: 8a2336e549d3 ("uapi/linux/keyctl.h: don't use C++ reserved
> keyword as a struct member name")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Randy Dunlap <rdunlap@infradead.org>
> cc: Lubomir Rintel <lkundrak@v3.sk>
> cc: James Morris <jmorris@namei.org>
> cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> cc: Stephan Mueller <smueller@chronox.de>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: stable@vger.kernel.org
> ---
> 
>  include/uapi/linux/keyctl.h |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/keyctl.h
> b/include/uapi/linux/keyctl.h
> index 7b8c9e19bad1..0f3cb13db8e9 100644
> --- a/include/uapi/linux/keyctl.h
> +++ b/include/uapi/linux/keyctl.h
> @@ -65,7 +65,12 @@
>  
>  /* keyctl structures */
>  struct keyctl_dh_params {
> -	__s32 private;
> +	union {
> +#ifndef __cplusplus
> +		__s32 private;
> +#endif
> +		__s32 priv;
> +	};
>  	__s32 prime;
>  	__s32 base;
>  };
> 

Thank you, checked that this works fine for libell build.

Tested-by: Lubomir Rintel <lkundrak@v3.sk>

Perhaps you may want to call the C++ friendly field "dh_private",
because there might be C++ users that utilize it already. (The chance
might be negligible though.).

Lubo
