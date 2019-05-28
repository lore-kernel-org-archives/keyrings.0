From: James Morris <jmorris@namei.org>
Date: Tue, 28 May 2019 20:41:44 +0000
Subject: Re: [PATCH 4/7] keys: Break bits out of key_unlink()
Message-Id: <alpine.LRH.2.21.1905290641310.31297@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk> <155856411142.10428.16280282329908085391.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856411142.10428.16280282329908085391.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 22 May 2019, David Howells wrote:

> Break bits out of key_unlink() into helper functions so that they can be
> used in implementing key_move().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
