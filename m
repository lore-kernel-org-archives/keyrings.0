From: Stephan Mueller <smueller@chronox.de>
Date: Thu, 31 Aug 2017 16:07:48 +0000
Subject: Re: [RFC PATCH 4/5] keyctl.2: document the ability to provide KDF parameters in KEYCTL_DH_COMPUTE
Message-Id: <1638688.g8nhH00jlV@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170831155836.GA5257@asgard.redhat.com>
In-Reply-To: <20170831155836.GA5257-ZbobWygYI+YXGNroddHbYwC/G2K4zDHf@public.gmane.org>
To: Eugene Syromyatnikov <evgsyr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am Donnerstag, 31. August 2017, 17:58:36 CEST schrieb Eugene Syromyatnikov:

Hi Eugene,

> +field is a null-terminated string no longer than
> +.B CRYPTO_MAX_ALG_NAME
> +(128 bytes as of this writing) which specifies hash name

Is it necessary to specify that size? Note, up to 4.11 it was 64 bytes. Also, 
it must be a valid cipher name as mentioned. Thus, I do not think the size is 
relevant here considering the requirement to use a proper name.

Otherwise, the KDF documentation looks good.

Ciao
Stephan
