From: David Howells <dhowells@redhat.com>
Date: Fri, 30 Aug 2019 15:54:19 +0000
Subject: Re: [PATCH RESEND] KEYS: pass expiry from X.509 cert to key structure
Message-Id: <12206.1567180459@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <9453.1567178718@warthog.procyon.org.uk>
In-Reply-To: <9453.1567178718@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org

Yihao Wu <wuyihao@linux.alibaba.com> wrote:

> +    prep->expiry = cert->valid_to;

Note that this patch has whitespace breakage, but I can fix that up by hand.

David
