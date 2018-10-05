From: David Howells <dhowells@redhat.com>
Date: Fri, 05 Oct 2018 15:39:43 +0000
Subject: Re: [PATCH 03/22] KEYS: Provide missing asymmetric key subops for new key type ops
Message-Id: <21655.1538753983@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LRH.2.21.1810040503001.16168@namei.org> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618447788.7946.12036865757091293640.stgit@warthog.procyon.org.uk>
In-Reply-To: <alpine.LRH.2.21.1810040503001.16168@namei.org>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, denkenz@gmail.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > +	pr_devel("=>%s()\n", __func__);
> 
> Are you planning on leaving these pr_devel()s in?

Well, they don't do anything unless you #define DEBUG at the top of the file.

If they really offend you, I can remove them.

David
