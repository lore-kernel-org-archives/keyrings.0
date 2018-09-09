From: Eugene Syromiatnikov <esyr@redhat.com>
Date: Sun, 09 Sep 2018 22:00:18 +0000
Subject: Re: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name
Message-Id: <20180909220018.GH13219@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
In-Reply-To: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
To: linux-security-module@vger.kernel.org

On Tue, Aug 28, 2018 at 04:34:04PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Since this header is in "include/uapi/linux/", apparently people
> want to use it in userspace programs -- even in C++ ones.
> However, the header uses a C++ reserved keyword ("private"),
> so change that to "dh_private" instead to allow the header file
> to be used in C++ userspace.

This change breaks all existing C programs that rely on <linux/keyctl.h>
uapi header in order to get struct keyctl_dh_params definition, however.

> 
> Fixes https://bugzilla.kernel.org/show_bug.cgi?id1051
> Fixes: ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  include/uapi/linux/keyctl.h |    2 +-
>  security/keys/dh.c          |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- lnx-416.orig/include/uapi/linux/keyctl.h
> +++ lnx-416/include/uapi/linux/keyctl.h
> @@ -65,7 +65,7 @@
>  
>  /* keyctl structures */
>  struct keyctl_dh_params {
> -	__s32 private;
> +	__s32 dh_private;

>  	__s32 prime;
>  	__s32 base;
>  };
> --- lnx-416.orig/security/keys/dh.c
> +++ lnx-416/security/keys/dh.c
> @@ -307,7 +307,7 @@ long __keyctl_dh_compute(struct keyctl_d
>  	}
>  	dh_inputs.g_size = dlen;
>  
> -	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
> +	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
>  	if (dlen < 0) {
>  		ret = dlen;
>  		goto out2;
> 
> 
