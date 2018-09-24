From: David Howells <dhowells@redhat.com>
Date: Mon, 24 Sep 2018 12:00:20 +0000
Subject: Re: [PATCH] Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name"
Message-Id: <26184.1537790420@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180924094723.487697-1-lkundrak@v3.sk>
In-Reply-To: <20180924094723.487697-1-lkundrak@v3.sk>
To: linux-security-module@vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> wrote:

> This changes UAPI, breaking iwd and libell:
> 
>   ell/key.c: In function 'kernel_dh_compute':
>   ell/key.c:205:38: error: 'struct keyctl_dh_params' has no member named 'private'; did you mean 'dh_private'?
>     struct keyctl_dh_params params = { .private = private,
>                                         ^~~~~~~
>                                         dh_private
> 
> This reverts commit 8a2336e549d385bb0b46880435b411df8d8200e8.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: <stable@vger.kernel.org>

Can I stick your Signed-off-by on it?

David
