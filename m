From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Sun, 03 Sep 2017 00:20:27 +0000
Subject: Re: [PATCH v2 3/6] keyrings.7: add pointers to kernel's documentation
Message-Id: <593cf678-99f4-c7c6-2032-24e34b29d29a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170902044014.GA7493@asgard.redhat.com>
In-Reply-To: <20170902044014.GA7493-ZbobWygYI+YXGNroddHbYwC/G2K4zDHf@public.gmane.org>
To: Eugene Syromyatnikov <evgsyr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Eugene,

On 09/02/2017 06:40 AM, Eugene Syromyatnikov wrote:
> Mostly because of assymmetric-keys.txt, which is outside security/keys
> for some reason.

Applied.

Thanks,

Michael


> ---
>  man7/keyrings.7 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/man7/keyrings.7 b/man7/keyrings.7
> index ba980da..0cb1190 100644
> --- a/man7/keyrings.7
> +++ b/man7/keyrings.7
> @@ -866,3 +866,8 @@ scripts can use them.
>  .BR user\-session\-keyring (7),
>  .BR pam_keyinit (8),
>  .BR request-key (8)
> +.PP
> +The kernel source files
> +.IR Documentation/crypto/asymmetric-keys.txt
> +and under
> +.IR Documentation/security/keys .
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
