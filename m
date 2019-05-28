From: James Morris <jmorris@namei.org>
Date: Tue, 28 May 2019 20:42:30 +0000
Subject: Re: [PATCH 5/7] keys: Make __key_link_begin() handle lockdep nesting
Message-Id: <alpine.LRH.2.21.1905290642180.31297@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk> <155856411812.10428.4394700002321005951.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856411812.10428.4394700002321005951.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 22 May 2019, David Howells wrote:

> Make __key_link_begin() handle lockdep nesting for the implementation of
> key_move() where we have to lock two keyrings.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>

-- 
James Morris
<jmorris@namei.org>
