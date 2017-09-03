From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Sun, 03 Sep 2017 00:19:28 +0000
Subject: Re: [PATCH v2 2/6] keyctl.2: update kernel documentation path reference
Message-Id: <aeb2371e-efd2-49e1-547d-7751ce58d8f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170902044008.GA7402@asgard.redhat.com>
In-Reply-To: <20170902044008.GA7402-ZbobWygYI+YXGNroddHbYwC/G2K4zDHf@public.gmane.org>
To: Eugene Syromyatnikov <evgsyr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/02/2017 06:40 AM, Eugene Syromyatnikov wrote:
> It has been changed in b68101a1e8f0263dbc7b8375d2a7c57c6216fb76.

Applied. Thanks, Eugene.

Cheers,

Michael


> ---
>  man2/keyctl.2 | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/man2/keyctl.2 b/man2/keyctl.2
> index 3469947..e4b4bc9 100644
> --- a/man2/keyctl.2
> +++ b/man2/keyctl.2
> @@ -1992,7 +1992,5 @@ main(int argc, char *argv[])
>  .BR user\-session\-keyring (7),
>  .BR request\-key (8)
>  .PP
> -The kernel source files
> -.IR Documentation/security/keys.txt
> -and
> -.IR Documentation/security/keys\-request\-key.txt .
> +The kernel source files under
> +.IR Documentation/security/keys/ .
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
