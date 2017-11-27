From: James Morris <james.l.morris@oracle.com>
Date: Mon, 27 Nov 2017 08:34:40 +0000
Subject: Re: [PATCH] X.509: fix buffer overflow detection in sprint_oid()
Message-Id: <alpine.LFD.2.20.1711271934270.2808@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171127071751.25935-1-ebiggers3@gmail.com>
In-Reply-To: <20171127071751.25935-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org, Alexander Potapenko <glider@google.com>, Eric Biggers <ebiggers@google.com>, Takashi Iwai <tiwai@suse.de>

On Sun, 26 Nov 2017, Eric Biggers wrote:

> 
> Fixes: 4f73175d0375 ("X.509: Add utility functions to render OIDs as strings")
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  lib/oid_registry.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>

