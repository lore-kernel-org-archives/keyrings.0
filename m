From: David Howells <dhowells@redhat.com>
Date: Mon, 02 Sep 2019 07:19:31 +0000
Subject: Re: [PATCH RESEND] KEYS: pass expiry from X.509 cert to key structure
Message-Id: <1380.1567408771@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <9453.1567178718@warthog.procyon.org.uk>
In-Reply-To: <9453.1567178718@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org

Yihao Wu <wuyihao@linux.alibaba.com> wrote:

> Expiry time is not utilized by X.509 cert yet. This patch reads expiry
> from X.509 cert into key_preparsed_payload. Then it is passed to key
> structure when the key is being instantiated.

Thinking on it again, it's more complicated than you think: Unless you can
guarantee that the system clock is correct at time of boot, this may cause the
system to fail to boot.  The certs used for module signing and suchlike may
appear to be expired because the clock is wrong and thus not be usable.

David
