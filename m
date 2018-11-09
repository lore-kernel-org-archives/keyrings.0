From: David Howells <dhowells@redhat.com>
Date: Fri, 09 Nov 2018 13:16:23 +0000
Subject: Re: [PATCH] KEYS: revert requiring signature "encoding"
Message-Id: <27927.1541769383@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1541743166-5036-1-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1541743166-5036-1-git-send-email-zohar@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

Mimi Zohar <zohar@linux.ibm.com> wrote:

> Attempting to verify IMA signatures fail causing the system to hang.

Can you say why?

> Fixes: commit 82f94f24475c ("KEYS: Provide software public key query
>        function [ver #2]")

Btw, no word "commit" after Fixes:.

David
