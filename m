From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Sun, 03 Sep 2017 00:23:49 +0000
Subject: Re: [PATCH v2 6/6] keyctl.2: mention ENOMEM in ERRORS
Message-Id: <072e155b-768f-58a9-90ab-1c5c276f5468@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170902044032.GA7817@asgard.redhat.com>
In-Reply-To: <20170902044032.GA7817-ZbobWygYI+YXGNroddHbYwC/G2K4zDHf@public.gmane.org>
To: Eugene Syromyatnikov <evgsyr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/02/2017 06:40 AM, Eugene Syromyatnikov wrote:
> This one is not very specific, as memory allocations are scattered across
> the code, so let's put some generic description here.

Thanks, Eugene. Applied.

Cheers,

Michael

> ---
>  man2/keyctl.2 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/man2/keyctl.2 b/man2/keyctl.2
> index bbd85ce..fe17b1e 100644
> --- a/man2/keyctl.2
> +++ b/man2/keyctl.2
> @@ -1866,6 +1866,10 @@ did not exist, and
>  .I arg3
>  was zero (meaning don't create the key if it didn't exist).
>  .TP
> +.B ENOMEM
> +One of kernel memory allocation routines failed during the execution of the
> +syscall.
> +.TP
>  .B ENOTDIR
>  A key of keyring type was expected but the ID of a key with
>  a different type was provided.
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
