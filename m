From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Sun, 03 Sep 2017 00:14:32 +0000
Subject: Re: [PATCH v2 1/6] keyctl.2: change "is" to "was" in error descriptions
Message-Id: <875faf26-5b3e-6afd-3c82-822be382efce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170902044003.GA7303@asgard.redhat.com>
In-Reply-To: <20170902044003.GA7303-ZbobWygYI+YXGNroddHbYwC/G2K4zDHf@public.gmane.org>
To: Eugene Syromyatnikov <evgsyr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Eugene,

On 09/02/2017 06:40 AM, Eugene Syromyatnikov wrote:
> Since half of items used "was" and another half used "is".

Yes, that makes sense. Applied

Cheers,

Michael



> ---
>  man2/keyctl.2 | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/man2/keyctl.2 b/man2/keyctl.2
> index 63109f9..3469947 100644
> --- a/man2/keyctl.2
> +++ b/man2/keyctl.2
> @@ -1537,7 +1537,7 @@ The requested operation wasn't permitted.
>  .TP
>  .B EDEADLK
>  .I operation
> -is
> +was
>  .BR KEYCTL_LINK
>  and the requested link would result in a cycle.
>  .TP
> @@ -1585,14 +1585,14 @@ A revoked key was found or specified.
>  .TP
>  .B ELOOP
>  .I operation
> -is
> +was
>  .BR KEYCTL_LINK
>  and the requested link would cause the maximum nesting depth
>  for keyrings to be exceeded.
>  .TP
>  .BR ENFILE " (Linux kernels before 3.13)"
>  .IR operation
> -is
> +was
>  .BR KEYCTL_LINK
>  and the keyring is full.
>  (Before Linux 3.13,
> @@ -1602,7 +1602,7 @@ a single page of memory; since Linux 3.13, there is no fixed limit.)
>  .TP
>  .B ENOENT
>  .I operation
> -is
> +was
>  .B KEYCTL_UNLINK
>  and the key to be unlinked isn't linked to the keyring.
>  .TP
> @@ -1626,7 +1626,7 @@ a different type was provided.
>  .TP
>  .B EOPNOTSUPP
>  .I operation
> -is
> +was
>  .B KEYCTL_READ
>  and the key type does not support reading
>  (e.g., the type is
> @@ -1634,7 +1634,7 @@ and the key type does not support reading
>  .TP
>  .B EOPNOTSUPP
>  .I operation
> -is
> +was
>  .B KEYCTL_UPDATE
>  and the key type does not support updating.
>  .TP
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
