From: David Howells <dhowells@redhat.com>
Date: Thu, 21 May 2020 14:28:35 +0000
Subject: Re: [PATCH] scrpits: Remove unneeded assignment parentheses
Message-Id: <116524.1590071315@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1590070442.4669.12.camel@HansenPartnership.com> <20200521063226.7434-1-vulab@iscas.ac.cn>
In-Reply-To: <1590070442.4669.12.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: dhowells@redhat.com, Xu Wang <vulab@iscas.ac.cn>, dwmw2@infradead.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > Remove unneeded assignment parentheses.
> 
> I really don't think this is a good idea.  Best practice for macros is
> to parenthesize every argument even if there are technically some cases
> where it's unnecessary because the problems in the majority cases are
> huge and unexpected.

Yep.

David
