From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Thu, 15 Mar 2018 04:16:44 +0000
Subject: Re: [PATCH] certs/blacklist: fix const confusion
Message-Id: <CAH7mPvjoaDiJmnj9CPNaKD8R=P3+0ESMetxMCWEq6=FgyHEfEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180304065038.28373-1-nick.desaulniers@gmail.com>
In-Reply-To: <20180304065038.28373-1-nick.desaulniers@gmail.com>
To: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>, Nick Desaulniers <nick.desaulniers@gmail.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

bumping for review

On Sat, Mar 3, 2018 at 10:50 PM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> Fixes commit 2be04df5668d ("certs/blacklist_nohashes.c: fix const confusion
> in certs blacklist")
>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  certs/blacklist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/certs/blacklist.h b/certs/blacklist.h
> index 150d82da8e99..1efd6fa0dc60 100644
> --- a/certs/blacklist.h
> +++ b/certs/blacklist.h
> @@ -1,3 +1,3 @@
>  #include <linux/kernel.h>
>
> -extern const char __initdata *const blacklist_hashes[];
> +extern const char __initconst *const blacklist_hashes[];
> --
> 2.14.1
>
