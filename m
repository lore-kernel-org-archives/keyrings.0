From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Nov 2019 16:22:26 +0000
Subject: Re: [pipe] d60337eff1: BUG:kernel_NULL_pointer_dereference,address
Message-Id: <6853.1573834946@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <9279.1573824532@warthog.procyon.org.uk> <20191110031348.GE29418@shao2-debian>
In-Reply-To: <9279.1573824532@warthog.procyon.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@lists.01.org

Actually, no, this is the fix:

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7006b5b2106d..be2fc5793ddd 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -537,7 +537,7 @@ static size_t push_pipe(struct iov_iter *i, size_t size,
 		buf->ops = &default_pipe_buf_ops;
 		buf->page = page;
 		buf->offset = 0;
-		buf->len = max_t(ssize_t, left, PAGE_SIZE);
+		buf->len = min_t(ssize_t, left, PAGE_SIZE);
 		left -= buf->len;
 		iter_head++;
 		pipe->head = iter_head;

David
