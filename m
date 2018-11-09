From: David Howells <dhowells@redhat.com>
Date: Fri, 09 Nov 2018 15:28:57 +0000
Subject: Re: [PATCH] KEYS: revert requiring signature "encoding"
Message-Id: <3613.1541777337@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1541743166-5036-1-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1541743166-5036-1-git-send-email-zohar@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>

Actually, a better solution would be to set the encoding in the caller, say in
asymmetric_verify() in digsig_asymmetric.c.

David
