From: James Morris <jmorris@namei.org>
Date: Fri, 24 May 2019 19:38:39 +0000
Subject: Re: [PATCH 1/7] keys: sparse: Fix key_fs[ug]id_changed()
Message-Id: <alpine.LRH.2.21.1905250538260.7233@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk> <155856409010.10428.11692778420533145488.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856409010.10428.11692778420533145488.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 22 May 2019, David Howells wrote:

> Sparse warnings are incurred by key_fs[ug]id_changed() due to unprotected
> accesses of tsk->cred, which is marked __rcu.
> 
> Fix this by passing the new cred struct to these functions from
> commit_creds() rather than the task pointer.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
